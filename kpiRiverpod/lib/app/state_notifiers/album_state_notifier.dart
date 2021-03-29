import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpiRiverpod/app/models/artist_albums_model.dart';
import 'package:kpiRiverpod/app/repository/artist_repo.dart';

class AlbumStateNotifier extends StateNotifier<List<ArtistAlbumModel>> {
  AlbumStateNotifier(List<ArtistAlbumModel> state)
      : super(state = <ArtistAlbumModel>[]) {
    _artistRepository = ArtistRepository();
  }

  ArtistRepository _artistRepository;

  Future<void> getAlbums({@required String albumUrl}) async {
    state = await _artistRepository.fetchArtistAlbums(albumUrl);
  }



}
