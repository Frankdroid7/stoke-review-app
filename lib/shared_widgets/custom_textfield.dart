import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Widget? BuildCounterWidget(
    int? currentLength, int? maxLength, bool? isFocused);

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final bool autoFocus;
  final String? helperText;
  final Widget? suffixIcon;
  TextInputAction? textInputAction;
  Function(String? value)? onFieldSubmitted;
  bool hasLabel;
  bool hasBorder;
  TextStyle? textStyle;
  // BuildCounterWidget? buildCounterWidget;
  bool isNumberOnlyInput;
  Function? validator;
  Function(String value)? onChanged;
  VoidCallback? onTap;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  TextInputType keyboardType;
  bool obscureText;
  bool isPassword;
  bool isReadOnly;
  bool? enabled;
  bool isAmountField;
  String labelText;
  String? hintText;
  Color? labelColor;
  int? maxLength;
  int? maxLines;
  FocusNode? focusNode;
  bool showLabelOrPassword;
  String? initialValue;
  EdgeInsetsGeometry contentPadding;
  TextCapitalization textCapitalization;

  Future<bool>? Function()? verifyInputFromServerFunc;
  bool? Function(String val)?
      whenToVerifyInputFromServer; //If this is true, verifyInputFromServerFunc will be executed
  Function? extraFunctionWhenInputWasVerifiedFromServerSuccessfully;
  Function? extraFunctionWhenInputWasNotVerifiedFromServerSuccessfully;

  CustomTextField({
    this.initialValue,
    this.autoFocus = false,
    this.helperText,
    this.verifyInputFromServerFunc,
    this.whenToVerifyInputFromServer,
    this.extraFunctionWhenInputWasVerifiedFromServerSuccessfully,
    this.extraFunctionWhenInputWasNotVerifiedFromServerSuccessfully,
    this.suffixIcon,
    this.hasBorder = true,
    this.hasLabel = true,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.textStyle,
    this.onTap,
    this.onFieldSubmitted,
    this.controller,
    // this.buildCounterWidget,
    this.showLabelOrPassword = true,
    this.isNumberOnlyInput = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    this.isReadOnly = false,
    this.isAmountField = false,
    this.labelText = "",
    this.hintText = "",
    this.labelColor,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.maxLength,
    this.maxLines = 1,
    this.focusNode,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? inputVerified;
  bool? obscureText;
  bool verifyingInput = false;
  bool? showSuffixIconWhenTryingToValidateInputFromServer;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    if (widget.isPassword) obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.showLabelOrPassword
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.hasLabel
                      ? Text(
                          widget.labelText,
                          style:
                              TextStyle(color: widget.labelColor, fontSize: 14),
                        )
                      : SizedBox.shrink(),
                  widget.hasLabel
                      ? SizedBox(
                          height: 6,
                        )
                      : SizedBox.shrink(),
                ],
              )
            : SizedBox.shrink(),
        widget.hasLabel
            ? SizedBox(
                height: 6,
              )
            : SizedBox.shrink(),
        TextFormField(
          initialValue: widget.initialValue,
          autofocus: widget.autoFocus,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          readOnly: widget.isReadOnly,
          style: widget.textStyle ??
              TextStyle(
                  fontSize: widget.isPassword ? 20 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: widget.isPassword ? 2 : 0),
          cursorWidth: 1.5,
          enabled: widget.enabled,
          textCapitalization: widget.textCapitalization,
          decoration: InputDecoration(
            helperText: widget.helperText,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            suffix: _getSuffixIcon(),
            border: widget.hasBorder ? null : InputBorder.none,
            contentPadding: widget.contentPadding,
            enabledBorder: widget.hasBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )
                : null,
            disabledBorder: widget.hasBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )
                : null,
            focusedBorder: widget.hasBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  )
                : null,
            errorBorder: widget.hasBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  )
                : null,
            focusedErrorBorder: widget.hasBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  )
                : null,
          ),
          inputFormatters: getInputFormatters(),
          validator: (value) {
            if (widget.validator != null) {
              if (widget.isAmountField == true) {
                return widget.validator!(value!.replaceAll(',', ''));
              } else {
                return widget.validator!(value!);
              }
            }
            return null;
          },
          controller: widget.controller,
          keyboardType: getKeyBoardType(widget.keyboardType),
          obscureText: obscureText!,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  TextInputType getKeyBoardType(TextInputType textInputType) {
    TextInputType numberInputType = Platform.isIOS
        ? const TextInputType.numberWithOptions(decimal: true)
        : TextInputType.number;
    if (widget.isAmountField == true || widget.isNumberOnlyInput) {
      return numberInputType;
    }

    if (textInputType == TextInputType.number) {
      return numberInputType;
    }
    return textInputType;
  }

  Widget? _getSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          Icons.remove_red_eye,
          color: widget.obscureText ? Colors.grey : Colors.blue,
        ),
        onPressed: () {
          obscureText = !obscureText!;
          setState(() {});
        },
      );
    }
    return null;
  }

  List<TextInputFormatter>? getInputFormatters() {
    if (widget.isNumberOnlyInput) {
      return [FilteringTextInputFormatter.digitsOnly];
    } else {
      return widget.inputFormatters;
    }
  }
}
