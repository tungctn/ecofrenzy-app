import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_app/core/utils/toast_utils.dart';
import 'package:flutter_app/provider/actions/auth.action.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
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
import 'package:provider/provider.dart';

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
  String name = "";
  final authNotifier = AuthNotifier();

  void handleRegister(context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    Loading.show(context);
    Map<String, dynamic> jsonResponse =
        await AuthActions.register(authNotifier, name, email, password);
    Loading.dismiss(context);

    if (jsonResponse["errors"]) {
      ToastUtils.showToast(
          context, "Email already exists in the system", TypeToast.error);
    } else {
      ToastUtils.showToast(context, "Register success", TypeToast.success);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Container(
          child: Image.asset(
            'assets/images/background_color.png',
            fit: BoxFit.cover,
          ),
          width: double.infinity,
          height: double.infinity,
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/auth_background.png', // Đường dẫn đúng đến tệp hình ảnh trong thư mục assets
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                          color: Color(0xFF2B2945),
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          height: 0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => InputCard(
                        style: TypeInputCard.name,
                        onchange: (String value) {
                          name = value;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 20,
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
                      height: 20,
                    ),
                    ButtonWidget(
                      title: "Đăng ký",
                      ontap: () {
                        handleRegister(context);
                      },
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
                              "Bạn đã có tài khoản hãy ",
                              style: TextStyles.defaultStyle.blackTextColor
                                  .setTextSize(kDefaultTextSize),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, SignUpScreen.routeName);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen()));
                              },
                              child: SizedBox(
                                height: 26,
                                child: Text(
                                  "Đăng nhập",
                                  style: TextStyles.defaultStyle.bold
                                      .setColor(
                                          Color.fromARGB(255, 255, 255, 255))
                                      .setTextSize(20),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
