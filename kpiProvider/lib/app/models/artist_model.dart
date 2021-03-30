import 'package:json_annotation/json_annotation.dart';

part 'artist_model.g.dart';

@JsonSerializable()
class ArtistModel {
  ArtistModel({
    this.name,
    this.image,
    this.id,
    this.description,
  });

  factory ArtistModel.fromJson(dynamic json) =>
      _$ArtistModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);

  @JsonKey(name: 'id', defaultValue: 0)
  int id;
  @JsonKey(name: 'name', defaultValue: '')
  String name;
  @JsonKey(name: 'image', defaultValue: '')
  String image;
  @JsonKey(name: 'decription', defaultValue: '')
  String description;
  @JsonKey(name: 'albums', defaultValue: '')
  String albums;

  String get aName => name ?? '';
  String get aAlbum => albums ?? '';

  String get aDescription => description ?? '';

  String get aImage =>
      image ??
      'https://www.pngkit.com/png/full/302-3022217_roger-berry-avatar-placeholder.png';
}
