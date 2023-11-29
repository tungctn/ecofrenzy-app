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
      return AppBarContainer(
        titleString: "Sign In",
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
                height: kDefaultPadding * 5,
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
                height: kDefaultPadding * 2,
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
                height: kDefaultPadding * 2,
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
                            padding:
                                const EdgeInsets.all(kDefaultPadding / 1.3),
                            decoration: BoxDecoration(
                              color: ColorPalette.cardBackgroundColor,
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding / 2),
                              border: Border.all(
                                color: ColorPalette.primaryColor, // Màu đỏ
                                width: 1.0, // Độ dày 1px
                              ),
                            ),
                            child: rememberMe
                                // ignore: prefer_const_constructors
                                ? Icon(
                                    FontAwesomeIcons.check,
                                    color: ColorPalette.primaryColor,
                                    size: kDefaultTextSize / 1.4,
                                  )
                                : Container(),
                          ),
                          const SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                          Text(
                            "Remember Me",
                            style: TextStyles.defaultStyle.light.blackTextColor
                                .setTextSize(kDefaultTextSize / 1.2),
                          ),
                        ],
                      ),
                    );
                  }),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName);
                    },
                    child: SizedBox(
                      height: 22,
                      child: Text(
                        "Forgot Password",
                        style: TextStyles.defaultStyle.light.blackTextColor
                            .setTextSize(kDefaultTextSize / 1.2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              ButtonWidget(
                title: "Sign In",
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: ColorPalette.lightGray,
                    ),
                  ),
                  const SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  Text(
                    "Or Login With",
                    style: TextStyles.defaultStyle.blackTextColor
                        .setTextSize(kDefaultTextSize / 1.1),
                  ),
                  const SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: ColorPalette.lightGray,
                    ),
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
                      ontap: () {
                        LoginGoogleManager().signInWithGoogle().then((value) {
                          Loading.show(context);
                          if (value != null) {
                            // LoginManager()
                            //     .signInWithGoogle(value)
                            //     .then((result) => {
                            //           if (result.runtimeType == int)
                            //             {
                            //               showDialog(
                            //                 context: context,
                            //                 builder: (BuildContext context) =>
                            //                     AlertDialog(
                            //                   title: const Text(
                            //                       'ERROR YOUR PASSWORD'),
                            //                   content: const Text(
                            //                       'Your password or email is wrong, please re-enter'),
                            //                   actions: <Widget>[
                            //                     TextButton(
                            //                       onPressed: () => Navigator.pop(
                            //                           context, 'Cancel'),
                            //                       child: const Text('Cancel'),
                            //                     ),
                            //                     TextButton(
                            //                       onPressed: () => Navigator.pop(
                            //                           context, 'OK'),
                            //                       child: const Text('OK'),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               )
                            //             }
                            //           else if (result['success'] == true)
                            //             {
                            //               LocalStorageHelper.setValue("roleId",
                            //                   result['data']['role_id']),
                            //               if (result['data']['role_id'] == 2)
                            //                 Navigator.popAndPushNamed(
                            //                     context, "/")
                            //               else
                            //                 {
                            //                   Navigator.popAndPushNamed(
                            //                       context, "/")
                            //                 }
                            //             }
                            //         });
                          } else {
                            Loading.dismiss(context);
                          }
                        });
                        // Navigator.of(context).pushNamed(MainScreen.routeName);
                      },
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Expanded(
                    flex: 1,
                    child: ButtonIconWidget(
                      title: 'Facebook',
                      backgroundColor: const Color(0xff3C5A9A),
                      textColor: const Color(0xffffffff),
                      icon: const Icon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                      ),
                      ontap: () async {
                        LoginFacebookManager()
                            .signInWithFacebook()
                            .then((value) {
                          Loading.show(context);
                          if (value != null) {
                            // LoginManager()
                            //     .signInWithFacebook(value)
                            //     .then((result) => {
                            //           if (result.runtimeType == int)
                            //             {
                            //               showDialog(
                            //                 context: context,
                            //                 builder: (BuildContext context) =>
                            //                     AlertDialog(
                            //                   title: const Text(
                            //                       'ERROR YOUR PASSWORD'),
                            //                   content: const Text(
                            //                       'Your password or email is wrong, please re-enter'),
                            //                   actions: <Widget>[
                            //                     TextButton(
                            //                       onPressed: () => Navigator.pop(
                            //                           context, 'Cancel'),
                            //                       child: const Text('Cancel'),
                            //                     ),
                            //                     TextButton(
                            //                       onPressed: () => Navigator.pop(
                            //                           context, 'OK'),
                            //                       child: const Text('OK'),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               )
                            //             }
                            //           else if (result['success'] == true)
                            //             {
                            //               LocalStorageHelper.setValue("roleId",
                            //                   result['data']['role_id']),
                            //               Loading.dismiss(context),
                            //               if (result['data']['role_id'] == 2)
                            //                 Navigator.popAndPushNamed(
                            //                     context, "/")
                            //               else
                            //                 {
                            //                   Navigator.popAndPushNamed(
                            //                       context, "/")
                            //                 }
                            //             }
                            //         });
                          } else {
                            Loading.dismiss(context);
                          }
                        });
                      },
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
                        "Don't have account ",
                        style: TextStyles.defaultStyle.blackTextColor
                            .setTextSize(kDefaultTextSize),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: SizedBox(
                          height: 22,
                          child: Text(
                            "Sign Up",
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
    });
  }
}
