import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';

import '../components/call_list.dart';
import '../models/folded_call_log.dart';

Future<List<FoldedCallLogEntry>> getFoldedCallLogs(
    {List<CallType>? filteredCallType}) async {
  var calls = await CallLog.get();
  List<FoldedCallLogEntry> foldedCalls = [];
  FoldedCallLogEntry? previous;

  for (final call in calls) {
    if (filteredCallType != null &&
        filteredCallType.isNotEmpty &&
        !filteredCallType.any((element) => element == call.callType)) {
      continue;
    }

    if (previous?.number != call.number ||
        previous?.callType != call.callType) {
      if (previous != null) {
        foldedCalls.add(previous);
      }
      previous = FoldedCallLogEntry.fromCallEntry(call: call, callCount: 0);
    }
    ++previous?.callCount;
  }

  return foldedCalls;
}

// Calls history page
class Calls extends StatefulWidget {
  const Calls({Key? key}) : super(key: key);
  @override
  _CallsState createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  late List<FoldedCallLogEntry> calls;

  // Show only these types of calls
  final List<CallType> filteredTypes = [
    CallType.missed,
    CallType.incoming,
    CallType.rejected,
    CallType.blocked
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFoldedCallLogs(filteredCallType: filteredTypes),
      builder: (BuildContext context,
          AsyncSnapshot<List<FoldedCallLogEntry>> entries) {
        Widget child;

        if (entries.hasError) {
          child = Column(
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 60,
              ),
              Text("Error occurred")
            ],
          );
        }

        if (entries.hasData) {
          child = CallList(
            calls: entries.data?.toList() ?? [],
            onPressed: (FoldedCallLogEntry call) {
              Navigator.pushNamed(context, "/comments", arguments: call);
            },
          );
        } else {
          // Loading
          child = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [CircularProgressIndicator(), Text('Loading...')],
          );
        }

        return Center(
          child: RefreshIndicator(
              child: child,
              onRefresh: () async {
                var retrievedCalls =
                    await getFoldedCallLogs(filteredCallType: filteredTypes);
                setState(() {
                  calls = retrievedCalls;
                });
              }),
        );
      },
    );
  }
}
