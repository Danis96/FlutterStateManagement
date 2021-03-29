import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpiRiverpod/app/models/artist_model.dart';
import 'package:kpiRiverpod/app/repository/artist_repo.dart';

class ArtistStateNotifier extends StateNotifier<List<ArtistModel>> {
  ArtistStateNotifier(List<ArtistModel> state)
      : super(state = <ArtistModel>[]) {
    _artistRepository = ArtistRepository();
  }

  ArtistRepository _artistRepository;

  Future<void> getArtists() async {
    state = await _artistRepository.fetchArtists();
  }
}
