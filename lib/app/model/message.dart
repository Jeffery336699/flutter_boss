import 'dart:convert';

import 'package:meta/meta.dart';

class Message {
  final String name;
  final String avatar;
  final String company;
  final String position;
  final String msg;

  Message({
    @required this.name,
    @required this.avatar,
    @required this.company,
    @required this.position,
    @required this.msg,
  });

  static List<Message> fromJson(String json) {
    JsonDecoder decoder = JsonDecoder();
    ///一定得强制转化为 as List,否则会一直报错,血的教训
    return ((decoder
        .convert(json)['list']) as List)
        .map((obj) => Message.fromMap(obj))
        .toList();
  }

  static Message fromMap(Map map) {
    return new Message(
        name: map['name'],
        avatar: map['avatar'],
        company: map['company'],
        position: map['position'],
        msg: map['msg']);
  }
}
