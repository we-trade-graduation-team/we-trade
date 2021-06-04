// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetails _$PostDetailsFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'postOwnerId',
    'itemImages',
    'title',
    'itemPrice',
    'itemCondition',
    'itemAddress',
    'tradeForList',
    'ownerAvatarURL',
    'ownerUsername',
    'ownerLastSeen',
    'ratings',
    'questions',
    'postOwnerOtherPostCards',
    'similarPostCards',
    'userMayAlsoLikePostCards'
  ]);
  return PostDetails(
    postOwnerId: json['postOwnerId'] as String,
    title: json['title'] as String,
    itemImages:
        (json['itemImages'] as List<dynamic>).map((e) => e as String).toList(),
    itemCondition: (json['itemCondition'] as num).toDouble(),
    tradeForList: (json['tradeForList'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    itemAddress: Address.fromJson(json['itemAddress'] as Map<String, dynamic>),
    ratings: Map<String, double>.from(json['ratings'] as Map),
    questions: (json['questions'] as List<dynamic>)
        .map((e) => PostQuestion.fromJson(e as Map<String, dynamic>))
        .toList(),
    itemPrice: (json['itemPrice'] as num).toDouble(),
    ownerAvatarURL: json['ownerAvatarURL'] as String,
    ownerUsername: json['ownerUsername'] as String,
    ownerLastSeen: DateTime.parse(json['ownerLastSeen'] as String),
    postOwnerOtherPostCards: (json['postOwnerOtherPostCards'] as List<dynamic>)
        .map((e) => PostCard.fromJson(e as Map<String, dynamic>))
        .toList(),
    similarPostCards: (json['similarPostCards'] as List<dynamic>)
        .map((e) => PostCard.fromJson(e as Map<String, dynamic>))
        .toList(),
    userMayAlsoLikePostCards:
        (json['userMayAlsoLikePostCards'] as List<dynamic>)
            .map((e) => PostCard.fromJson(e as Map<String, dynamic>))
            .toList(),
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$PostDetailsToJson(PostDetails instance) =>
    <String, dynamic>{
      'postOwnerId': instance.postOwnerId,
      'itemImages': instance.itemImages,
      'title': instance.title,
      'itemPrice': instance.itemPrice,
      'itemCondition': instance.itemCondition,
      'itemAddress': instance.itemAddress.toJson(),
      'tradeForList': instance.tradeForList,
      'description': instance.description,
      'ownerAvatarURL': instance.ownerAvatarURL,
      'ownerUsername': instance.ownerUsername,
      'ownerLastSeen': instance.ownerLastSeen.toIso8601String(),
      'ratings': instance.ratings,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'postOwnerOtherPostCards':
          instance.postOwnerOtherPostCards.map((e) => e.toJson()).toList(),
      'similarPostCards':
          instance.similarPostCards.map((e) => e.toJson()).toList(),
      'userMayAlsoLikePostCards':
          instance.userMayAlsoLikePostCards.map((e) => e.toJson()).toList(),
    };
