// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEvents _$CategoryEventsFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['events']);
  return CategoryEvents(
    events: (json['events'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$CategoryEventsToJson(CategoryEvents instance) =>
    <String, dynamic>{
      'events': instance.events,
    };
