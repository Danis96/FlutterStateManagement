import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpiRiverpod/app/models/artist_albums_model.dart';
import 'package:kpiRiverpod/app/repository/artist_repo.dart';
import 'package:kpiRiverpod/common_widgets/loader.dart';

class AlbumStateNotifier extends StateNotifier<List<ArtistAlbumModel>> {
  AlbumStateNotifier(List<ArtistAlbumModel> state)
      : super(state = <ArtistAlbumModel>[]) {
    _artistRepository = ArtistRepository();
  }

  ArtistRepository _artistRepository;

  String albumUrl;

  void setAlbumUrl(String url) {
    albumUrl = url;
  }

  void fetchAlbumsInInit(BuildContext context) {
    Future<void>(() {
      loaderDialog(context: context);
    });
    getAlbums().then((_) => Navigator.of(context).pop());
  }

  Future<void> getAlbums() async {
    state = await _artistRepository.fetchArtistAlbums(albumUrl);
  }
}
