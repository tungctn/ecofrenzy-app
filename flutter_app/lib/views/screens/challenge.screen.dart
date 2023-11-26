import 'package:flutter/material.dart';
import 'package:flutter_app/provider/actions/challenge.action.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:flutter_app/views/components/challenge/challenge.list.dart';
import 'package:flutter_app/utils/color.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:provider/provider.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});
  @override
  ChallengeScreenState createState() => ChallengeScreenState();
}

class ChallengeScreenState extends State<ChallengeScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadChallenges();
  }

  void loadChallenges() async {
    await ChallengeActions.fetchChallenges(context.read<ChallengeNotifier>());
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeNotifier>(
      builder: (context, notifier, _) {
        if (_isLoading) {
          return const Loading();
        }
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              margin: const EdgeInsets.only(
                  bottom: 20, top: 20, left: 20, right: 20),
              width: 380,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: -getGradientRotate(62.7),
                  end: getGradientRotate(62.7),
                  stops: const [
                    0.0686,
                    0.1614,
                    0.2541,
                    0.3469,
                    0.4396,
                    0.5324,
                    0.6251,
                    0.7179,
                    0.8106,
                    0.9034,
                    0.9961,
                    1.0889,
                    1.1816,
                    1.2744,
                    1.3671,
                    1.4599,
                    1.5526,
                  ],
                  colors: const [
                    Color(0xB343FE2E),
                    Color(0xB3A8E800),
                    Color(0xB3E0CF00),
                    Color(0xB3FFB300),
                    Color(0xB3FF9400),
                    Color(0xB3FF753A),
                    Color(0xB3FF5760),
                    Color(0xB3FF3B80),
                    Color(0xB3FF279D),
                    Color(0xB3FF22B6),
                    Color(0xB3FF2BCB),
                    Color(0xB3FF37DC),
                    Color(0xB3FF42EA),
                    Color(0xB3FF4AF3),
                    Color(0xB3F950FA),
                    Color(0xB3F453FE),
                    Color(0xB3F254FF),
                  ],
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              ),
              child: const Text(
                "Challenges from your friends",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF220A4F),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0, // Đặt ràng buộc cho chiều rộng ở đây
                    top: 0,
                    bottom: 0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 0, bottom: 0),
                      child: ChallengeList(
                        challenges: notifier.challenges,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
