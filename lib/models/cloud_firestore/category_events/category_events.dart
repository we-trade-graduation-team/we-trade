import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_events.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents a Category Events.
class CategoryEvents {
  CategoryEvents({
    required this.events,
    this.categoryId,
  });

  factory CategoryEvents.fromJson(Map<String, dynamic> json) =>
      _$CategoryEventsFromJson(json);

  factory CategoryEvents.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$CategoryEventsFromJson(snapshot.data() as Map<String, dynamic>)
        ..categoryId = snapshot.id;

  @JsonKey(ignore: true)
  String? categoryId;

  @JsonKey(required: true)
  final List<String> events;

  Map<String, dynamic> toJson() {
    final json = _$CategoryEventsToJson(this);
    json.removeWhere((key, dynamic value) => key == 'categoryId');
    return json;
  }
}
