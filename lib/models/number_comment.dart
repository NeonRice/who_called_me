class NumberComment {
  // This class is used for data scraping
  String? username;
  String? comment;
  DateTime? dateTime;

  NumberComment(this.username, this.dateTime, this.comment);
}

class NumberCommentEntity {
  // This class is used with SQLite database
  final int id;
  final String name;
  final String comment;
  final int timestamp;
  final String number;
  final int isLocal;

  // Constructors
  NumberCommentEntity(
      {this.id = 0,
      required this.name,
      required this.comment,
      required this.timestamp,
      required this.number,
      this.isLocal = 0});

  // Convert NumberComment to Map. This model is used in db
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'comment': comment,
      'timestamp': timestamp,
      'number': number,
      'isLocal': isLocal
    };
  }

  @override
  String toString() {
    return 'NumberComment{id: $id, name: $name, comment: $comment,'
        'timestamp: $timestamp, number: $number, isLocal: $isLocal}';
  }
}
