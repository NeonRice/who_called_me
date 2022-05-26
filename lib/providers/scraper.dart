library scraper;

import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:html/dom.dart';

import '../models/number_comment.dart';
import '../models/number_info.dart';

String cleanupNumber(String number) {
  return number.replaceAll(" ", "").replaceAll("+", "");
}

Future<NumberInfo> getPhoneNumberInfo(String number) async {
  number = cleanupNumber(number);
  final website =
      Uri(scheme: "https", host: "telnumeriai.lt", path: "$number/");

  var client = Client();
  Response response = await client.get(website);

  var document = parse(response.body);
  final searchedCnt = document
      .querySelector(
          "body > div.container > div.row > div.col-md-8 > table > tbody > tr:nth-child(1) > td")
      ?.text
      .replaceAll(RegExp(r'[^0-9]'), '');
  List<Element> comments = document.querySelectorAll(".listing > .card");

  var numberComments = comments.map((comment) {
    final commentHeader = comment.querySelector("small")?.text;
    final headerTokens = commentHeader?.split(" ");

    final username = headerTokens?[0];
    final date = headerTokens?[4];
    final commentContent = comment.querySelector(".row > div.col-md-10")?.text;

    return NumberComment(
        username, DateTime.tryParse(date ?? ""), commentContent?.trim());
  }).toList();

  return NumberInfo(int.parse(searchedCnt ?? '0'), numberComments);
}
