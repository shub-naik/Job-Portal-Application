import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'CandidateJobDetail.dart';

class CandidateSearchBar extends StatefulWidget {
  @override
  _CandidateSearchBarState createState() => _CandidateSearchBarState();
}

class _CandidateSearchBarState extends State<CandidateSearchBar> {
  List<Map<String, dynamic>> returnJobList = [];
  List<Map<String, dynamic>> suggesterList = [];
  Future<List<Map<String, dynamic>>> suggestionList;

  //TextEditingController SearchController= TextEditingController();
  final SearchController = TextEditingController();

  Future<List<Map<String, dynamic>>> getJobList() async {
    var data =
        await post('http://freetechtip.in/app/file/candidate_show_jobs_list.php');

    var jsonData = jsonDecode(data.body);
    jsonData.forEach((element) {
      returnJobList.add(element);
    });
    return returnJobList;
  }

  @override
  void initState() {
    getJobList().then((value) => () {
          setState(() {
            suggesterList = value;
          });
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text("Search"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: SearchController,
                decoration: InputDecoration(
                    hintText: 'Enter The Title or Description',
                    contentPadding: EdgeInsets.all(10)),
                onChanged: (string) {
                  setState(() {
                    suggesterList = returnJobList
                        .where((element) =>
                            element['job-title'].toString().contains(string) ||
                            element['description'].toString().contains(string))
                        .toList();
                    print(suggesterList.length);
                  });
                },
              ),
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
                                backgroundImage:
                                    AssetImage('assets/part_time.png'))
                            : CircleAvatar(
                                backgroundColor: Colors.orangeAccent,
                                backgroundImage:
                                    AssetImage('assets/full_time.png')),
                        title: Text(
                          suggesterList[index]['job-title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          suggesterList[index]['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    }))
          ],
        ));
  }
}
