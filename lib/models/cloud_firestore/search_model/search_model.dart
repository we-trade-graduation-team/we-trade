import 'package:flutter/material.dart';
import '../post_card_model/post_card/post_card.dart';

class SearchModel extends ChangeNotifier {
  SearchModel() {
    _init();
    // _doneLoading = _init();
  }

  // final User currentUser;

  // late Future<void> _doneLoading;
  // Future<void> get initializationDone => _doneLoading;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _query = '';
  String get query => _query;

  final _suggestions = <PostCard>[]; // = history;
  List<PostCard> get suggestions => _suggestions;

  late List<String> _searchHistory;
  List<String> get searchHistory => _searchHistory;

  Future<void> _init() async {
    // Load History

    // final _searchHistoryRef = FirebaseFirestore.instance.doc(
    //   FirestorePath.userSearchHistory(
    //     uid: currentUser.uid!,
    //   ),
    // );
    // final _snapshots = await _searchHistoryRef.get();

    // return snapshots.map(
    //   (snapshot) => builder(snapshot),
    // );
  }

  Future<void> onQueryChanged(String query) async {
    if (query == _query) {
      return;
    }

    _query = query;
    _isLoading = true;
    notifyListeners();

    // if (query.isEmpty) {
    //   _suggestions = history;
    // } else {
    //   final response = await http.get('https://photon.komoot.io/api/?q=$query');
    //   final body = json.decode(utf8.decode(response.bodyBytes));
    //   final features = body['features'] as List;

    //   _suggestions = features.map((e) => PostCard.fromJson(e)).toSet().toList();
    // }

    _isLoading = false;

    notifyListeners();
  }

  void clear() {
    _suggestions.clear();
    notifyListeners();
  }
}
