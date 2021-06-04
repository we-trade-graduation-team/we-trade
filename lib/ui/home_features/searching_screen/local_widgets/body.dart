import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../local_widgets/search_results_list_view.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.selectedTerm,
  }) : super(key: key);

  final String? selectedTerm;

  @override
  Widget build(BuildContext context) {
    return SearchResultsListView(
      searchTerm: selectedTerm,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedTerm', selectedTerm));
  }
}
