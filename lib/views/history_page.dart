import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/call_list.dart';

class HistoryPage extends StatefulWidget {
  final String number;

  const HistoryPage({Key? key, required this.number}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Who Called Me?"),
      ),
      body: CallList(calls: []),
    );
  }
}
