import 'package:flutter/material.dart';
import 'package:flutter_app/app/item/joblist_item.dart';
import 'package:flutter_app/app/model/job.dart';


class JobsTabNew extends StatefulWidget {
  @override
  _JobsTabNewState createState() => _JobsTabNewState();
}

class _JobsTabNewState extends State<JobsTabNew> {

  List<Job> _jobs = [];

  @override
  void initState() {
    super.initState();
    getJobList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color.fromARGB(255, 242, 242, 245),
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text('Android',
            style: new TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
      body: new ListView.builder(
          itemCount: _jobs.length, itemBuilder: buildJobItem),
    );
  }

 Widget buildJobItem(BuildContext context, int index) {
    if(_jobs.length==0)return null;
    Job job = _jobs[index];
    var jobItem = new InkWell(
        onTap: () {
          showDialog(context: context, child: new AlertDialog(
              content: new Text(
                "尽情期待!",
                style: new TextStyle(fontSize: 20.0),
              )));
        },
        child: new JobListItem(job)
    );

    return jobItem;
  }

  void getJobList() {
    setState(() {
      _jobs = Job.fromJson("""
          {
            "list": [
              {
                "name": "架构师（Android）",
                "cname": "蚂蚁金服",
                "size": "B轮",
                "salary": "25k-45k",
                "username": "Claire",
                "title": "HR"
              },
              {
                "name": "资深Android架构师",
                "cname": "今日头条",
                "size": "D轮",
                "salary": "40k-60k",
                "username": "Kimi",
                "title": "HRBP"
              }
            ]
          }
      """);
    });
  }
}
