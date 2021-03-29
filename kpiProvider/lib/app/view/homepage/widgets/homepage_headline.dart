import 'package:flutter/material.dart';

Widget homePageHeadline({
  required String title,
  required String subtitle,
  required BuildContext context,
}) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    ),
  );
}
