import 'package:flutter/material.dart';

class CallInfo extends StatefulWidget {
  final String number;

  const CallInfo({Key? key, required this.number}) : super(key: key);

  @override
  _CallInfoState createState() => _CallInfoState();
}

class _SingleComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: const <Widget>[
        ListTile(
          leading: Icon(
            Icons.account_circle_outlined,
            size: 35,
          ), //Icon goes here
          title: Text(
            "Petras",
            //style: TextStyle(fontSize: 25, height: 2),
          ),
          subtitle: Text("Skambina pastoviai sitas numeris ",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
        )
      ],
    ));
  }
}

class _CallInfoState extends State<CallInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who Called Me?"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(
                      Icons.phone,
                      size: 40,
                    ), //Icon goes here
                    title: Text(
                      "+36999999999",
                      style: TextStyle(fontSize: 25, height: 2),
                    ),
                    subtitle: Text("Lithuania"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text(
                        'Last updated at: ',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const Text('2021-05-15 14:56',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      const SizedBox(width: 8),
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.refresh_sharp,
                            size: 24,
                          ),
                          label: const Text("Refresh")),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children:
                 <Widget>[
                  for (var i = 0; i < 5; i++)
                  ListTile(
                    leading: Icon(
                      Icons.account_circle_outlined,
                      size: 35,
                    ), //Icon goes here
                    title: Text(
                      "Petras",
                      //style: TextStyle(fontSize: 25, height: 2),
                    ),
                    subtitle: Text("Skambina pastoviai sitas numeris ",
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic)),
                  )
                ],
              ),
            )
          ],

          //children: [Text(widget.number), Text("Lithuania")],
        ),
      ),
    );
  }
}
