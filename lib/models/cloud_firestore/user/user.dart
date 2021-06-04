import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents information about a User.
class User {
  User({
    required this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.uid,
    this.photoURL,
    this.phoneNumber,
    this.dob,
    this.presence,
    this.lastSeen,
    this.searchHistory,
    this.isEmailVerified = false,
    // this.recommendedPostCards,
    // this.specialOfferCards,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$UserFromJson(snapshot.data() as Map<String, dynamic>)
        ..uid = snapshot.id;

  @JsonKey(ignore: true)
  String? uid;

  @JsonKey(required: true)
  final String? email;

  @JsonKey(required: true)
  String? username;

  /// Tell json_serializable that "avatarUrl" should be
  /// mapped to this property.
  @JsonKey(name: 'avatarUrl')
  final String? photoURL;

  final String? firstName;

  final String? lastName;

  /// Tell json_serializable that "phone" should be
  /// mapped to this property.
  @JsonKey(name: 'phone')
  final String? phoneNumber;

  final DateTime? dob;

  @JsonKey(required: true)
  bool? presence;

  @JsonKey(required: true)
  final int? lastSeen;

  final bool? isEmailVerified;

  final List<String>? searchHistory;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() {
    final json = _$UserToJson(this);
    json.removeWhere((key, dynamic value) => key == 'uid');
    return json;
  }
}
