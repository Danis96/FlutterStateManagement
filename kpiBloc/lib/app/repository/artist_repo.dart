import 'package:kpiBloc/app/models/artist_albums_model.dart';
import 'package:kpiBloc/app/models/artist_model.dart';
import 'package:kpiBloc/app/network_module/api_header.dart';
import 'package:kpiBloc/app/network_module/api_path.dart';
import 'package:kpiBloc/app/network_module/http_client.dart';

class ArtistRepository {
  Future<List<ArtistModel>> fetchArtists() async {
    final Map<String, String> header =
        await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final dynamic response = await HTTPClient.instance
        .fetchData(ApiPathHelper.getValue(ApiPath.artists), header);
    final List<ArtistModel> list = <ArtistModel>[];
    print('Response: $response');
    final List<dynamic> responseList = response['artists'] as List<dynamic>;
    responseList.map((dynamic e) => list.add(ArtistModel.fromJson(e))).toList();
    return list;
  }

  Future<List<ArtistAlbumModel>> fetchArtistAlbums(
      String artistAlbumPath) async {
    final Map<String, String> header =
        await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final dynamic response =
        await HTTPClient.instance.fetchData(artistAlbumPath, header);
    final List<ArtistAlbumModel> list = <ArtistAlbumModel>[];
    print('Response: $response');
    final List<dynamic> responseList = response as List<dynamic>;
    responseList
        .map((dynamic e) => list.add(ArtistAlbumModel.fromJson(e)))
        .toList();
    return list;
  }
}
