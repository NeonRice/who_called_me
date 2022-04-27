import 'package:call_log/call_log.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter/material.dart';

class CallList extends StatelessWidget {
  const CallList({Key? key, required this.calls}) : super(key: key);

  final List<CallLogEntry> calls;

  ListTile _buildRow(CallLogEntry call) {
    var maskedNumber = call.number;
    if (maskedNumber != null) {
      // Assuming FlutterLibphonenumber.init() called
      maskedNumber = FlutterLibphonenumber()
          .formatNumberSync(maskedNumber, inputContainsCountryCode: true);
    }

    return ListTile(
      title: Text(
        maskedNumber ?? "Unknown",
      ),
      subtitle: Text(call.number ?? ""),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (calls.isEmpty) {
      return Column(children: const [
        Icon(
          Icons.question_mark,
          color: Colors.grey,
          size: 60,
        ),
        Text("Nothing found!")
      ]);
    }

    return ListView.separated(
      //children: rows.toList(),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) => _buildRow(calls[index]),
      itemCount: calls.length,
    );
  }
}

class Calls extends StatefulWidget {
  const Calls({Key? key}) : super(key: key);
  @override
  _CallsState createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  @override
  void initState() {
    super.initState();
    // TODO: Put in app init? Add a possibility to load from local if no internet
    FlutterLibphonenumber().init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CallLog.query(type: CallType.incoming),
      builder: (BuildContext context,
          AsyncSnapshot<Iterable<CallLogEntry>> entries) {
        Widget child;

        if (entries.hasError) {
          child = Column(
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 60,
              ),
              Text("Error occured")
            ],
          );
        }

        if (entries.hasData) {
          child = CallList(calls: entries.data?.toList() ?? []);
        } else {
          // Loading
          child = Column(
            children: const [CircularProgressIndicator(), Text('Loading...')],
          );
        }

        return Center(
          child: child,
        );
      },
    );
  }
}
