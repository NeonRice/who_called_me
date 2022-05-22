import 'package:call_log/call_log.dart';

class FoldedCallLogEntry extends CallLogEntry {
  /// constructor
  FoldedCallLogEntry({
    required this.callCount,
    name,
    number,
    callType,
    duration,
    timestamp,
  }) : super(
            name: name,
            number: number,
            callType: callType,
            duration: duration,
            timestamp: timestamp);

  FoldedCallLogEntry.fromCallEntry(
      {required CallLogEntry call, required this.callCount})
      : super(
            name: call.name,
            number: call.number,
            callType: call.callType,
            duration: call.duration,
            timestamp: call.timestamp);

  int callCount;
}
