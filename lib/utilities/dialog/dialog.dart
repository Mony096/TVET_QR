import 'package:npit_qr/constant/style.dart';
import 'package:npit_qr/form/loading_circle.dart';
import 'package:flutter/material.dart';

class MaterialDialog {
  static Future<void> success(
    BuildContext context, {
    String? title,
    String? body,
    Function()? onOk,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          key: const Key('_dialog'),
          // backgroundColor: Colors.white,
          // surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            title ?? 'Success',
            style: TextStyle(
                color: Colors.black,
                fontSize: size(context).width * 0.045,
                fontWeight: FontWeight.w500),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(body ?? '',
                    style: TextStyle(fontSize: size(context).width * 0.04)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(fontSize: size(context).width * 0.045),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onOk != null) {
                  onOk();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> warning(
    BuildContext context, {
    String? title,
    String? body,
    Function()? onConfirm,
    Function()? onCancel,
    String confirmLabel = 'Back',
    String cancelLabel = 'Cancel',
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          key: const Key('_dialog'),
          // backgroundColor: Colors.white,
          // surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,

          title: Text(
            title ?? 'Success',
            style: TextStyle(
                color: Colors.black,
                fontSize: size(context).width * 0.04,
                fontWeight: FontWeight.w500),
          ),
          content: body == null
              ? null
              : SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(body,
                          style:
                              TextStyle(fontSize: size(context).width * 0.04)),
                    ],
                  ),
                ),
          actions: <Widget>[
            TextButton(
              child: Text(
                confirmLabel,
                style: TextStyle(fontSize: size(context).width * 0.035),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
           
          ],
        );
      },
    );
  }

  static Future<void> warningNavigator(
    BuildContext context, {
    String? title,
    String? body,
    Function()? onConfirm,
    Function()? onCancel,
    String confirmLabel = 'Ok',
    String cancelLabel = 'Cancel',
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          key: const Key('_dialog'),
          // backgroundColor: Colors.white,
          // surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,

          title: Text(
            title ?? 'Success',
            style: TextStyle(
                color: Colors.black,
                fontSize: size(context).width * 0.04,
                fontWeight: FontWeight.w500),
          ),
          content: body == null
              ? null
              : SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(body,
                          style:
                              TextStyle(fontSize: size(context).width * 0.04)),
                    ],
                  ),
                ),
          actions: <Widget>[
            TextButton(
              child: Text(
                confirmLabel,
                style: TextStyle(fontSize: size(context).width * 0.035),
              ),
              onPressed: () {
                if (onConfirm != null) {
                  Navigator.of(context).pop();
                  onConfirm();
                }
              },
            ),
            TextButton(
              child: Text(
                cancelLabel,
                style: TextStyle(fontSize: size(context).width * 0.035),
              ),
              onPressed: () {
                if (onCancel != null) {
                  Navigator.of(context).pop();
                  onCancel();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static close(BuildContext context) {
    if (context.mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  static Future<void> loading(BuildContext context,
      {bool? barrierDismissible}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible ?? true, // User must tap button
      builder: (BuildContext context) {
        return Container(
          color: Colors.black
              .withOpacity(0.3), // Black background with 50% opacity
          child: const AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(10),
            insetPadding: EdgeInsets.symmetric(horizontal: 130),
            content: SizedBox(
              height: 100,
              child: LoadingCircle(enableShadow: false),
            ),
          ),
        );
      },
    );
  }

  static snackBar(BuildContext context, message) {
    final snackBar = SnackBar(
      // width: MediaQuery.of(context).size.width,'
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        child: Text(message),
      ),
      padding: const EdgeInsets.all(12),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
