import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/toast_utils.dart';
import 'package:flutter_app/provider/actions/auth.action.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/views/layouts/navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app/helpers/local_storage_helper.dart';
import 'package:flutter_app/helpers/loginManager/login_facebook_manager.dart';
import 'package:flutter_app/helpers/loginManager/login_google_manager.dart';
import 'package:flutter_app/views/screens/auth/forgot_password.screen.dart';
import 'package:flutter_app/views/screens/auth/sign_up.screen.dart';
import 'package:flutter_app/views/components/shared/app_bar_container.dart';
import 'package:flutter_app/views/components/shared/button_icon_widget.dart';
import 'package:flutter_app/views/components/shared/button_widget.dart';
import 'package:flutter_app/views/components/shared/input_card.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/core/constants/dismention_constants.dart';
import 'package:flutter_app/core/constants/textstyle_constants.dart';
import 'package:flutter_app/utils/icon.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = "";
  String password = "";
  String token = "";
  bool rememberMe = true;

  Future<String> _fillEmail() async {
    if (await LocalStorageHelper.getValue("email") != null) {
      return await LocalStorageHelper.getValue("email");
    } else {
      return "";
    }
  }

  Future<String> _fillPassword() async {
    if (await LocalStorageHelper.getValue("password") != null) {
      return await LocalStorageHelper.getValue("password");
    } else {
      return "";
    }
  }

  void handleSignIn() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    Map<String, dynamic> response =
        await AuthActions.login(context.read<AuthNotifier>(), email, password);
    Loading.dismiss(context);

    if (response["errors"]) {
      ToastUtils.showToast(context, response["message"], TypeToast.error);
      setState(() {});
    } else {
      ToastUtils.showToast(context, response["message"], TypeToast.success);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Navigation()));
    }
  }

  @override
  void initState() {
    super.initState();
    // _fillEmail();
    // _fillPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, notifier, _) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Đăng nhập',
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
                                },
                                value: email,
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            StatefulBuilder(
                              builder: (context, setState) => InputCard(
                                  style: TypeInputCard.password,
                                  onchange: (String value) {
                                    password = value;
                                  },
                                  value: password),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StatefulBuilder(builder: (context, setState) {
                                  return GestureDetector(
                                    onTap: () {
                                      rememberMe = !rememberMe;
                                      setState(() {
                                        // LoginManager().remember(rememberMe);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(
                                              kDefaultPadding / 1.3),
                                          decoration: BoxDecoration(
                                            color: ColorPalette
                                                .cardBackgroundColor,
                                            borderRadius: BorderRadius.circular(
                                                kDefaultPadding / 2),
                                            border: Border.all(
                                              color: ColorPalette
                                                  .primaryColor, // Màu đỏ
                                              width: 1.0, // Độ dày 1px
                                            ),
                                          ),
                                          child: rememberMe
                                              // ignore: prefer_const_constructors
                                              ? Icon(
                                                  FontAwesomeIcons.check,
                                                  color:
                                                      ColorPalette.primaryColor,
                                                  size: kDefaultTextSize / 1.4,
                                                )
                                              : Container(),
                                        ),
                                        const SizedBox(
                                          width: kDefaultPadding / 2,
                                        ),
                                        Text(
                                          "Lưu thông tin",
                                          style: TextStyles
                                              .defaultStyle.light.blackTextColor
                                              .setTextSize(
                                                  kDefaultTextSize / 1.2),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordScreen()));
                                  },
                                  child: SizedBox(
                                    height: 22,
                                    child: Text(
                                      "Quên mật khẩu",
                                      style: TextStyles.defaultStyle.light
                                          .setColor(Color.fromARGB(
                                              255, 255, 255, 255))
                                          .setTextSize(18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: kDefaultPadding,
                            ),
                            ButtonWidget(
                              title: "Đăng nhập",
                              ontap: () async {
                                // if (rememberMe == true) {
                                //   LocalStorageHelper.setValue("email", email);
                                //   LocalStorageHelper.setValue("password", password);
                                // } else {
                                //   LocalStorageHelper.deleteValue("email");
                                //   LocalStorageHelper.deleteValue("password");
                                // }
                                // print(email);
                                // print(password);
                                Loading.show(context);
                                handleSignIn();
                              },
                            ),
                            const SizedBox(
                              height: kDefaultPadding,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Bạn không có tài khoản hãy ",
                                      style: TextStyles
                                          .defaultStyle.blackTextColor
                                          .setTextSize(kDefaultTextSize),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpScreen()));
                                      },
                                      child: SizedBox(
                                        height: 26,
                                        child: Text(
                                          "Đăng ký",
                                          style: TextStyles.defaultStyle.bold
                                              .setColor(Color.fromARGB(
                                                  255, 255, 255, 255))
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
                      ),
                    )
                  ],
                ),
              )
            ],
          ));
    });
  }
}
