import 'package:flutter/material.dart';
import 'package:kpiProvider/app/models/artist_albums_model.dart';
import 'package:kpiProvider/app/providers/artist_provider.dart';
import 'package:kpiProvider/app/view/artist_details/widgets/artist_details_app_bar.dart';
import 'package:kpiProvider/app/view/artist_details/widgets/artist_details_headline.dart';
import 'package:kpiProvider/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:provider/provider.dart';

class ArtistDetailsChild extends StatefulWidget {
  @override
  _ArtistDetailsChildState createState() => _ArtistDetailsChildState();
}

class _ArtistDetailsChildState extends State<ArtistDetailsChild> {
  @override
  void initState() {
    context.read<ArtistProvider>().fetchAlbumsInInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: detailsAppBar(context),
        body: _buildBodyList(context),
    );
  }
}


Widget _buildBodyList(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    children: <Widget>[
      const SizedBox(height: 10),
      artistDetailsHeadline(
        image: context.read<ArtistProvider>().artist.aImage,
        name: context.read<ArtistProvider>().artist.aName,
        albumNumber: context.watch<ArtistProvider>().albums.length ?? 0,
        context: context,
      ),
      _buildAlbumsList(context),
    ],
  );
}


Widget _buildAlbumsList(BuildContext context) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: context.watch<ArtistProvider>().albums.length ?? 0,
    itemBuilder: (BuildContext context, int index) {
      final ArtistAlbumModel album =
      context.watch<ArtistProvider>().albums[index];
      return artistCard(
        image: album.albumImage,
        name: album.albumName,
        description: album.albumPublished.toString(),
        context: context,
        type: CardType.album,
        numberOfSongs: album.albumSongsNumber,
      );
    },
  );
}