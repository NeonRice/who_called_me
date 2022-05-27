import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';

import 'models/folded_call_log.dart';
import 'views/call_info.dart';
import 'views/calls.dart';
import 'views/history_page.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (_) => const Calls());

    case "/comments":
      if (settings.arguments == null) {
        throw "Route must have arguments";
      }
      var args = settings.arguments as FoldedCallLogEntry;
      return MaterialPageRoute(
          builder: (_) => CallInfo(
              number: args.number ?? "-",
              callType: args.callType ?? CallType.unknown));
    case "/history":
      return MaterialPageRoute(builder: (_) => const HistoryPage());
    default:
      throw "No route";
  }
}
