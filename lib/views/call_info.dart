import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../components/phone_card.dart';
import '../models/number_comment.dart';
import '../providers/database.dart';
import '../providers/scraper.dart';

class CallInfo extends StatefulWidget {
  final String number;
  final CallType callType;

  final Map<CallType, IconData> callTypeIcons = const {
    CallType.missed: Icons.call_missed,
    CallType.incoming: Icons.call_received,
    CallType.rejected: Icons.call_end,
  };

  const CallInfo(
      {Key? key, required this.number, this.callType = CallType.unknown})
      : super(key: key);

  @override
  _CallInfoState createState() => _CallInfoState();
}

class _CommentTextInput extends StatefulWidget {
  const _CommentTextInput({Key? key, this.onSend}) : super(key: key);

  final void Function(String)? onSend;

  @override
  State<_CommentTextInput> createState() => _CommentTextInputState();
}

class _CommentTextInputState extends State<_CommentTextInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                controller: _controller,
              ),
            ),
            IconButton(
              onPressed: () {
                if (widget.onSend != null) {
                  widget.onSend!(_controller.value.text);
                  _controller.text = "";
                }
              },
              icon: const Icon(Icons.send),
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
        trailing: Text(dateTime.toString(),
            style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic)));
  }
}

class _CommentBox extends StatelessWidget {
  final List<NumberCommentEntity> comments;

  const _CommentBox({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) => _SingleComment(
          username: comments[index].name,
          comment: comments[index].comment,
          dateTime: DateTime.fromMillisecondsSinceEpoch(
              comments[index].timestamp * 1000),
        ),
        itemCount: comments.length,
      ),
    );
  }
}

class _CallInfoState extends State<CallInfo> {
  late Future<List<NumberCommentEntity>> comments;

  @override
  void initState() {
    super.initState();
    comments = getNumberComments(widget.number);
  }

  Future<List<NumberCommentEntity>> getNumberComments(String number) async {
    number = cleanupNumber(number);
    var numberComments = await NumberDatabase().comments(number: number);
    if (numberComments.isEmpty) {
      var numberInfo = await getPhoneNumberInfo(number);
      for (final comment in numberInfo.comments) {
        // Who cares about non existing comments..
        if (comment.comment == null) {
          continue;
        }
        var commentEntity = NumberCommentEntity(
            name: comment.username ?? "Anonymous",
            comment: comment.comment!,
            timestamp: (comment.dateTime?.toLocal().millisecondsSinceEpoch ??
                    DateTime.now().millisecondsSinceEpoch) ~/
                Duration.millisecondsPerSecond,
            number: number);
        numberComments.add(commentEntity);
        await NumberDatabase().insertComment(commentEntity);
      }
    }

    return numberComments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who Called Me?"),
      ),
      body: Column(
        children: <Widget>[
          PhoneCard(
            number: FlutterLibphonenumber().formatNumberSync(widget.number),
            lastUpdate: DateTime.now(),
            icon: widget.callTypeIcons[widget.callType] ?? Icons.call,
            onPressed: (_) {
              NumberDatabase().deleteNumber(widget.number);
              var comments = getNumberComments(widget.number);
              setState(() {
                this.comments = comments;
              });
            },
          ),
          FutureBuilder(
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<NumberCommentEntity> comments =
                    snapshot.data as List<NumberCommentEntity>;

                if (comments.isEmpty) {
                  return const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Nothing found!"),
                    ),
                  );
                }

                return _CommentBox(comments: comments);
              } else if (snapshot.hasError) {
                return const Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Error occured!"),
                  ),
                );
              } else {
                return Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(children: const [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        )
                      ])),
                );
              }
            }),
            future: comments,
          ),
          _CommentTextInput(
            onSend: (text) {
              var comment = NumberCommentEntity(
                  name: "Me",
                  comment: text,
                  timestamp: DateTime.now().millisecondsSinceEpoch ~/
                      Duration.millisecondsPerSecond,
                  number: cleanupNumber(widget.number),
                  isLocal: 1);
              if (text.isEmpty) {
                return;
              }
              NumberDatabase().insertComment(comment);
              setState(() {
                comments = getNumberComments(widget.number);
              });
            },
          ),
        ],
      ),
    );
  }
}
