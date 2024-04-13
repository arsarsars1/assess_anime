import 'package:flutter/material.dart';

class DialogCustom {
  DialogCustom._();

  static Future<void> showDialogAlert(
      {required BuildContext context,
      required String title,
      Widget? content,
      String applyText = "Yes",
      String closeText = "Close",
      Color applyColor = Colors.red,
      bool isAutoDismiss = false,
      Function? callBack,
      Function? callBackTrue,
      bool isYes = true}) async {
    await showDialogCustom(
      context: context,
      widget: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              )),
          content: content,
          actions: <Widget>[
            TextButton(
              child: Text(
                closeText,
                style: const TextStyle(
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (isYes)
              TextButton(
                child: Text(
                  applyText,
                  style: TextStyle(
                      color: applyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () async {
                  if (callBack != null) {
                    await callBack();
                  }
                  if (callBackTrue != null) {
                    await callBackTrue(true);
                  }
                  if (isAutoDismiss) {
                    Navigator.of(context).pop();
                  }
                },
              ),
          ]),
    );
  }

  static Future<void> showBottomSheetCustom(
          {required BuildContext context, required Widget widget}) async =>
      await showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          context: context,
          builder: (context) => widget);

  static Future<void> showDialogCustom(
          {required Widget widget, required BuildContext context}) async =>
      await showDialog(
          context: context, builder: (BuildContext context) => widget);

  static Future<void> showPopupDialog(
          {required String message,
          required BuildContext context,
          int duration = 1}) async =>
      await showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            Future.delayed(Duration(seconds: duration), () {
              Navigator.of(buildContext).pop();
            });
            return Center(
                child: Container(
                    width: 150.0,
                    height: 100.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 20))
                        ])));
          });
}
