// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'special_offer_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialOfferCard _$SpecialOfferCardFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['category', 'photoUrl']);
  return SpecialOfferCard(
    category: json['category'] as String,
    photoUrl: json['photoUrl'] as String,
    numberOfBrands: json['numberOfBrands'] as int? ?? 0,
  );
}

Map<String, dynamic> _$SpecialOfferCardToJson(SpecialOfferCard instance) =>
    <String, dynamic>{
      'category': instance.category,
      'photoUrl': instance.photoUrl,
      'numberOfBrands': instance.numberOfBrands,
    };
