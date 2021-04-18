
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpiRiverpod/app/models/artist_model.dart';
import 'package:kpiRiverpod/app/repository/artist_repo.dart';
import 'package:kpiRiverpod/common_widgets/loader.dart';

class ArtistStateNotifier extends StateNotifier<List<ArtistModel>> {
  ArtistStateNotifier(List<ArtistModel> state)
      : super(state = <ArtistModel>[]) {
    _artistRepository = ArtistRepository();
  }

  ArtistRepository _artistRepository;

  ArtistModel artist;

  void setArtistModel(ArtistModel model) {
    artist = model;
  }

  void fetchArtistInInit(BuildContext context) {
    Future<void>(() {
      loaderDialog(context: context);
    });
    getArtists().then((_) => Navigator.of(context).pop());
  }

  Future<void> getArtists() async {
    state = await _artistRepository.fetchArtists();
  }
}
