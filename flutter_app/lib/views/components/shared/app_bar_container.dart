import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/core/constants/dismention_constants.dart';
import 'package:flutter_app/core/constants/textstyle_constants.dart';

class AppBarContainer extends StatelessWidget {
  AppBarContainer({
    super.key,
    required this.child,
    this.title,
    this.titleString,
    this.widget,
    this.drawer,
    this.backGroundColor,
    this.onPressTrailing,
    this.onPressLeading,
    this.useFilter = false,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget? title;
  final String? titleString;
  final Widget child;
  final Widget? widget;
  final bool useFilter;
  final Widget? drawer;
  final Color? backGroundColor;
  final Function()? onPressTrailing;
  final Function()? onPressLeading;
  final bool? resizeToAvoidBottomInset;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backGroundColor,
      body: Stack(
        children: [
          SizedBox(
            height: 100,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: ColorPalette.backgroundScaffoldColor,
              title: title ??
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(top: kDefaultPadding * 0.5),
                          child: Center(
                            child: Column(children: [
                              Text(
                                titleString ?? '',
                                style: TextStyles
                                    .defaultStyle.bold.whiteTextColor
                                    .setTextSize(26),
                                maxLines: 3,
                              ),
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: Gradients.defaultGradientBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 5.5),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: child,
          )
        ],
      ),
    );
  }

  void _displayDrawer(BuildContext context) {
    _scaffoldKey.currentState?.openDrawer();
  }
}
