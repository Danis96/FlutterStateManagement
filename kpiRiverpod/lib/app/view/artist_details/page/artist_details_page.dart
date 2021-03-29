import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kpiRiverpod/app/models/artist_albums_model.dart';
import 'package:kpiRiverpod/app/models/artist_model.dart';
import 'package:kpiRiverpod/app/state_notifiers/album_state_notifier.dart';
import 'package:kpiRiverpod/app/view/artist_details/widgets/artist_details_app_bar.dart';
import 'package:kpiRiverpod/app/view/artist_details/widgets/artist_details_headline.dart';
import 'package:kpiRiverpod/app/view/homepage/widgets/homepage_artist_card.dart';

final StateNotifierProvider<AlbumStateNotifier> albumProvider =
    StateNotifierProvider<AlbumStateNotifier>(
  (ProviderReference ref) => AlbumStateNotifier(
    <ArtistAlbumModel>[],
  ),
);

class ArtistDetailPage extends StatefulWidget {
  const ArtistDetailPage({
    this.albumUrl,
    this.artistModel,
  });

  final String albumUrl;
  final ArtistModel artistModel;

  @override
  _ArtistDetailPageState createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read(albumProvider).getAlbums(albumUrl: widget.albumUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Consumer(builder: (BuildContext context,
            T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
          final List<ArtistAlbumModel> albumModel = watch(albumProvider.state);
          return albumModel.isEmpty
              ? const SpinKitCircle(
                  color: Colors.deepPurple,
                )
              : ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    artistDetailsHeadline(
                      image: widget.artistModel.aImage,
                      name: widget.artistModel.aName,
                      albumNumber: albumModel.length ?? 0,
                      context: context,
                    ),
                    ListView.builder(
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
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
