import 'package:kpiBloc/app/models/artist_model.dart';
import 'package:kpiBloc/app/repository/artist_repo.dart';
import 'package:rxdart/rxdart.dart';

class ArtistBloc {
  ArtistBloc() {
    _repository = ArtistRepository();
  }

  ArtistRepository _repository;

  final PublishSubject<List<ArtistModel>> _artistFetch =
      PublishSubject<List<ArtistModel>>();

  Observable<List<ArtistModel>> get allArtists => _artistFetch.stream;

  Future<void> fetchAllArtist() async {
    final List<ArtistModel> _artists = await _repository.fetchArtists();
    _artistFetch.sink.add(_artists);
  }

  void dispose() {
     _artistFetch.close();
  }

}
