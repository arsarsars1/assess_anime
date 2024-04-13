import 'dart:convert';

import 'package:assess_anime/core/helper/dialog_custom.dart';
import 'package:assess_anime/core/utils/extension.dart';
import 'package:assess_anime/services/api/api_constants.dart';
import 'package:assess_anime/services/api/http_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterController extends GetxController {
  var isLoading = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController intro = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController firstMsg = TextEditingController();

  bool get isField =>
      name.text.isNotNullOrEmpty() &&
      intro.text.isNotNullOrEmpty() &&
      description.text.isNotNullOrEmpty() &&
      firstMsg.text.isNotNullOrEmpty();

  Future<void> createCharacter(BuildContext context) async {
    isLoading(true);
    await HttpRequestCustom.post(
        url: APIConstant.characters,
        body: jsonEncode({
          "name": name.text,
          "firstMessage": firstMsg.text,
          "scenario": "Dancing",
          "exampleDialogues": firstMsg.text,
          "profileImageUrl":
              "https://w0.peakpx.com/wallpaper/411/389/HD-wallpaper-anime-school-girl-sunset-profile-view-short-hair-scenic-clouds-anime.jpg",
          "backgroundImageUrl":
              "https://wallpapers.com/images/featured/profile-background-b5vedq7mz8mjvslu.jpg",
          "style": "Anime",
          "introduce": intro.text,
          "isNsfw": true,
          "voiceId": 0,
          "description": description.text,
          "tags": "anime",
          "visibility": "Public",
          "gender": "Female",
          "region": "American",
          "ageGroup": "25",
          "height": "60",
          "occupation": "actor"
        })).then((value) {
      if (value.statusCode == 200) {
        isLoading(false);
        Map<String, dynamic> jsonMap = jsonDecode(value.body);
        jsonMap.forEach((key, value) {
          print(key);
          print(value);
        });
        // Config.token = jsonMap['accessToken'];
      } else {
        isLoading(false);
        DialogCustom.showPopupDialog(
            message: "Request Failed", context: context);
      }
    });
    isLoading(false);
  }
}
