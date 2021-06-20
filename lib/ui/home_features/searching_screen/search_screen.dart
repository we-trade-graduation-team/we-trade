import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import '../../../app_localizations.dart';
import '../../../models/cloud_firestore/search_model/search_model.dart';
import 'local_widgets/body.dart';
import 'local_widgets/expandable_body.dart';
import 'local_widgets/filter_overlay.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchModel(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: SearchScreenFloatingSearchBar(),
      ),
    );

    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (_) => SearchModel(
    //         currentUser: _currentUser,
    //       ),
    //     ),
    //   ],
    //   child: const Scaffold(
    //     resizeToAvoidBottomInset: false,
    //     body: SearchScreenFloatingSearchBar(),
    //   ),
    // );
  }
}

class SearchScreenFloatingSearchBar extends StatefulWidget {
  const SearchScreenFloatingSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchScreenFloatingSearchBarState createState() =>
      _SearchScreenFloatingSearchBarState();
}

class _SearchScreenFloatingSearchBarState
    extends State<SearchScreenFloatingSearchBar> {
  static const _historyLength = 5;

  late FloatingSearchBarController _controller;

  // The currently searched-for term
  String? _selectedTerm;

  // The "raw" history that we don't access from the UI, prefilled with values
  late List<String> _searchHistory=[];

  // The filtered & ordered history that's accessed from the UI
  late List<String> filteredSearchHistory;

  // void loadSearchHistory() {
  //   final user = context.read<User?>();
  //   if (user != null) {
  //     _searchHistory = user.searchHistory ?? [];
  //   }
  // }

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

  void _addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      _putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > _historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - _historyLength);
    }

    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void _deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void _putSearchTermFirst(String term) {
    _deleteSearchTerm(term);
    _addSearchTerm(term);
  }

  void _onSubmitted(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _addSearchTerm(query);
        _selectedTerm = query;
      } else {
        _selectedTerm = null;
      }
    });
    _controller.close();
  }

  // void _onQueryChanged(String query) {
  //   setState(() {
  //     filteredSearchHistory = filterSearchTerms(filter: query);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
    Timer(const Duration(milliseconds: 300), _controller.open);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _actions = [
      Builder(
        builder: (_) {
          return FloatingSearchBarAction.icon(
            icon: const Icon(Icons.filter_alt_outlined),
            onTap: _showFilterOverlay,
          );
        },
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];
    final _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final _appLocalizations = AppLocalizations.of(context);

    final _searchModel = context.watch<SearchModel>();

    return FloatingSearchBar(
      // automaticallyImplyBackButton: false,
      controller: _controller,
      iconColor: Colors.grey,
      // transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      // Bouncing physics for the search history
      physics: const BouncingScrollPhysics(),
      axisAlignment: _isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0,
      // Title is displayed on an unopened (inactive) search bar
      title: _buildTitle(_appLocalizations.translate('appTxtTitle')),
      actions: _actions,
      progress: _searchModel.isLoading,
      debounceDelay: const Duration(microseconds: 500),
      onQueryChanged: _searchModel.onQueryChanged,
      onSubmitted: _onSubmitted,
      scrollPadding: EdgeInsets.zero,
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, _) => ExpandableBody(model: _searchModel),
      body: Body(selectedTerm: _selectedTerm),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      _selectedTerm ?? title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  void _showFilterOverlay() {
    showDialog<FilterOverlay>(
      context: context,
      builder: (_) => const FilterOverlay(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>(
        'filteredSearchHistory', filteredSearchHistory));
  }
}
