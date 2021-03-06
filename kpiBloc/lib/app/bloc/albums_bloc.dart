import 'package:flutter/cupertino.dart';
import 'package:kpiBloc/app/models/artist_albums_model.dart';
import 'package:kpiBloc/app/repository/artist_repo.dart';
import 'package:kpiBloc/common_widgets/loader.dart';
import 'package:rxdart/rxdart.dart';

class AlbumBloc {
  AlbumBloc() {
    _repository = ArtistRepository();
  }

  ArtistRepository _repository;

  final PublishSubject<List<ArtistAlbumModel>> _albumsFetch =
      PublishSubject<List<ArtistAlbumModel>>();

  Observable<List<ArtistAlbumModel>> get allAlbums => _albumsFetch.stream;

  Future<void> fetchAllAlbums(String albumUrl) async {
    final List<ArtistAlbumModel> _albums =
        await _repository.fetchArtistAlbums(albumUrl);
    _albumsFetch.sink.add(_albums);
  }

  Future<void> fetchAllAlbumsInInit(
    BuildContext context,
    String albumUrl,
  ) async {
    Future<void>(() {
      loaderDialog(context: context);
    });
    fetchAllAlbums(albumUrl).then((_) => Navigator.of(context).pop());
  }

  void dispose() {
    _albumsFetch.close();
  }
}
