import 'package:flutter/material.dart';
import '../post_card/post_card.dart';

class SearchModel extends ChangeNotifier {
  SearchModel() {
    _doneLoading = _init();
  }
  late Future<void> _doneLoading;

  Future<void> get initializationDone => _doneLoading;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // late List<PostCard> _history;
  late List<PostCard> _suggestions;
  List<PostCard> get suggestions => _suggestions;

  String _query = '';
  String get query => _query;

  Future<void> _init() async {
    // TODO Load History
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
