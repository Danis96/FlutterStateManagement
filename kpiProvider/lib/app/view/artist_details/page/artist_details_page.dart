import 'package:flutter/material.dart';
import 'package:kpiProvider/app/models/artist_albums_model.dart';
import 'package:kpiProvider/app/models/artist_model.dart';
import 'package:kpiProvider/app/providers/artist_provider.dart';
import 'package:kpiProvider/app/view/artist_details/widgets/artist_details_app_bar.dart';
import 'package:kpiProvider/app/view/artist_details/widgets/artist_details_headline.dart';
import 'package:kpiProvider/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpiProvider/common_widgets/loader.dart';
import 'package:provider/provider.dart';

class ArtistDetailPage extends StatelessWidget {
  const ArtistDetailPage({
    this.albumUrl,
    this.artistModel,
  });

  final String albumUrl;
  final ArtistModel artistModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ArtistProvider>(
      create: (BuildContext context) => ArtistProvider(),
      child: ArtistDetailsChild(
        albumUrl: albumUrl,
        artistModel: artistModel,
      ),
    );
  }
}

class ArtistDetailsChild extends StatefulWidget {
  const ArtistDetailsChild({
    this.albumUrl,
    this.artistModel,
  });

  final String albumUrl;
  final ArtistModel artistModel;

  @override
  _ArtistDetailsChildState createState() => _ArtistDetailsChildState();
}

class _ArtistDetailsChildState extends State<ArtistDetailsChild> {
  @override
  void initState() {
    super.initState();
    Future<void>(() {
      loaderDialog(context: context);
    });
    Provider.of<ArtistProvider>(context, listen: false)
        .getAlbums(widget.albumUrl)
        .then(
          (_) => Navigator.of(context).pop(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            artistDetailsHeadline(
              image: widget.artistModel.aImage,
              name: widget.artistModel.aName,
              albumNumber: context.watch<ArtistProvider>().albums.length ?? 0,
              context: context,
            ),
            ListView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
