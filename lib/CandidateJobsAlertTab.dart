import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'CandidateJobDetail.dart';

class CandidateJobsAlertTab extends StatefulWidget {
  const CandidateJobsAlertTab({Key key}) : super(key: key);

  @override
  _CandidateJobsAlertTabState createState() => _CandidateJobsAlertTabState();
}

class _CandidateJobsAlertTabState extends State<CandidateJobsAlertTab> {
  List<Map<String, dynamic>> suggesterList = [];
  List<Map<String, dynamic>> originalList = [];

  static Future<List<Map<String, dynamic>>> getJobAlertList() async {
    List<Map<String, dynamic>> suggestionList = [];
    var data =
        await post('http://freetechtip.in/app/file/candidate_show_jobs_list.php');

    var jsonData = jsonDecode(data.body);
    jsonData.forEach((element) {
      suggestionList.add(element);
    });
    return suggestionList;
  }

  @override
  void initState() {
    super.initState();
    _CandidateJobsAlertTabState.getJobAlertList().then((value) => {
          setState(() {
            suggesterList = value;
            originalList = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Upcoming Jobs List',
              style: TextStyle(color: Colors.redAccent, fontSize: 20),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: suggesterList.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => CandidateJobDetail(
                                JobDetail: suggesterList[index])));
                  },
                  leading: suggesterList[index]['Job-type'] == "Part-Time"
                      ? CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          backgroundImage: AssetImage('assets/part_time.png'))
                      : CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          backgroundImage: AssetImage('assets/full_time.png')),
                  title: Text(
                    suggesterList[index]['job-title'].toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    suggesterList[index]['description']
                        .toString()
                        .toLowerCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
