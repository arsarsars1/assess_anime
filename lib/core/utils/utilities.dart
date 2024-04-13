import 'dart:math';

import 'package:assess_anime/core/helper/dialog_custom.dart';
import 'package:assess_anime/core/utils/extension.dart';
import 'package:assess_anime/services/navigation_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
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

  static String displayStateCity(
      {required String address, required String state, required String city}) {
    return
        // address.isNotNullOrEmpty()
        //   ? address  :
        city.toSimpleText().isNotNullOrEmpty() &&
                state.toSimpleText().isNotNullOrEmpty()
            ? "${state.toSimpleText()}/${city.toSimpleText()}"
            : state.toSimpleText().isNotNullOrEmpty() &&
                    city.toSimpleText().isNotNullOrEmpty() == false
                ? state.toSimpleText()
                : city.toSimpleText();
  }

  static Future<bool> internetAvailable() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static String showName(String? name, String? username) {
    return name.isNotNullOrEmpty()
        ? name!
        : username.isNotNullOrEmpty()
            ? username!
            : "";
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
    // Get the current timestamp in milliseconds
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    // Generate a random number between 1000 and 9999
    int random = Random().nextInt(9000) + 1000;

    // Combine timestamp and random number to create the ID
    String randomId = '$timestamp$random';

    return randomId;
  }
}
