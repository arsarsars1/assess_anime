import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustom extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmit;
  final ValueChanged<String>? onChange;
  final String? hintText;
  final String? helperText;
  final TextStyle? style;
  final int maxLines;
  final GestureTapCallback? onTapSuffixIcon;
  final GestureTapCallback? onTapPrefixIcon;
  final IconData? suffixIconData;
  final IconData? prefixIconData;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final Color hintTextColor;
  final Color borderColor;
  final Color disableBorderColor;
  final Color cursorColor;
  final Color textColor;
  final Color prefixIconColor;
  final bool enabled;
  final int? maxLength;
  final bool readOnly;
  final bool isCircle;
  final EdgeInsets padding;
  final Color sufixIconColor;
  final TextInputType keyboardType;
  final bool obscureText;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;

  const TextFieldCustom(
      {super.key,
      this.title,
      this.enabled = true,
      this.readOnly = false,
      required this.controller,
      this.maxLines = 1,
      this.validator,
      this.style,
      this.maxLength,
      this.onFieldSubmit,
      this.textInputAction = TextInputAction.done,
      this.onChange,
      this.hintText,
      this.helperText,
      this.onTapSuffixIcon,
      this.suffixIconData,
      this.prefixIconData,
      this.onTapPrefixIcon,
      this.focusNode,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      this.hintTextColor = const Color(0xff8A8A8A),
      this.cursorColor = Colors.white,
      this.borderColor = const Color(0xffeeeded),
      this.disableBorderColor = const Color(0xff9a9999),
      this.textColor = Colors.white,
      this.prefixIconColor = Colors.white,
      this.sufixIconColor = Colors.white,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.isCircle = true,
      this.inputFormatters,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enabled,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        validator: validator,
        keyboardType: keyboardType,
        cursorWidth: 1,
        maxLines: maxLines,
        obscureText: obscureText,
        cursorColor: cursorColor,
        autofocus: false,
        textInputAction: textInputAction,
        maxLength: maxLength,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        style: style ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
                color: readOnly ? Colors.grey : textColor),
        onFieldSubmitted: onFieldSubmit,
        onChanged: onChange,
        decoration: decoration ??
            InputDecoration(
                labelText: title,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: hintTextColor), //const Color(0xff8A8A8A)),
                helperText: helperText,
                helperMaxLines: 3,
                helperStyle: const TextStyle(color: Colors.white, fontSize: 15),
                contentPadding: padding,
                suffixIcon: suffixIconData == null
                    ? null
                    : GestureDetector(
                        onTap: onTapSuffixIcon,
                        child: Icon(suffixIconData, color: sufixIconColor)),
                prefixIcon: prefixIconData == null
                    ? null
                    : GestureDetector(
                        onTap: onTapPrefixIcon,
                        child: Icon(prefixIconData, color: prefixIconColor)),
                focusedBorder: isCircle
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: borderColor))
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                focusedErrorBorder: isCircle
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: borderColor))
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                enabledBorder: isCircle
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: borderColor))
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                disabledBorder: isCircle
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: disableBorderColor))
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: disableBorderColor)),
                errorBorder: isCircle
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red))
                    : const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none)));
  }
}
