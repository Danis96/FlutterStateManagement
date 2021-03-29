
class ArtistState {
  ArtistState({
    this.albums,
    this.list,
  });

  factory ArtistState.initial() => ArtistState(
        list: ListArtistState.initial(),
        albums: ListArtistAlbumsState.initial(),
      );

  ListArtistState list;
  ListArtistAlbumsState albums;
}

class ListArtistState {
  ListArtistState({
    this.error,
    this.data,
    this.loading,
  });

  factory ListArtistState.initial() => ListArtistState(
        data: <dynamic>[],
        error: null,
        loading: false,
      );

  dynamic error;
  bool loading;
  List<dynamic> data;
}

class ListArtistAlbumsState {
  ListArtistAlbumsState({
    this.data,
    this.error,
    this.loading,
  });

  factory ListArtistAlbumsState.initial() => ListArtistAlbumsState(
        error: null,
        data: <dynamic>[],
        loading: false,
      );

  dynamic error;
  bool loading;
  List<dynamic> data;
}
