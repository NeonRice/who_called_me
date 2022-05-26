import 'package:flutter/material.dart';

class CallInfo extends StatefulWidget {
  final String number;

  const CallInfo({Key? key, required this.number}) : super(key: key);

  @override
  _CallInfoState createState() => _CallInfoState();
}

class _TextInput extends StatelessWidget {
  const _TextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Input your comment',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
              iconSize: 40.0,
            ),
          ],
        ));
  }
}

class _SingleComment extends StatelessWidget {
  final String username;
  final String comment;
  final DateTime dateTime;

  const _SingleComment(
      {Key? key,
      required this.username,
      required this.comment,
      required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.account_circle_outlined,
        size: 35,
      ),
      title: Text(username),
      subtitle: Text(comment,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
      trailing: Text(
          dateTime.toString(),
          style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic))
    );
  }
}

class _CommentBox extends StatelessWidget {
  final int commentNum;

  const _CommentBox({Key? key, required this.commentNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) => _SingleComment(
            username: "Jolkandra",
            comment: "Skambineja Petras pastoviai",
            dateTime: DateTime.now()),
        itemCount: commentNum,
      ),
    );
  }
}

// Phone number card class
class PhoneCard extends StatelessWidget {
  const PhoneCard({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          const ListTile(
            leading: Icon(
              Icons.phone,
              size: 40,
            ), //Icon goes here
            title: Text(
              "+37065538698",
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
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.refresh_outlined,
                    size: 24,
                  ),
                  label: const Text("Refresh")),
            ],
          ),
        ],
      ),
    );
  }
}

class _CallInfoState extends State<CallInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who Called Me?"),
      ),
      body: Column(
        children: const <Widget>[
          PhoneCard(number: "+37065538698"),
          _CommentBox(commentNum: 40),
          _TextInput(),
        ],
      ),
    );
  }
}
