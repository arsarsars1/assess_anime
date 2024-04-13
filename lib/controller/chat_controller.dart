import 'dart:convert';

import 'package:assess_anime/core/helper/dialog_custom.dart';
import 'package:assess_anime/model/chat_model.dart';
import 'package:assess_anime/services/api/api_constants.dart';
import 'package:assess_anime/services/api/http_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;

  Rx<ChatModel?> chatModel = Rx<ChatModel?>(null);

  Future<void> getChat(BuildContext context) async {
    isLoading(true);
    await HttpRequestCustom.get(url: APIConstant.chats).then((value) {
      if (value != null && value.statusCode == 200) {
        isLoading(false);
        Map<String, dynamic> jsonMap = jsonDecode(value.body);
        chatModel(ChatModel.fromJson(jsonMap));
      } else {
        chatModel(null);
        isLoading(false);
        DialogCustom.showPopupDialog(
            message: "Request Failed", context: context);
      }
    });
    isLoading(false);
  }
}
