import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class VideoMeta {
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "tracklist")
  bool tracklist;
  @JsonKey(name: "tracknumbers")
  bool tracknumbers;
  @JsonKey(name: "images")
  bool images;
  @JsonKey(name: "artists")
  bool artists;
  @JsonKey(name: "tracks")
  List<Track> tracks;

  VideoMeta({
    required this.type,
    required this.tracklist,
    required this.tracknumbers,
    required this.images,
    required this.artists,
    required this.tracks,
  });

  factory VideoMeta.fromJson(Map<String, dynamic> json) =>
      _$VideoMetaFromJson(json);

  Map<String, dynamic> toJson() => _$VideoMetaToJson(this);
}

@JsonSerializable()
class Track {
  @JsonKey(name: "src")
  String src;
  @JsonKey(name: "src0")
  String src0;
  @JsonKey(name: "src1")
  String src1;
  @JsonKey(name: "src2")
  String src2;
  @JsonKey(name: "src3")
  String src3;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "caption")
  String caption;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "image")
  Image image;
  @JsonKey(name: "thumb")
  Image thumb;
  @JsonKey(name: "meta")
  Meta meta;
  @JsonKey(name: "portn")
  String portn;
  @JsonKey(name: "srctype")
  dynamic srctype;
  @JsonKey(name: "cut")
  String cut;
  @JsonKey(name: "vttshift")
  String vttshift;
  @JsonKey(name: "userIP")
  String userIp;
  @JsonKey(name: "subsrc")
  String subsrc;
  @JsonKey(name: "dimensions")
  Dimensions dimensions;

  Track({
    required this.src,
    required this.src0,
    required this.src1,
    required this.src2,
    required this.src3,
    required this.title,
    required this.type,
    required this.caption,
    required this.description,
    required this.image,
    required this.thumb,
    required this.meta,
    required this.portn,
    required this.srctype,
    required this.cut,
    required this.vttshift,
    required this.userIp,
    required this.subsrc,
    required this.dimensions,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);
}

@JsonSerializable()
class Dimensions {
  @JsonKey(name: "original")
  Original original;
  @JsonKey(name: "resized")
  Original resized;

  Dimensions({
    required this.original,
    required this.resized,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class Original {
  @JsonKey(name: "width")
  String width;
  @JsonKey(name: "height")
  String height;

  Original({
    required this.width,
    required this.height,
  });

  factory Original.fromJson(Map<String, dynamic> json) =>
      _$OriginalFromJson(json);

  Map<String, dynamic> toJson() => _$OriginalToJson(this);
}

@JsonSerializable()
class Image {
  @JsonKey(name: "src")
  String src;
  @JsonKey(name: "width")
  int width;
  @JsonKey(name: "height")
  int height;

  Image({
    required this.src,
    required this.width,
    required this.height,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "length_formatted")
  String lengthFormatted;

  Meta({
    required this.lengthFormatted,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
