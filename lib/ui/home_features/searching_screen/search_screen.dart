import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import '../../../app_localizations.dart';
import '../../../models/cloud_firestore/search_model/search_model.dart';
import '../../../models/cloud_firestore/user/user.dart';
import 'local_widgets/body.dart';
import 'local_widgets/expandable_body.dart';
import 'local_widgets/filter_overlay.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _historyLength = 5;

  late FloatingSearchBarController _controller;

  // The currently searched-for term
  String? _selectedTerm;

  // The "raw" history that we don't access from the UI, prefilled with values
  late List<String> _searchHistory;

  // The filtered & ordered history that's accessed from the UI
  late List<String> _filteredSearchHistory;

  void loadSearchHistory() {
    final user = context.read<User?>();
    if (user != null) {
      _searchHistory = user.searchHistory ?? [];
    }
  }

  List<String> filterSearchTerms({
    required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > _historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - _historyLength);
    }

    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    _filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    _filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void onSubmitted(String query) {
    setState(() {
      if (query.isNotEmpty) {
        addSearchTerm(query);
        _selectedTerm = query;
      } else {
        _selectedTerm = null;
      }
    });
    _controller.close();
  }

  void onQueryChanged(String query) {
    setState(() {
      _filteredSearchHistory = filterSearchTerms(filter: query);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    _filteredSearchHistory = filterSearchTerms(filter: null);
    Timer(const Duration(milliseconds: 300), _controller.open);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      Builder(
        builder: (_) {
          return FloatingSearchBarAction.icon(
            icon: const Icon(
              Icons.filter_alt_outlined,
              // color: Theme.of(context).primaryColor,
            ),
            onTap: showFilterOverlay,
          );
        },
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final _appLocalizations = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (_) => SearchModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<SearchModel>(
          builder: (_, model, __) => FloatingSearchBar(
            // automaticallyImplyBackButton: false,
            controller: _controller,
            iconColor: Colors.grey,
            // transitionDuration: const Duration(milliseconds: 500),
            transitionCurve: Curves.easeInOut,
            // Bouncing physics for the search history
            physics: const BouncingScrollPhysics(),
            axisAlignment: isPortrait ? 0.0 : -1.0,
            openAxisAlignment: 0,
            // Title is displayed on an unopened (inactive) search bar
            title: buildTitle(_appLocalizations.translate('appTxtTitle')),
            actions: actions,
            progress: model.isLoading,
            debounceDelay: const Duration(microseconds: 500),
            onQueryChanged: model.onQueryChanged,
            onSubmitted: onSubmitted,
            scrollPadding: EdgeInsets.zero,
            transition: CircularFloatingSearchBarTransition(),
            builder: (context, _) => ExpandableBody(model: model),
            body: Body(selectedTerm: _selectedTerm),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Text(
      _selectedTerm ?? title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  void showFilterOverlay() {
    showDialog<FilterOverlay>(
      context: context,
      builder: (_) => const FilterOverlay(),
    );
  }
}
