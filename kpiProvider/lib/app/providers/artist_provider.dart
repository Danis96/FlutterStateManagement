import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kpiProvider/app/models/artist_albums_model.dart';
import 'package:kpiProvider/app/models/artist_model.dart';
import 'package:kpiProvider/app/repository/artist_repo.dart';
import 'package:kpiProvider/common_widgets/loader.dart';

class ArtistProvider extends ChangeNotifier {
  ArtistProvider() {
    _artistRepository = ArtistRepository();
  }

  ArtistRepository _artistRepository;

  List<ArtistModel> _artists;

  List<ArtistModel> get artists => _artists ?? <ArtistModel>[];

  List<ArtistAlbumModel> _albums;

  List<ArtistAlbumModel> get albums => _albums ?? <ArtistAlbumModel>[];

  ArtistModel artist;

  void setArtistModel(ArtistModel model) => artist = model;

  String albumUrl;

  void setAlbumUrl(String url) => albumUrl = url;

  void fetchArtistsInInit(BuildContext context) {
    Future<void>(() {
      loaderDialog(context: context);
    });
    getArtists().then((_) => Navigator.of(context).pop());
  }

  void fetchAlbumsInInit(BuildContext context) {
    Future<void>(() {
      loaderDialog(context: context);
    });
    getAlbums(albumUrl).then((_) => Navigator.of(context).pop());
  }

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
