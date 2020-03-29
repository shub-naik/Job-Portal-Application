import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mdi/mdi.dart';
import 'CandidateJobDetail.dart';

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription(
      {Key key, this.title, this.subtitle, this.publishDate, this.deadlineDate})
      : super(key: key);

  final String title;
  final String subtitle;
  final String publishDate;
  final String deadlineDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        Text(
                          '$publishDate',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Icon(Mdi.timelineAlert),
                        Text(
                          '$deadlineDate',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo(
      {Key key,
      this.thumbnail,
      this.title,
      this.subtitle,
      this.publishDate,
      this.deadlineDate,
      this.snapshot,
      this.index})
      : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String publishDate;
  final String deadlineDate;
  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 120,
        child: Card(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    backgroundImage:
                        snapshot.data[index]['Job-type'] == 'Full-Time'
                            ? AssetImage('assets/full_time.png')
                            : AssetImage('assets/part_time.png')),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: _ArticleDescription(
                      title: title,
                      subtitle: subtitle,
                      publishDate: publishDate,
                      deadlineDate: deadlineDate,
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => CandidateJobDetail(
                              JobDetail: this.snapshot.data[index]),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  class CandidateHomeTab extends StatefulWidget {
  const CandidateHomeTab({Key key}) : super(key: key);

  @override
  _CandidateHomeTabState createState() => _CandidateHomeTabState();
}

class _CandidateHomeTabState extends State<CandidateHomeTab> {
  // For Listing all the jobs on the home page
  Future<List<Map<String, dynamic>>> getJobList() async {
    var data =
        await post('http://freetechtip.in/app/file/candidate_show_jobs_list.php');

    List<Map<String, dynamic>> returnJobList = [];

    var jsonData = jsonDecode(data.body);

    jsonData.forEach((element) {
      returnJobList.add(element);
    });
    return returnJobList;
  }

  Future<List<Map<String, dynamic>>> allJobsList;

  @override
  void initState() {
    allJobsList = getJobList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: allJobsList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return CustomListItemTwo(
                        key: PageStorageKey(snapshot.data[index]['job-title']),
                        thumbnail: CircleAvatar(
                            backgroundColor: Colors.orangeAccent,
                            backgroundImage:
                                AssetImage('assets/full_time.png')),
                        title: snapshot.data[index]['job-title'],
                        subtitle: snapshot.data[index]['description'],
                        publishDate: snapshot.data[index]['Post-date'],
                        deadlineDate: snapshot.data[index]['Deadline'],
                        snapshot: snapshot,
                        index: index);
                  });
          }
        });
  }
}
