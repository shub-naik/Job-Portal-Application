import 'dart:convert';
import 'package:mdi/mdi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'EmployerJobDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.publishDate,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String publishDate;

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
                          '$publishDate',
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
      this.snapshot,
      this.index})
      : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String publishDate;
  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  backgroundImage: AssetImage('assets/full_time.png')),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: _ArticleDescription(
                    title: title,
                    subtitle: subtitle,
                    publishDate: publishDate,
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new EmployerJobDetail(
                          JobDetail: this.snapshot.data[index],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployerManageJobs extends StatefulWidget {
  @override
  _EmployerManageJobsState createState() => _EmployerManageJobsState();
}

class _EmployerManageJobsState extends State<EmployerManageJobs> {
  bool Ftrue = false;
  static List<Map<String, dynamic>> returnJobList = [];

  Future<List<Map<String, dynamic>>> getJobList() async {
    returnJobList = [];
    final prefrences = await SharedPreferences.getInstance();
    print('------------Employer Manage Jobs ------------------');
    print(prefrences.getString('emp_name'));
    print('------------Employer Manage Jobs ------------------');
    var data = await post('http://freetechtip.in/app/file/emp_manage_jobs.php',
        body: {'view': 'view', 'username': prefrences.getString('emp_name')});
    var jsonData = jsonDecode(data.body);
    List<dynamic> allJobList = jsonData[0];
    allJobList.forEach((element) {
      returnJobList.add(element);
    });
    print(returnJobList);
    return returnJobList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex:1,
            child: FutureBuilder(
                future: getJobList(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if(snapshot.data.length == 0 ){
                        return Text(
                          "No Data To Manage because You haven't Posted Any Jobs Yet !",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[200],
                          ),
                        );
                      }
                      // Employer Manage Jobs Header Here To Be Inserted Latter
//                Column(
//                  children: <Widget>[
////          Top row with dashboard
//                    Padding(
//                      padding: const EdgeInsets.all(20.0),
//                      child: Container(
//                        padding: EdgeInsets.all(8),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(20),
//                          border: Border.all(
//                            width: 1.3,
//                          ),
//                        ),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Expanded(
//                              flex: 1,
//                              child: Container(
//                                padding: EdgeInsets.all(10),
//                                decoration: BoxDecoration(
//                                  color: Colors.amberAccent,
//                                  borderRadius: BorderRadius.circular(20),
//                                  border: Border.all(
//                                    width: 1.2,
//                                  ),
//                                ),
//                                child: Text("Jobs Posted"),
//                              ),
//                            ),
//                            SizedBox(
//                              width: 10,
//                            ),
//                            Expanded(
//                              flex: 1,
//                              child: Container(
//                                padding: EdgeInsets.all(10),
//                                decoration: BoxDecoration(
//                                  color: Colors.amberAccent,
//                                  borderRadius: BorderRadius.circular(20),
//                                  border: Border.all(
//                                    width: 1.2,
//                                  ),
//                                ),
//                                child: Text("Applications"),
//                              ),
//                            ),
//                            SizedBox(
//                              width: 10,
//                            ),
//                            Expanded(
//                              flex: 1,
//                              child: Container(
//                                padding: EdgeInsets.all(10),
//                                decoration: BoxDecoration(
//                                  color: Colors.amberAccent,
//                                  borderRadius: BorderRadius.circular(20),
//                                  border: Border.all(
//                                    width: 1.2,
//                                  ),
//                                ),
//                                child: Text("Active Jobs"),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return CustomListItemTwo(
                                thumbnail: snapshot.data[index]['Job-type'] ==
                                        "Part-Time"
                                    ? CircleAvatar(
                                        backgroundColor: Colors.orangeAccent,
                                        backgroundImage:
                                            AssetImage('assets/part_time.png'))
                                    : CircleAvatar(
                                        backgroundColor: Colors.orangeAccent,
                                        backgroundImage:
                                            AssetImage('assets/full_time.png')),
                                title: snapshot.data[index]['job-title'],
                                subtitle: snapshot.data[index]['description'],
                                publishDate: snapshot.data[index]['Post-date'],
                                snapshot: snapshot,
                                index: index);
                          });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
