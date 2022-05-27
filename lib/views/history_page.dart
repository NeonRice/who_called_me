import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../components/call_list.dart';
import '../models/folded_call_log.dart';
import '../providers/database.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Who Called Me?"),
      ),
      body: FutureBuilder(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<FoldedCallLogEntry> numbers =
                snapshot.data as List<FoldedCallLogEntry>;
            return CallList(
                calls: numbers, onPressed: (FoldedCallLogEntry call) {
                  Navigator.pushNamed(context, "/comments", arguments: call);
              });
          } else if (snapshot.hasError) {
            return const Text("Error occured!");
          } else {
            return Column(children: const [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ]);
          }
        }),
        future: NumberDatabase().distinctNumbers(),
      ),
    );
  }
}
