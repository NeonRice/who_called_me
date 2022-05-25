import 'package:flutter/material.dart';

class CallInfo extends StatefulWidget {
  final String number;

  const CallInfo({Key? key, required this.number}) : super(key: key);

  @override
  _CallInfoState createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who Called Me?"),
      ),
      body: Column(
        children: [Text(widget.number), Text("Lithuania")],
      ),
    );
  }
}
