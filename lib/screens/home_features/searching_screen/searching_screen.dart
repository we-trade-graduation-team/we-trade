import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../configs/constants/color.dart';
import '../filterOverlay/filter_overlay.dart';
// import 'package:provider/provider.dart';

import '../../../configs/constants/color.dart';
import '../../../configs/constants/strings.dart';
import 'local_widgets/initial_content.dart';
import 'local_widgets/search_results_list_view.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/searching';

  @override
  _SearchingScreenState createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  static const historyLength = 5;

  final _searchHistory = [
    'fuchsia',
    'flutter',
    'widgets',
    'controller',
  ];

  late List<String> filteredSearchHistory;

  String? selectedTerm;

  late FloatingSearchBarController controller;

  List<String> filterSearchTerms({
    required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
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
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void onSubmitted(String query) {
    setState(() {
      if (query.isNotEmpty) {
        addSearchTerm(query);
        selectedTerm = query;
      } else {
        selectedTerm = null;
      }
    });
    controller.close();
  }

  void onQueryChanged(String query) {
    setState(() {
      filteredSearchHistory = filterSearchTerms(filter: query);
    });
  }

  void showFilterOverlay({required BuildContext context}) {
    showDialog<FilterOverlay>(
        context: context,
        builder: (context){
          return const FilterOverlay();
        }
    );
  }

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);

    Timer(const Duration(milliseconds: 300), () => controller.open());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildSearchBar(),
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     SearchResultsListView(
      //       searchTerm: selectedTerm,
      //     ),
      //     buildSearchBar(),
      //   ],
      // ),
    );
  }

  Widget buildSearchBar() {
    final actions = [
      // FloatingSearchBarAction(
      //   child: CircularButton(
      //     icon: const Icon(Icons.camera_alt_outlined),
      //     onPressed: () {},
      //   ),
      // ),
      Builder(builder: (context) {
        return FloatingSearchBarAction.icon(
          icon: const Icon(
            Icons.filter_alt_outlined,
            color: kPrimaryColor,
          ),
          onTap: () => showFilterOverlay(context: context),
        );
      }),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      // automaticallyImplyBackButton: false,
      controller: controller,
      iconColor: Colors.grey,
      // transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0,
      title: buildTitle(kAppTitle),
      actions: actions,
      // progress: model.isLoading,
      onQueryChanged: onQueryChanged,
      debounceDelay: const Duration(microseconds: 500),
      // onQueryChanged: model.onQueryChanged,
      onSubmitted: onSubmitted,
      scrollPadding: EdgeInsets.zero,
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, _) => buildExpandableBody(),
      body: buildBody(),
    );
  }
  // final size = MediaQuery.of(context).size;
  //   return Consumer<>(
  //     builder: (context, model, _) => FloatingSearchBar(
  //       // automaticallyImplyBackButton: false,
  //       controller: controller,
  //       hint: hint,
  //       iconColor: Colors.grey,
  //       transitionDuration: const Duration(milliseconds: 800),
  //       transitionCurve: Curves.easeInOutCubic,
  //       physics: const BouncingScrollPhysics(),
  //       axisAlignment: isPortrait ? 0.0 : -1.0,
  //       openAxisAlignment: 0,
  //       title: buildTitle(title),
  //       actions: actions,
  //       progress: model.isLoading,
  //       onQueryChanged: (query) {
  //         setState(() {
  //           filteredSearchHistory = filterSearchTerms(filter: query);
  //         });
  //       },
  //       // onQueryChanged: model.onQueryChanged,
  //       onSubmitted: onSubmitted,
  //       scrollPadding: EdgeInsets.zero,
  //       transition: CircularFloatingSearchBarTransition(),
  //       builder: (context, _) => buildExpandableBody(),
  //       body: buildBody(),
  //     ),
  //   );
  // }

  Widget buildTitle(String title) {
    return Text(
      selectedTerm ?? title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildExpandableBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4,
          child: Builder(
            builder: (context) {
              if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                return const InitialContent();
              } else if (filteredSearchHistory.isEmpty) {
                return ListTile(
                  title: Text(controller.query),
                  leading: const Icon(Icons.search),
                  onTap: () => onSubmitted(controller.query),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredSearchHistory
                      .map(
                        (term) => ListTile(
                          title: Text(
                            term,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: const Icon(Icons.history),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                deleteSearchTerm(term);
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              putSearchTermFirst(term);
                              selectedTerm = term;
                            });
                            controller.close();
                          },
                        ),
                      )
                      .toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return SearchResultsListView(
      searchTerm: selectedTerm,
    );
    // return FloatingSearchBarScrollNotifier(
    //   child: SearchResultsListView(
    //     searchTerm: selectedTerm,
    //   ),
    // );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>(
        'filteredSearchHistory', filteredSearchHistory));
    properties.add(StringProperty('selectedTerm', selectedTerm));
    properties.add(DiagnosticsProperty<FloatingSearchBarController>(
        'controller', controller));
  }
}