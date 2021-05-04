import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../bloc/report_bloc.dart';
import 'report_screen.dart';

class BuildReportScreen extends StatelessWidget {
  const BuildReportScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/report';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReportBloc>(create: (context) => ReportBloc())
      ],
      child: const ReportScreen(),
    );
  }
}
