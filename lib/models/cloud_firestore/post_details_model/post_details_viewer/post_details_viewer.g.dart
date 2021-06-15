// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_viewer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsViewer _$PostDetailsViewerFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['isFavoritePost']);
  return PostDetailsViewer(
    isFavoritePost: json['isFavoritePost'] as bool,
  );
}

Map<String, dynamic> _$PostDetailsViewerToJson(PostDetailsViewer instance) =>
    <String, dynamic>{
      'isFavoritePost': instance.isFavoritePost,
    };
