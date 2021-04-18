import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum CardType {
  artist,
  album,
}

Widget artistCard({
  @required String image,
  @required String name,
  @required String description,
  @required BuildContext context,
  CardType type = CardType.artist,
  int numberOfSongs = 0,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: Card(
      child: Container(
          height: 150,
          child: _buildRow(
            name: name,
            context: context,
            description: description,
            image: image,
            numberOfSongs: numberOfSongs,
            type: type,
          )),
    ),
  );
}

Widget _buildRow({
  String image,
  String name,
  String description,
  BuildContext context,
  CardType type,
  int numberOfSongs,
}) {
  return Row(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(5),
        child: Hero(
          tag: 'artist_image-$name',
          child: Image.network(image),
        ),
      ),
      _buildCardInfoContainer(
        numberOfSongs: numberOfSongs,
        description: description,
        context: context,
        name: name,
        type: type,
      ),
    ],
  );
}

Widget _buildCardInfoContainer({
  CardType type,
  String name,
  BuildContext context,
  String description,
  int numberOfSongs,
}) {
  return Container(
    child: Expanded(
      child: Column(
        mainAxisAlignment: type == CardType.album
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: type == CardType.album
                  ? Theme.of(context).textTheme.headline1
                  : Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(height: 10),
          if (type == CardType.album)
            Container(
              child: Text(
                'Number of songs: $numberOfSongs',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          if (type == CardType.artist)
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: 200,
                  child: Text(
                    description,
                    maxLines: 20,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
