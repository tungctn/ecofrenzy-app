import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_app/core/utils/toast_utils.dart';
import 'package:flutter_app/models/challenge.dart';
import 'package:flutter_app/provider/actions/challenge.action.dart';
import 'package:flutter_app/provider/actions/post.action.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/services/image.service.dart';
import 'package:flutter_app/utils/icon.dart';
import 'package:flutter_app/views/components/challenge/challenge_camera.card.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/utils/constants.dart';

class ChallengeDetectorView extends StatefulWidget {
  const ChallengeDetectorView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChallengeDetectorViewState createState() => _ChallengeDetectorViewState();
}

class _ChallengeDetectorViewState extends State<ChallengeDetectorView> {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  bool _isLoading = false;
  final challengeNotifier = ChallengeNotifier();
  final postNotifier = PostNotifier();
  int _selectedCameraIdx = 0;
  final navigator = const Navigator();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    // if (cameras.isNotEmpty) {
    _controller = CameraController(
      cameras[_selectedCameraIdx],
      ResolutionPreset.medium,
    );

    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    // } else {
    //   print("No camera available!");
    // }
  }

  Future<void> _takePicture(Challenge challenge) async {
    if (!_controller!.value.isInitialized) {
      print("Error: Camera is not initialized!");
      return;
    }

    try {
      XFile file = await _controller!.takePicture();
      print(file.path);
      setState(() {
        _isLoading = true;
      });
      await uploadImageToServer(file.path, challenge.id, challenge);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onSwitchCamera() async {
    // print("Switching camera!");
    // print(cameras.length);
    print(_selectedCameraIdx);

    _selectedCameraIdx = _selectedCameraIdx == 1 ? 0 : 1;
    setState(() {
      _selectedCameraIdx = _selectedCameraIdx;
    });
    _initializeCamera();

    // CameraDescription selectedCamera = cameras[_selectedCameraIdx];

    // if (_controller!.value.isInitialized) {
    //   await _controller?.dispose();
    // }

    // setState(() {
    //   _controller = CameraController(
    //     selectedCamera,
    //     ResolutionPreset.medium,
    //   );
    // });

    // _controller?.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
  }

  Future<void> _onClickFlash() async {
    print("click falsh!");
    if (_controller?.value.flashMode == FlashMode.off) {
      await _controller?.setFlashMode(FlashMode.torch);
    } else {
      await _controller?.setFlashMode(FlashMode.off);
    }
  }

  // pick image from gallery
  Future<void> _pickImage(Challenge challenge) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _isLoading = true;
    });
    await uploadImageToServer(image.path, challenge.id, challenge);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> uploadImageToServer(
      String filePath, String challengeId, Challenge challenge) async {
    // var uri = Uri.parse(
    //     "https://vqgadqmdoc.execute-api.ap-southeast-1.amazonaws.com/prod/api/upload");
    // // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var request = http.MultipartRequest('POST', uri)
    //   // ..headers.addAll({'Authorization': 'Bearer $token'})
    //   ..files.add(await http.MultipartFile.fromPath(
    //     'image',
    //     filePath,
    //     contentType: MediaType('image', 'jpg'),
    //   ));

    // var streamedResponse = await request.send();
    // var response = await http.Response.fromStream(streamedResponse);
    var urlImage = await ImageService().uploadImageToServer(filePath);
    print(urlImage);
    if (urlImage != null) {
      var predictResponse =
          await ImageService().predictImage(urlImage, challenge);
      print(predictResponse['success']);
      if (predictResponse['success']) {
        ToastUtils.showToast(
            context, "Chúc mừng bạn đã hoàn thành nhiệm vụ", TypeToast.success);

        final post = {
          "image": urlImage,
          "challengeId": challenge.id.toString(),
        };
        print(post);
        Navigator.pop(context);
        ChallengeActions.doneChallenge(
            challengeNotifier, challengeId, post['image'], postNotifier);
        PostActions.createPost(
            postNotifier, post['image'], post['challengeId']);
      } else {
        ToastUtils.showToast(
            context, predictResponse["message"], TypeToast.error);
      }
    } else {
      ToastUtils.showToast(context, "Upload image failed", TypeToast.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 7,
        ),
      );
    }

    return Consumer<ChallengeNotifier>(builder: (context, notifier, _) {
      Iterable<Challenge> challengePicked =
          notifier.challenges.where((e) => e.status != "UnPicked");

      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CameraPreview(_controller!),
            _backButton(),
            _challengeDescription(challengePicked.first),
            _cameraAltButton(challengePicked.first),
            _isLoading ? _loadingWidget() : const SizedBox.shrink(),
            _flashCameraButton(),
            // _imageCameraButton(challengePicked.first),
            _toggleCameraButton(),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _backButton() => Positioned(
        top: 40,
        left: 8,
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: IconButton(
            icon: backIcon,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      );
  Widget _challengeDescription(Challenge challengePicked) => Positioned(
      bottom: 140,
      left: 5,
      right: 5,
      child: ChallengeCameraCard(challenge: challengePicked));

  Widget _cameraAltButton(Challenge challenge) => Positioned(
      bottom: 20,
      left: 40,
      right: 40,
      child: SizedBox(
        height: 100,
        width: 100,
        child: IconButton(
          icon: cameraAltIcon,
          onPressed: (() => {_takePicture(challenge)}),
        ),
      ));
  Widget _loadingWidget() => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          color: Colors.black45, // Màu đen với độ trong suốt 45% để làm mờ nền
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 7,
            ),
          ),
        ),
      );
  Widget _toggleCameraButton() => Positioned(
        bottom: 40,
        right: 20,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          height: 60,
          width: 60,
          child: IconButton(
            icon: const Icon(Icons.cameraswitch, size: 40),
            onPressed: _onSwitchCamera,
          ),
        ),
      );

  Widget _flashCameraButton() => Positioned(
        bottom: 40,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          height: 60,
          width: 60,
          child: IconButton(
            icon: Icon(Icons.bolt, size: 40),
            onPressed: _onClickFlash,
          ),
        ),
      );
  // get image from camera
  // Widget _imageCameraButton(Challenge challenge) => Positioned(
  //       bottom: 40,
  //       left: 20,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(50),
  //         ),
  //         height: 60,
  //         width: 60,
  //         child: IconButton(
  //           icon: const Icon(Icons.bolt, size: 40),
  //           onPressed: () => _pickImage(challenge),
  //         ),
  //       ),
  //     );
}
