import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keyword.g.dart';

@JsonSerializable(explicitToJson: true)

// Represent keyword
class Keyword {
  Keyword({
    required this.keyword,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      _$KeywordFromJson(json);

  factory Keyword.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$KeywordFromJson(snapshot.data() as Map<String, dynamic>)
        ..keywordId = snapshot.id;

  @JsonKey(ignore: true)
  String? keywordId;

  @JsonKey(required: true)
  final String keyword;

  Map<String, dynamic> toJson() => _$KeywordToJson(this);
}
