import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> showMyDialog({
  BuildContext context,
  String title,
  String msg,
  Color color,
  Widget mainWidget,
  Widget action,
  double elevation,
  bool barrier,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrier,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: color,
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                child:  mainWidget,
              )
            ],
          ),
        ),
        actions: <Widget>[
          action,
        ],
      );
    },
  );
}

Future<void> loaderDialog({
  @required BuildContext context,
}) {
  return showMyDialog(
    context: context,
    barrier: false,
    title: '',
    mainWidget: const SpinKitCircle(
      size: 80.0,
      color: Colors.white,
    ),
    color: Colors.transparent,
    elevation: 0,
  );
}
