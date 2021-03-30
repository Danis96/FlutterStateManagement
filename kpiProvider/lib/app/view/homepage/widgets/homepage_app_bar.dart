import 'package:flutter/material.dart';

PreferredSizeWidget homeAppBar({
  @required String title,
  @required BuildContext context,
}) {
  return AppBar(
    title: Text(title),
  );
}
