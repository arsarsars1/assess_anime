import 'package:assess_anime/core/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterController extends GetxController {
  var isloading = false.obs;
  var name = TextEditingController().obs;
  var intro = TextEditingController().obs;
  var description = TextEditingController().obs;
  var firstMsg = TextEditingController().obs;

  bool isField() =>
      name.value.text.isNotNullOrEmpty() &&
      intro.value.text.isNotNullOrEmpty() &&
      description.value.text.isNotNullOrEmpty() &&
      firstMsg.value.text.isNotNullOrEmpty();
}
