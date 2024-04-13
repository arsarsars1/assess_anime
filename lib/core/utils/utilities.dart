import 'dart:io';
import 'dart:math';

import 'package:assess_anime/core/helper/dialog_custom.dart';
import 'package:assess_anime/services/navigation_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';

class Utilities {
  static Future<void> debugPrintCustom(dynamic exception,
      {String? functionName, String? dartFile}) async {
    debugPrint("debugPrintCustom $exception ${functionName ?? ""}");
  }

  static IconData getIconData(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return Icons.arrow_back_ios;
    }
  }

  static showDialogCustom(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return Container(
            color: Colors.white.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()));
      });

  static Widget showImage(
      {required String image,
      double? width,
      double? height,
      BoxFit fit = BoxFit.cover,
      bool isLongTap = true}) {
    return GestureDetector(
      onLongPress: isLongTap
          ? () {
              DialogCustom.showDialogCustom(
                  context: NavigationService.navigatorKey.currentContext!,
                  widget: Material(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  child: showImage(
                                image: image,
                                fit: BoxFit.fill,
                              )),
                            ]),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: InkWell(
                            onTap: () => Navigator.pop(
                                NavigationService.navigatorKey.currentContext!),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            }
          : null,
      child: Image(
        image: CachedNetworkImageProvider(image),
        fit: fit,
        width: width,
        height: height,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }

  static Future<void> speechToText(String text,
      {bool isPlaying = false}) async {
    try {
      FlutterTts flutterTts = FlutterTts();
      if (Platform.isIOS) {
        await flutterTts.setSharedInstance(true);
        await flutterTts.setIosAudioCategory(
            IosTextToSpeechAudioCategory.ambient,
            [
              IosTextToSpeechAudioCategoryOptions.allowBluetooth,
              IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
              IosTextToSpeechAudioCategoryOptions.mixWithOthers
            ],
            IosTextToSpeechAudioMode.voicePrompt);
      }
      await flutterTts.awaitSpeakCompletion(true);
      if (isPlaying) {
        await flutterTts.stop();
      } else {
        await flutterTts.speak(text);
      }
    } on Exception catch (ex) {
      Utilities.debugPrintCustom(ex);
    }
  }

  static Future<bool> internetAvailable() async {
    try {
      List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      return connectivityResult.any((element) =>
          element == ConnectivityResult.mobile &&
                  element == ConnectivityResult.wifi
              ? true
              : false);
    } catch (e) {
      return false;
    }
  }

  static String hasValidUrl(String value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "http://$value";
    } else if (regExp.hasMatch(value)) {
      return value;
    } else {
      return "https://google.com";
    }
  }

  static Future<void> canLaunch(String url) async {
    if (url.isNotEmpty) {
      try {
        if (await canLaunchUrl(Uri.parse(hasValidUrl(url)))) {
          await launchUrl(Uri.parse(hasValidUrl(url)));
        } else {
          throw 'Could not launch $url';
        }
      } catch (_) {}
    }
  }

  static String generateRandomId() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int random = Random().nextInt(9000) + 1000;
    String randomId = '$timestamp$random';
    return randomId;
  }
}
