import 'package:flutter/foundation.dart';
import 'package:kpiProvider/app/models/artist_albums_model.dart';
import 'package:kpiProvider/app/models/artist_model.dart';
import 'package:kpiProvider/app/repository/artist_repo.dart';

class ArtistProvider extends ChangeNotifier {
  ArtistProvider() {
    _artistRepository = ArtistRepository();
  }

  ArtistRepository _artistRepository;

  List<ArtistModel> _artists;

  List<ArtistModel> get artists => _artists ?? <ArtistModel>[];

  List<ArtistAlbumModel> _albums;

  List<ArtistAlbumModel> get albums => _albums ?? <ArtistAlbumModel>[];

  Future<void> getArtists() async {
    try {
      _artists = <ArtistModel>[];
      _artists = await _artistRepository.fetchArtists();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAlbums(String artistAlbumPath) async {
    try {
      _albums = <ArtistAlbumModel>[];
      _albums = await _artistRepository.fetchArtistAlbums(artistAlbumPath);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
