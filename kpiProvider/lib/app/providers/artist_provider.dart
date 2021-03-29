import 'package:flutter/foundation.dart';
import 'package:kpiProvider/app/models/artist_albums_model.dart';
import 'package:kpiProvider/app/models/artist_model.dart';
import 'package:kpiProvider/app/repository/artist_repo.dart';

class ArtistProvider extends ChangeNotifier {
  ArtistProvider() {
    _artistRepository = ArtistRepository();
  }

  late ArtistRepository _artistRepository;

  List<ArtistModel>? _artists;

  List<ArtistModel> get artists => _artists ?? <ArtistModel>[];

  List<ArtistAlbumModel>? _artistAlbums;

  List<ArtistAlbumModel> get artistAlbums =>
      _artistAlbums ?? <ArtistAlbumModel>[];

  String? _albumUrl;
  String? get albumUrl => _albumUrl;

  Future<String?> fetchArtists() async {
    _artists = <ArtistModel>[];
    try {
      _artists = await _artistRepository.fetchArtists();
      notifyListeners();
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String?> fetchArtistAlbums(String albumUrl) async {
    _artistAlbums = <ArtistAlbumModel>[];
    try {
      _artistAlbums = await _artistRepository.fetchArtistAlbums(albumUrl);
      notifyListeners();
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  void setAlbumUrl(String albumUrl) {
      _albumUrl = albumUrl;
      notifyListeners();
  }
}
