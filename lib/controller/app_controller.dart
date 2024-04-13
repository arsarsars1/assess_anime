import 'dart:convert';
import 'dart:io';

import 'package:assess_anime/core/helper/dialog_custom.dart';
import 'package:assess_anime/core/utils/utilities.dart';
import 'package:assess_anime/services/api/api_constants.dart';
import 'package:assess_anime/services/api/http_request.dart';
import 'package:assess_anime/services/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(BuildContext context) async {
    isLoading(true);
    await HttpRequestCustom.post(
        url: APIConstant.login,
        body: jsonEncode({
          "deviceId": Utilities.generateRandomId(),
          "devicePlatform": Platform.isAndroid ? "android" : "iOS",
        })).then((value) {
      if (value.statusCode == 200) {
        isLoading(false);
        Map<String, dynamic> jsonMap = jsonDecode(value.body);
        Config.token = jsonMap['accessToken'];
      } else {
        isLoading(false);
        DialogCustom.showPopupDialog(
            message: "Request Failed", context: context);
      }
    });
    isLoading(false);
  }
}
