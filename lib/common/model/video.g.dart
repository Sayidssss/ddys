// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoMeta _$VideoMetaFromJson(Map<String, dynamic> json) => VideoMeta(
      type: json['type'] as String,
      tracklist: json['tracklist'] as bool,
      tracknumbers: json['tracknumbers'] as bool,
      images: json['images'] as bool,
      artists: json['artists'] as bool,
      tracks: (json['tracks'] as List<dynamic>)
          .map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoMetaToJson(VideoMeta instance) => <String, dynamic>{
      'type': instance.type,
      'tracklist': instance.tracklist,
      'tracknumbers': instance.tracknumbers,
      'images': instance.images,
      'artists': instance.artists,
      'tracks': instance.tracks,
    };

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      src: json['src'] as String,
      src0: json['src0'] as String,
      src1: json['src1'] as String,
      src2: json['src2'] as String,
      src3: json['src3'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      caption: json['caption'] as String,
      description: json['description'] as String,
      image: Image.fromJson(json['image'] as Map<String, dynamic>),
      thumb: Image.fromJson(json['thumb'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      portn: json['portn'] as String,
      srctype: (json['srctype'] as num).toInt(),
      cut: json['cut'] as String,
      vttshift: json['vttshift'] as String,
      userIp: json['userIP'] as String,
      subsrc: json['subsrc'] as String,
      dimensions:
          Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'src': instance.src,
      'src0': instance.src0,
      'src1': instance.src1,
      'src2': instance.src2,
      'src3': instance.src3,
      'title': instance.title,
      'type': instance.type,
      'caption': instance.caption,
      'description': instance.description,
      'image': instance.image,
      'thumb': instance.thumb,
      'meta': instance.meta,
      'portn': instance.portn,
      'srctype': instance.srctype,
      'cut': instance.cut,
      'vttshift': instance.vttshift,
      'userIP': instance.userIp,
      'subsrc': instance.subsrc,
      'dimensions': instance.dimensions,
    };

Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => Dimensions(
      original: Original.fromJson(json['original'] as Map<String, dynamic>),
      resized: Original.fromJson(json['resized'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DimensionsToJson(Dimensions instance) =>
    <String, dynamic>{
      'original': instance.original,
      'resized': instance.resized,
    };

Original _$OriginalFromJson(Map<String, dynamic> json) => Original(
      width: json['width'] as String,
      height: json['height'] as String,
    );

Map<String, dynamic> _$OriginalToJson(Original instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      src: json['src'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'src': instance.src,
      'width': instance.width,
      'height': instance.height,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      lengthFormatted: json['length_formatted'] as String,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'length_formatted': instance.lengthFormatted,
    };
