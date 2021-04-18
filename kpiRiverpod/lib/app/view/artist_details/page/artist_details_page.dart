import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpiRiverpod/app/models/artist_albums_model.dart';
import 'package:kpiRiverpod/app/state_notifiers/album_state_notifier.dart';
import 'package:kpiRiverpod/app/view/artist_details/widgets/artist_details_app_bar.dart';
import 'package:kpiRiverpod/app/view/artist_details/widgets/artist_details_headline.dart';
import 'package:kpiRiverpod/app/view/homepage/page/homepage_page.dart';
import 'package:kpiRiverpod/app/view/homepage/widgets/homepage_artist_card.dart';

final StateNotifierProvider<AlbumStateNotifier> albumProvider =
    StateNotifierProvider<AlbumStateNotifier>(
  (ProviderReference ref) => AlbumStateNotifier(
    <ArtistAlbumModel>[],
  ),
);

class ArtistDetailPage extends StatefulWidget {
  @override
  _ArtistDetailPageState createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read(albumProvider).fetchAlbumsInInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: _buildBodyList(),
    );
  }
}

Widget _buildBodyList() {
  return Consumer(builder: (BuildContext context,
      T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
    final List<ArtistAlbumModel> albumModel = watch(albumProvider.state);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: <Widget>[
        const SizedBox(height: 10),
        artistDetailsHeadline(
          image: watch(artistProvider).artist.aImage,
          name: watch(artistProvider).artist.aName,
          albumNumber: albumModel.length ?? 0,
          context: context,
        ),
        _buildAlbumList(albumModel),
      ],
    );
  });
}

Widget _buildAlbumList(List<ArtistAlbumModel> albumModel) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: albumModel.length ?? 0,
    itemBuilder: (BuildContext context, int index) {
      final ArtistAlbumModel album = albumModel[index];
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
