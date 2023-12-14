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
            child: Column(children: [
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
                    'Quên mật khẩu',
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
                    style: TypeInputCard.email,
                    onchange: (String value) {
                      email = value;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                ButtonWidget(
                  title: 'Gửi email',
                  ontap: () {},
                ),
                const SizedBox(
                  height: 20,
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
                                  .setColor(Color.fromARGB(255, 255, 255, 255))
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
        ]))
      ]),
    );
  }
}
