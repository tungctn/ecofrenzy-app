import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/core/constants/dismention_constants.dart';
import 'package:flutter_app/core/constants/textstyle_constants.dart';
import 'package:flutter_app/views/screens/auth/sign_in.screen.dart';
import 'package:flutter_app/views/components/shared/app_bar_container.dart';
import 'package:flutter_app/views/components/shared/button_icon_widget.dart';
import 'package:flutter_app/views/components/shared/button_widget.dart';
import 'package:flutter_app/views/components/shared/input_card.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:flutter_app/views/components/shared/line_widget.dart';
import 'package:flutter_app/utils/icon.dart';

/*
...
...Đã làm chuyển ngữ
*/
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String passwordConfirmation = "";
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: "Sign Up",
      // ignore: prefer_const_literals_to_create_immutables
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg', // Đường dẫn đúng đến tệp hình ảnh trong thư mục assets
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
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
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.password,
                onchange: (String value) {
                  password = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.passwordConfirm,
                onchange: (String value) {
                  passwordConfirmation = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            ButtonWidget(
              title: "Sign Up",
              ontap: () {
                Loading.show(context);
                //   _controller
                //       ?.signByPassWord(email, password, passwordConfirmation)
                //       .then((value) => {
                //             Loading.dismiss(context),
                //             if (value['success'] == true)
                //               {
                //                 AwesomeDialog(
                //                   context: context,
                //                   dialogType: DialogType.success,
                //                   animType: AnimType.topSlide,
                //                   title: LocalizationText.signUpSuccess,
                //                   desc: value['message'],
                //                   btnOkOnPress: () {
                //                     Navigator.popAndPushNamed(
                //                         context, SignInScreen.routeName);
                //                   },
                //                 ).show()
                //               }
                //             else if (value['result'] == 'false')
                //               {
                //                 Loading.dismiss(context),
                //                 AwesomeDialog(
                //                   context: context,
                //                   dialogType: DialogType.warning,
                //                   animType: AnimType.topSlide,
                //                   title: LocalizationText.errPassOrEmail,
                //                   desc: value['data']['email'] != null
                //                       ? '${LocalizationText.email}: ${value['data']['email']}'
                //                       : value['data']['password'] != null
                //                           ? '${value['data']['password']}'
                //                           : "",
                //                   btnOkOnPress: () {},
                //                 ).show(),
                //                 // showDialog(
                //                 //   context: context,
                //                 //   builder: (BuildContext context) => AlertDialog(
                //                 //     title: Text(LocalizationText.errPassOrEmail),
                //                 //     content: Container(
                //                 //       height: 120.0,
                //                 //       color: Colors.yellow,
                //                 //       child: Column(
                //                 //         crossAxisAlignment:
                //                 //             CrossAxisAlignment.start,
                //                 //         children: [
                //                 //           value['data']['email'] != null
                //                 //               ? Text(
                //                 //                   '${LocalizationText.email}: ${value['data']['email']}')
                //                 //               : SizedBox(
                //                 //                   height: kDefaultPadding,
                //                 //                 ),
                //                 //           value['data']['email'] != null
                //                 //               ? Text(
                //                 //                   '${LocalizationText.password}: ${value['data']['password']}')
                //                 //               : SizedBox(
                //                 //                   height: 0,
                //                 //                 )
                //                 //         ],
                //                 //       ),
                //                 //     ),
                //                 //     actions: <Widget>[
                //                 //       TextButton(
                //                 //         onPressed: () => Navigator.pop(
                //                 //             context, LocalizationText.cancel),
                //                 //         child: Text(LocalizationText.ok),
                //                 //       ),
                //                 //       TextButton(
                //                 //         onPressed: () => Navigator.pop(
                //                 //             context, LocalizationText.ok),
                //                 //         child: Text(LocalizationText.ok),
                //                 //       ),
                //                 //     ],
                //                 //   ),
                //                 // )
                //               }
                //             else
                //               {
                //                 Loading.dismiss(context),
                //                 AwesomeDialog(
                //                   context: context,
                //                   dialogType: DialogType.warning,
                //                   animType: AnimType.topSlide,
                //                   title: LocalizationText.nullResponse,
                //                   desc: value['message'],
                //                   btnOkOnPress: () {},
                //                 ).show()
                //               },
                //           });
              },
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Line(
                  width: 90,
                ),
                const SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Text(
                  "Option sign up",
                  style: TextStyles.defaultStyle.blackTextColor
                      .setTextSize(kDefaultTextSize / 1.1),
                ),
                const SizedBox(
                  width: kDefaultPadding / 2,
                ),
                const Line(
                  width: 90,
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Expanded(
                  flex: 1,
                  child: ButtonIconWidget(
                    title: 'Google',
                    backgroundColor: ColorPalette.cardBackgroundColor,
                    textColor: ColorPalette.blackTextColor,
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: ColorPalette.primaryColor,
                      size: kDefaultTextSize,
                    ),
                    ontap: () {},
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),
                Expanded(
                  flex: 1,
                  child: ButtonIconWidget(
                    title: 'Facebook',
                    backgroundColor: Color(0xff3C5A9A),
                    textColor: Color(0xffffffff),
                    icon: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                    ),
                    ontap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "You have account ",
                      style: TextStyles.defaultStyle.blackTextColor
                          .setTextSize(kDefaultTextSize),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, SignUpScreen.routeName);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: SizedBox(
                        height: 20,
                        child: Text(
                          "Sign In",
                          style: TextStyles.defaultStyle.primaryTextColor.bold
                              .setTextSize(kDefaultTextSize),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
