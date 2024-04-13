import 'package:assess_anime/core/colors/colors.dart';
import 'package:assess_anime/core/utils/extension.dart';
import 'package:assess_anime/widgets/text_field.dart';
import 'package:flutter/material.dart';

class FieldInput extends StatelessWidget {
  final int maxLine;
  final String title;
  final bool isRequired;
  final TextEditingController controller;
  final Function() onTap;
  const FieldInput(
      {super.key,
      this.maxLine = 1,
      required this.controller,
      required this.title,
      this.isRequired = true,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
      child: maxLine == 1
          ? Row(
              children: [
                showTitle(context),
                Expanded(
                  child: showField(),
                ),
              ],
            )
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  showTitle(context),
                  Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff454545),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: showField(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12))),
                ],
              ),
            ),
    );
  }

  Widget showTitle(BuildContext context) => Row(
        children: [
          Text(
            title + (isRequired ? " *" : ""),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
                color: Colors.white),
          ),
        ],
      );
  Widget showField({EdgeInsets? padding}) => TextFieldCustom(
        maxLines: maxLine,
        onTap: () => onTap(),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        borderColor: Colors.transparent,
        controller: controller,
        onFieldSubmit: (s) => onTap(),
        validator: (value) {
          onTap();
          if (isRequired) {
            if (value.isNotNullOrEmpty()) {
              return null;
            } else {
              return "Field is required";
            }
          } else {
            return null;
          }
        },
      );
}
