import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'calls.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    FlutterLibphonenumber().init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Who Called Me?',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Who Called Me?"),
          ),
          body: const Calls(),
        ));
  }
}
