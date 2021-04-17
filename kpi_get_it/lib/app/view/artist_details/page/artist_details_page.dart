import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:kpi_get_it/app/get_it/notifiers/artists_notifier.dart';
import 'package:kpi_get_it/app/models/artist_albums_model.dart';
import 'package:kpi_get_it/app/models/artist_model.dart';
import 'package:kpi_get_it/app/view/artist_details/widgets/artist_details_app_bar.dart';
import 'package:kpi_get_it/app/view/artist_details/widgets/artist_details_headline.dart';
import 'package:kpi_get_it/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpi_get_it/common_widgets/loader.dart';

class ArtistDetailPage extends StatefulWidget with GetItStatefulWidgetMixin {
  ArtistDetailPage({
    this.albumUrl,
    this.artistModel,
  });

  final String albumUrl;
  final ArtistModel artistModel;

  @override
  _ArtistDetailsChildState createState() => _ArtistDetailsChildState();
}

class _ArtistDetailsChildState extends State<ArtistDetailPage>
    with GetItStateMixin {
  @override
  void initState() {
    super.initState();
    Future<void>(() {
      loaderDialog(context: context);
    });
    getX((ArtistNotifier x) =>
        x.getAlbums(widget.albumUrl).then((_) => Navigator.of(context).pop()));
  }

  @override
  Widget build(BuildContext context) {
    final List<ArtistAlbumModel> albums = watchOnly((ArtistNotifier x) => x.albums);
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
              albumNumber: albums.length ?? 0,
              context: context,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: albums.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final ArtistAlbumModel album = albums[index];
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
