// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_special_offer_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSpecialOfferCard _$UserSpecialOfferCardFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['category', 'photoUrl']);
  return UserSpecialOfferCard(
    category: json['category'] as String,
    photoUrl: json['photoUrl'] as String,
    numberOfBrands: json['numberOfBrands'] as int? ?? 0,
  );
}

Map<String, dynamic> _$UserSpecialOfferCardToJson(
        UserSpecialOfferCard instance) =>
    <String, dynamic>{
      'category': instance.category,
      'photoUrl': instance.photoUrl,
      'numberOfBrands': instance.numberOfBrands,
    };
