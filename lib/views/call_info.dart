import 'package:flutter/cupertino.dart';
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
      body: Stack(children: <Widget>[
        Center(
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
              SizedBox(
                height: 600,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, index) => const ListTile(
                    leading: Icon(
                      Icons.account_circle_outlined,
                      size: 35,
                    ),
                    title: Text(
                      "Petras",
                    ),
                    subtitle: Text("Skambina pastoviai sitas numeris",
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic)),
                  ),
                  itemCount: 2,
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,

          ///Your TextBox Container
          child: Container(
              height: 20.0,
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              alignment: Alignment.bottomCenter,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                // First child is enter comment text input
                TextFormField(
                  //controller: commentController,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: "Some Text",
                    labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    fillColor: Colors.blue,
                    border: OutlineInputBorder(
                        // borderRadius:
                        //     BorderRadius.all(Radius.zero(5.0)),
                        borderSide: BorderSide(color: Colors.purpleAccent)),
                  ),
                ),
                // Second child is button
                const IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 20.0,
                  onPressed: null,
                )
              ])),
        )
      ]),
    );
  }
}
