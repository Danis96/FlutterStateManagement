import 'dart:convert';

import 'package:kpiRedux/app/models/artist_albums_model.dart';
import 'package:kpiRedux/app/models/artist_model.dart';
import 'package:kpiRedux/app/redux/actions/artist_actions.dart';
import 'package:kpiRedux/app/redux/app_state/artist_state.dart';

ArtistState artistReducer(ArtistState state, dynamic action) {
  final ArtistState newState = state;

  List<dynamic> artistsFromJSONStr(dynamic payload) {
    final dynamic jsonArray = json.decode(payload.toString());
    return jsonArray['artists'].map((dynamic j) => ArtistModel.fromJson(j)).toList();
  }

  List<dynamic> albumFromJSONStr(dynamic payload) {
    final dynamic jsonArray = json.decode(payload.toString());
    return jsonArray.map((dynamic j) => ArtistAlbumModel.fromJson(j)).toList();
  }

  switch (action.type) {
    case LIST_ARTIST_REQUEST:
      newState.list.error = null;
      newState.list.data = null;
      newState.list.loading = true;
      return newState;
      break;
    case LIST_ARTIST_SUCCESS:
      newState.list.error = null;
      newState.list.data = artistsFromJSONStr(action.payload);
      newState.list.loading = false;
      return newState;
      break;
    case LIST_ARTIST_FAILURE:
      newState.list.data = null;
      newState.list.error = 'Error';
      newState.list.loading = false;
      return newState;
      break;
    case LIST_ALBUM_REQUEST:
      newState.albums.error = null;
      newState.albums.data = null;
      newState.albums.loading = true;
      return newState;
      break;
    case LIST_ALBUM_SUCCESS:
      newState.albums.error = null;
      newState.albums.data = albumFromJSONStr(action.payload);
      newState.albums.loading = false;
      return newState;
      break;
    case LIST_ALBUM_FAILURE:
      newState.albums.data = null;
      newState.albums.error = 'Error';
      newState.albums.loading = false;
      return newState;
      break;
    default:
      return newState;
  }
}

