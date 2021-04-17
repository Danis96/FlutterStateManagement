// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_albums_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistAlbumModel _$ArtistAlbumModelFromJson(Map<String, dynamic> json) {
  return ArtistAlbumModel(
    name: json['name'] as String ?? '',
    songsNumber: json['songs_num'] as int ?? 0,
    songs: json['songs'] as String ?? '',
    coverImage: json['cover'] as String ?? '',
    published: json['published'] as int ?? 0,
  );
}

Map<String, dynamic> _$ArtistAlbumModelToJson(ArtistAlbumModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'published': instance.published,
      'cover': instance.coverImage,
      'songs_num': instance.songsNumber,
      'songs': instance.songs,
    };
