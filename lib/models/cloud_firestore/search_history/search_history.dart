import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


/// This allows the `SearchHistory` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'search_history.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents information about an Search History of Current User.
class SearchHistory extends ChangeNotifier {
  SearchHistory({
    this.searchHistory,
  }) {
    _init();
  }

  /// A necessary factory constructor for creating a new SearchHistory instance
  /// from a map. Pass the map to the generated `_$SearchHistoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case, SearchHistory.
  factory SearchHistory.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryFromJson(json);

  // final _authProvider = AuthProvider(FirebaseAuth.instance);

  Future<void> _init() async {
    // final _currentUser = _authProvider.currentUser;
    
    // final _currentUserUid = _currentUser?.uid;

    // final _searchHistoryRef = FirebaseFirestore.instance.doc(
    //   FirestorePath.user(
    //     uid: _currentUserUid!,
    //   ),
    // );
    // final _snapshots = await _searchHistoryRef.get();

    // // return snapshots.map(
    // //   (snapshot) => builder(snapshot),
    // // );
  }

  // @JsonKey(ignore: true)
  // final User? currentUser;

  final List<String>? searchHistory;

  void add(String searchTerm) {
    searchHistory?.add(searchTerm);
    notifyListeners();
  }

  void remove(String searchTerm) {
    searchHistory?.remove(searchTerm);
    notifyListeners();
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$SearchHistoryToJson`.
  Map<String, dynamic> toJson() => _$SearchHistoryToJson(this);
}
