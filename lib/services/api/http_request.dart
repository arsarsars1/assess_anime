import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:assess_anime/core/utils/utilities.dart';
import 'package:assess_anime/services/api/api_constants.dart';
import 'package:assess_anime/services/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:images_picker/images_picker.dart';

class HttpRequestCustom {
  HttpRequestCustom._();
  static const String contentTypeUrlEncoded =
      'application/x-www-form-urlencoded; charset=UTF-8';
  static const String contentTypeJson = 'application/json; charset=UTF-8';

  static Future<http.Response> post({required String url, String? body}) async {
    Map<String, String> header;
    if (Config.token.isNotEmpty) {
      header = <String, String>{
        HttpHeaders.contentTypeHeader: HttpRequestCustom.contentTypeJson,
        HttpHeaders.authorizationHeader: 'Bearer ${Config.token}'
      };
    } else {
      header = <String, String>{
        'Content-Type': HttpRequestCustom.contentTypeJson,
      };
    }

    var response = await http.post(
      Uri.parse(Config.BASE_URL + url),
      headers: header,
      body: body,
    );
    debugPrintUI(response, body: body);
    return response;
  }

  static Future<http.Response> get(
      {required String url,
      String contentType = HttpRequestCustom.contentTypeJson}) async {
    Map<String, String> header;
    if (Config.token.isNotEmpty) {
      header = <String, String>{
        HttpHeaders.contentTypeHeader: contentType,
        HttpHeaders.authorizationHeader: 'Bearer ${Config.token}'
      };
    } else {
      header = <String, String>{
        'Content-Type': HttpRequestCustom.contentTypeJson,
      };
    }
    var response = await http.get(
      Uri.parse(Config.BASE_URL + url),
      headers: header,
    );
    debugPrintUI(response);
    return response;
  }

  static Future<http.Response> delete(
      {required String url,
      String contentType = HttpRequestCustom.contentTypeJson}) async {
    Map<String, String> header;

    if (Config.token.isNotEmpty) {
      header = <String, String>{
        HttpHeaders.contentTypeHeader: contentType,
        HttpHeaders.authorizationHeader: 'Bearer ${Config.token}'
      };
    } else {
      header = <String, String>{
        'Content-Type': HttpRequestCustom.contentTypeJson,
      };
    }
    var response = await http.delete(
      Uri.parse(Config.BASE_URL + url),
      headers: header,
    );
    debugPrintUI(response);
    return response;
  }

  upload() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
      language: Language.System,
      maxSize: 500,
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.wh16x9,
      ),
    );
    if (res != null) {
      String pickedFile = res.map((e) => e.path).toList().first;
      uploadImage(pickedFile);
    }
  }

  Future<String?> uploadImage(String image) async {
    var postUri = Uri.parse(Config.BASE_URL + APIConstant.imageUpload);
    var headers = {'Authorization': 'Bearer ${Config.token}'};

    var request = http.MultipartRequest('POST', postUri);
    request.files.add(await http.MultipartFile.fromPath('file', image));
    request.headers.addAll(headers);
    String? avatarString;

    request.send().then((response) {
      if (response.statusCode == HttpStatus.ok) {
        response.stream.transform(utf8.decoder).listen((value) {
          avatarString = convert.jsonDecode(value)['avatar'] as String;
        });
      } else {
        throw Exception();
      }
    });

    return avatarString;
  }

  static debugPrintUI(http.Response response, {String? body}) {
    Utilities.debugPrintCustom(
        "┌------------------------------------------------------------------------------");
    Utilities.debugPrintCustom("url ${response.request?.url}");
    Utilities.debugPrintCustom("method ${response.request?.method}");
    if (response.request?.method == "POST") {
      Utilities.debugPrintCustom("Json $body");
    }
    Utilities.debugPrintCustom("body ${response.body}");
    Utilities.debugPrintCustom("reasonPhrase ${response.reasonPhrase}");
    Utilities.debugPrintCustom("statusCode ${response.statusCode}");
    Utilities.debugPrintCustom(
        "└------------------------------------------------------------------------------");
    if (response.statusCode == 500) {
      Utilities.debugPrintCustom(jsonDecode(response.body));
    }
  }
}
