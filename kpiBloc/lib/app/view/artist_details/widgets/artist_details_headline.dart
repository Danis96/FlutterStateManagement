import 'package:flutter/material.dart';

Widget artistDetailsHeadline({
  @required String image,
  @required String name,
  @required int albumNumber,
  @required BuildContext context,
}) {
  return Column(
    children: <Widget>[
      Container(
        width: 120,
        height: 120,
        child: Hero(
            tag: 'artist_image-$name',
            child: Image.network(image)),
      ),
      Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
      const Divider(),
    ],
  );
}
