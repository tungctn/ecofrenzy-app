import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/core/constants/dismention_constants.dart';
import 'package:flutter_app/core/constants/textstyle_constants.dart';

enum TypeInputCard {
  firstName,
  lastName,
  name,
  email,
  password,
  passwordConfirm,
  phoneNumber,
  verificationCode,
  dateOfBirth
}

class InputCard extends StatefulWidget {
  InputCard({
    super.key,
    required this.style,
    required this.onchange,
    this.value,
  });

  final TypeInputCard style;
  final Function onchange;
  String? value = "";

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  dynamic value;
  late final TextEditingController? _textController;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    focusNode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    TypeInputCard? style = widget.style;
    if (widget.value != null) {
      _textController?.text = widget.value ?? "";
    }
    bool showPassword = true;

    Widget widgetToDisplay;

    switch (style) {
      // case 'First Name':
      // case 'Last Name':

      case TypeInputCard.firstName:
        widgetToDisplay = TextField(
          focusNode: focusNode,
          controller: _textController,
          decoration: InputDecoration(
            labelText: "First name",
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;
      case TypeInputCard.name:
        widgetToDisplay = TextField(
          focusNode: focusNode,
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Name",
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;
      case TypeInputCard.email:
        widgetToDisplay = TextField(
          focusNode: focusNode,
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Email",
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;

      case TypeInputCard.lastName:
        widgetToDisplay = TextField(
          focusNode: focusNode,
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Last name",
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;
      case TypeInputCard.phoneNumber:
        widgetToDisplay = TextField(
          focusNode: focusNode,
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Phone number",
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;
      case TypeInputCard.dateOfBirth:
        widgetToDisplay = TextField(
          focusNode: focusNode,
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Date of birth",
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;
      case TypeInputCard.password:
        widgetToDisplay = StatefulBuilder(builder: (context, setState) {
          return TextField(
            focusNode: focusNode,
            controller: _textController,
            decoration: InputDecoration(
              labelText: "Password",
              border: InputBorder.none,
              labelStyle: TextStyles.defaultStyle.blackTextColor.light
                  .setTextSize(kDefaultTextSize / 1.1),
              suffixIcon: IconButton(
                onPressed: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                icon: Icon(showPassword
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye),
              ),
            ),
            style: TextStyles.defaultStyle.blackTextColor.bold
                .setTextSize(kDefaultTextSize * 1.2),
            onChanged: (String query) {
              value = _textController?.text;
              widget.onchange(value);
            },
            obscureText: showPassword,
          );
        });
        break;
      case TypeInputCard.passwordConfirm:
        widgetToDisplay = StatefulBuilder(builder: (context, setState) {
          return TextField(
            focusNode: focusNode,
            controller: _textController,
            decoration: InputDecoration(
              labelText: "Password confirm",
              border: InputBorder.none,
              labelStyle: TextStyles.defaultStyle.blackTextColor.light
                  .setTextSize(kDefaultTextSize / 1.1),
              suffixIcon: IconButton(
                onPressed: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                icon: Icon(showPassword
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye),
              ),
            ),
            style: TextStyles.defaultStyle.blackTextColor.bold
                .setTextSize(kDefaultTextSize * 1.2),
            onChanged: (String query) {
              value = _textController?.text;
              widget.onchange(value);
            },
            obscureText: showPassword,
          );
        });
        break;

      case TypeInputCard.verificationCode:
        widgetToDisplay = TextField(
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Verification Code",
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;

      default:
        widgetToDisplay = Text('Other');
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 1.4, vertical: kDefaultPadding / 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: ColorPalette.cardBackgroundColor,
        border: Border.all(
          color: ColorPalette.primaryColor, // Màu đỏ
          width: 1.0, // Độ dày 1px
        ),
      ),
      child: widgetToDisplay,
    );
  }
}
