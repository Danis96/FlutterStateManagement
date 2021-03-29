import 'package:kpiRedux/app/redux/app_state/artist_state.dart';

class AppState {
  AppState({
    this.artistState,
  });

  factory AppState.initial() => AppState(
        artistState: ArtistState.initial(),
      );

  final ArtistState artistState;

  AppState copyWith({
    ArtistState artistState,
  }) {
    return AppState(
      artistState: artistState ?? this.artistState,
    );
  }
}
