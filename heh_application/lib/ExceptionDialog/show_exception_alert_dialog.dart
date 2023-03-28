import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:heh_application/ExceptionDialog/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
    BuildContext context, {
      required String title,
      required Exception exception,
    }
    ) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultActionText: 'Ok',
    );
String _message (Exception exception){
  if (exception is FirebaseAuthException ){
    return exception.message!;
  }
  else {
    return "Sign In Canceled by User";
  }

}