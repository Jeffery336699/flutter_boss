import 'dart:convert';

import 'package:meta/meta.dart';

class Job {
  final String name;
  final String cname;
  final String size;
  final String salary;
  final String username;
  final String title;

  Job(
      {@required this.name,
      @required this.cname,
      @required this.size,
      @required this.salary,
      @required this.username,
      @required this.title});

  static List<Job> fromJson(String json) {
    JsonDecoder decoder = JsonDecoder();
    var  convert = decoder.convert(json)['list'] as List;

    List<Job> list= convert.map((map){
      return Job.fromMap(map);
    }).toList();

    return list;
  }

  static Job fromMap(Map<String, dynamic> map) {
    return new Job(
        name: map['name'],
        cname: map['cname'],
        size: map['size'],
        salary: map['salary'],
        username: map['username'],
        title: map['title']);
  }
}
