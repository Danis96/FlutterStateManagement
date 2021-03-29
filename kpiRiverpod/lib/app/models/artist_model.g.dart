// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) {
  return ArtistModel(
    name: json['name'] as String ?? '',
    image: json['image'] as String ?? '',
    id: json['id'] as int ?? 0,
    description: json['decription'] as String ?? '',
  )..albums = json['albums'] as String ?? '';
}

Map<String, dynamic> _$ArtistModelToJson(ArtistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'decription': instance.description,
      'albums': instance.albums,
    };
