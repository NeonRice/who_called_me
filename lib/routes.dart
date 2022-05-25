import 'package:flutter/material.dart';

import 'views/call_info.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/comments":
      if (settings.arguments == null) {
        throw "Route must have arguments";
      }
      return MaterialPageRoute(
          builder: (_) => CallInfo(number: settings.arguments as String));
    default:
      throw "No route";
  }
}
