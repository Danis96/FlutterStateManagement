import 'package:json_annotation/json_annotation.dart';

part 'artist_albums_model.g.dart';

@JsonSerializable()
class ArtistAlbumModel {
  ArtistAlbumModel({
    this.name,
    this.songsNumber,
    this.songs,
    this.coverImage,
    this.published,
  });

  factory ArtistAlbumModel.fromJson(dynamic json) =>
      _$ArtistAlbumModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$ArtistAlbumModelToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  String? name;
  @JsonKey(name: 'published', defaultValue: 0)
  int? published;
  @JsonKey(name: 'cover', defaultValue: '')
  String? coverImage;
  @JsonKey(name: 'songs_num', defaultValue: 0)
  int? songsNumber;
  @JsonKey(name: 'songs', defaultValue: '')
  String? songs;

  String get albumName => name ?? '';

  int get albumPublished => published ?? 0;

  String get albumImage =>
      coverImage ??
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fblog.spoongraphics.co.uk%2Farticles%2Fshowcase-creative-album-cover-designs-illustrations&psig=AOvVaw1zOfbiL7NwscWSOo7a0JVD&ust=1616840050445000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIDkgOHcze8CFQAAAAAdAAAAABAD';

  int get albumSongsNumber => songsNumber ?? 0;

  String get albumSongs => songs ?? '';
}
