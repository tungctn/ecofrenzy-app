import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/views/components/shared/app_bar_container.dart';
import 'package:flutter_app/views/components/shared/button_widget.dart';
import 'package:flutter_app/views/components/shared/input_card.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/core/constants/dismention_constants.dart';
import 'package:flutter_app/core/constants/textstyle_constants.dart';

import './sign_in.screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = "";

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: "Forgot password",
      // ignore: prefer_const_literals_to_create_immutables
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.jpg', // Đường dẫn đúng đến tệp hình ảnh trong thư mục assets
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: kDefaultPadding * 5,
          ),
          StatefulBuilder(
            builder: (context, setState) => InputCard(
              style: TypeInputCard.email,
              onchange: (String value) {
                email = value;
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          ButtonWidget(
            title: 'Send',
            ontap: () {
              Loading.show(context);
              // LoginManager().forgotPassword(email).then((value) => {
              //       debugPrint("value forgot password $value"),
              //       Loading.dismiss(context),
              //       if (value == true)
              //         {
              //           Loading.dismiss(context),
              //           // showDialog(
              //           //     context: context,
              //           //     builder: (BuildContext context) {
              //           //       return VerificationCode(email: email);
              //           //     }),
              //         }
              //       else if (value == 500)
              //         {
              //           Loading.dismiss(context),
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) => AlertDialog(
              //               title: const Text('YOU MUST ENTER YOUR EMAIL'),
              //               content: const Text(''),
              //               actions: <Widget>[
              //                 TextButton(
              //                   onPressed: () =>
              //                       Navigator.pop(context, 'Cancel'),
              //                   child: const Text('Cancel'),
              //                 ),
              //                 TextButton(
              //                   onPressed: () => Navigator.pop(context, 'OK'),
              //                   child: const Text('OK'),
              //                 ),
              //               ],
              //             ),
              //           )
              //         }
              //       else if (value == 400 || value == 404)
              //         {
              //           Loading.dismiss(context),
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) => AlertDialog(
              //               title: const Text('No user found with this email'),
              //               content: const Text(''),
              //               actions: <Widget>[
              //                 TextButton(
              //                   onPressed: () =>
              //                       Navigator.pop(context, 'Cancel'),
              //                   child: const Text('Cancel'),
              //                 ),
              //                 TextButton(
              //                   onPressed: () => Navigator.pop(context, 'OK'),
              //                   child: const Text('OK'),
              //                 ),
              //               ],
              //             ),
              //           )
              //         },
              //       Loading.dismiss(context)
              //     });
            },
          )
        ],
      ),
    );
  }
}
