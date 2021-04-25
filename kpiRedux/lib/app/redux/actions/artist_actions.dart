import 'package:flutter/foundation.dart';
import 'package:kpiRedux/app/redux/app_state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

const String baseURL = 'https://jsonblob.com/api/jsonBlob/';

const String LIST_ARTIST_REQUEST = 'LIST_ARTIST_REQUEST';
const String LIST_ARTIST_SUCCESS = 'LIST_ARTIST_SUCCESS';
const String LIST_ARTIST_FAILURE = 'LIST_ARTIST_FAILURE';

const String LIST_ALBUM_REQUEST = 'LIST_ALBUM_REQUEST';
const String LIST_ALBUM_SUCCESS = 'LIST_ALBUM_SUCCESS';
const String LIST_ALBUM_FAILURE = 'LIST_ALBUM_FAILURE';

RSAA getArtistsRequest() {
  return RSAA(
      method: 'GET',
      endpoint:
          '$baseURL/f30a2517-60b4-11eb-a1e4-475264cf2bca',
      types: <String>[
        LIST_ARTIST_REQUEST,
        LIST_ARTIST_SUCCESS,
        LIST_ARTIST_FAILURE,
      ],
      headers: <String, String>{
        'Content-Type': 'application/json',
      });
}

ThunkAction<AppState> getArtists() =>
    (Store<AppState> store) => store.dispatch(getArtistsRequest());

RSAA getArtistAlbumRequest({@required String albumUrl}) {
  return RSAA(
      method: 'GET',
      endpoint: '$baseURL$albumUrl',
      types: <String>[
        LIST_ALBUM_REQUEST,
        LIST_ALBUM_SUCCESS,
        LIST_ALBUM_FAILURE,
      ],
      headers: <String, String>{
        'Content-Type': 'application/json',
      });
}
ThunkAction<AppState> getAlbums(String albumUrl) => (Store<AppState> store) =>
    store.dispatch(getArtistAlbumRequest(albumUrl: albumUrl));
