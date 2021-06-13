import 'package:json_annotation/json_annotation.dart';

part 'post_details_viewer.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents detail information about a Post Viewer.
class PostDetailsViewer {
  PostDetailsViewer({
    required this.isFavoritePost,
  });

  factory PostDetailsViewer.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsViewerFromJson(json);

  @JsonKey(required: true)
  final bool isFavoritePost;

  // may also like postCards

  Map<String, dynamic> toJson() => _$PostDetailsViewerToJson(this);
}
