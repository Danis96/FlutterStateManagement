import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:kpi_get_it/app/get_it/notifiers/artists_notifier.dart';
import 'package:kpi_get_it/app/models/artist_albums_model.dart';
import 'package:kpi_get_it/app/models/artist_model.dart';
import 'package:kpi_get_it/app/view/artist_details/widgets/artist_details_app_bar.dart';
import 'package:kpi_get_it/app/view/artist_details/widgets/artist_details_headline.dart';
import 'package:kpi_get_it/app/view/homepage/widgets/homepage_artist_card.dart';

class ArtistDetailPage extends StatefulWidget with GetItStatefulWidgetMixin {
  @override
  _ArtistDetailsChildState createState() => _ArtistDetailsChildState();
}

class _ArtistDetailsChildState extends State<ArtistDetailPage>
    with GetItStateMixin {
  @override
  void initState() {
    getX((ArtistNotifier x) => x.fetchAlbumsInInit(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: BuildBodyList(),
    );
  }
}

class BuildBodyList extends StatelessWidget with GetItMixin {
  @override
  Widget build(BuildContext context) {
    final List<ArtistAlbumModel> albums =
        watchOnly((ArtistNotifier x) => x.albums);
    final ArtistModel artistModel = getX((ArtistNotifier x) => x.artist);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        artistDetailsHeadline(
          image: artistModel.aImage,
          name: artistModel.aName,
          albumNumber: albums.length ?? 0,
          context: context,
        ),
        _buildAlbumsList(albums: albums),
      ],
    );
  }
}

Widget _buildAlbumsList({@required List<ArtistAlbumModel> albums}) {
  return ListView.builder(
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
  );
}
