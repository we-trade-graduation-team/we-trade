import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_trade/screens/category/category.dart';
import 'package:we_trade/screens/filterOverlay/filter_overlay.dart';
import 'package:we_trade/screens/notification/detailed_notification_screen.dart';
import 'package:we_trade/screens/notification/notification_screen.dart';
import 'package:we_trade/screens/report/report_screen.dart';
import 'package:we_trade/widgets/bottom_navigation_bar.dart';


import 'bloc/report_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({ required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: /*MultiProvider(
        providers: [
          ChangeNotifierProvider<ReportBloc>(
              create: (context)=>ReportBloc()
          ),
        ],
        child:*/Category(),
      //),

      bottomNavigationBar: BuildBottomNavigationBar(selectedIndex: 0),
    );
  }
}

