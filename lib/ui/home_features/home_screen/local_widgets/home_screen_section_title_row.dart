import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import '../../../../app_localizations.dart';
import '../../../../models/ui/home_features/home_screen/section_title_row_model.dart';

class HomeScreenSectionTitleRow extends StatelessWidget {
  const HomeScreenSectionTitleRow({
    Key? key,
    required this.sectionTitleRowModel,
  }) : super(key: key);

  final SectionTitleRowModel sectionTitleRowModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final _appLocalization = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sectionTitleRowModel.title,
            style: const TextStyle(fontSize: 18),
          ),
          // if (sectionTitleRowModel.seeMore)
          //   GestureDetector(
          //     onTap: sectionTitleRowModel.press,
          //     child: Text(
          //       _appLocalization
          //           .translate('homeScreenTxtSectionTitleRowSeeMore'),
          //       style: TextStyle(
          //         color: ((Theme.of(context).textTheme.bodyText2)!.color)!
          //             .withOpacity(0.5),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SectionTitleRowModel>(
        'sectionTitleRowModel', sectionTitleRowModel));
  }
}
