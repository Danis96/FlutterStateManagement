import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kpi_get_it/app/models/artist_albums_model.dart';
import 'package:kpi_get_it/app/models/artist_model.dart';
import 'package:kpi_get_it/app/repository/artist_repo.dart';
import 'package:kpi_get_it/common_widgets/loader.dart';

class ArtistNotifier extends ChangeNotifier {
  ArtistNotifier() {
    _artistRepository = ArtistRepository();
  }

  ArtistRepository _artistRepository;

  List<ArtistModel> _artists;

  List<ArtistModel> get artists => _artists ?? <ArtistModel>[];

  List<ArtistAlbumModel> _albums;

  List<ArtistAlbumModel> get albums => _albums ?? <ArtistAlbumModel>[];

  String albumUrl;

  ArtistModel artist;

  void setAlbumUrl(String url) {
     albumUrl = url;
  }

  void setArtistModel(ArtistModel model) {
    artist = model;
  }

  void fetchArtistInInit(BuildContext context) {
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
