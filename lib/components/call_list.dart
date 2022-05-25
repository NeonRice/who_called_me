import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../models/folded_call_log.dart';

class CallList extends StatelessWidget {
  const CallList({Key? key, required this.calls, this.onPressed})
      : super(key: key);

  final List<FoldedCallLogEntry> calls;
  final Map<CallType, Icon> callTypeIcons = const {
    CallType.missed: Icon(Icons.call_missed),
    CallType.incoming: Icon(Icons.call_received),
    CallType.rejected: Icon(Icons.call_end),
  };
  final void Function(String call)? onPressed;

  ListTile _buildRow(FoldedCallLogEntry call) {
    var maskedNumber = call.number;
    CountryWithPhoneCode? guessedCountry;

    if (maskedNumber != null) {
      guessedCountry = CountryWithPhoneCode.getCountryDataByPhone(maskedNumber);
      // Assuming FlutterLibphonenumber.init() called
      maskedNumber = FlutterLibphonenumber().formatNumberSync(maskedNumber,
          country: guessedCountry, inputContainsCountryCode: true);
    }

    var callCountLabel = "";
    if (call.callCount > 1) {
      callCountLabel = "(${call.callCount})";
    }

    return ListTile(
      title: Text(
        (maskedNumber ?? "Unknown") + " $callCountLabel",
      ),
      subtitle: Row(
        children: [
          callTypeIcons[call.callType] ?? const Icon(Icons.call),
          Text(guessedCountry?.countryName ?? ""),
        ],
      ),
      onTap: () => onPressed!(maskedNumber ?? ""),
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
