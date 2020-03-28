import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CandidateJobDetail extends StatefulWidget {
  Map<String, dynamic> JobDetail;

  CandidateJobDetail({this.JobDetail});

  @override
  _CandidateJobDetailState createState() => _CandidateJobDetailState();
}

class _CandidateJobDetailState extends State<CandidateJobDetail> {
  Widget returnDivider() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Divider(
        color: Colors.red,
      ),
    );
  }

  Widget returnListTiles(String key, String value) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              key,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  Widget returnSizedBox() {
    return SizedBox(
      width: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('${widget.JobDetail['job-title']} Job'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Job Details for ${widget.JobDetail['job-title']}',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          returnListTiles('Job Title : ', widget.JobDetail['job-title']),
          returnDivider(),
          returnListTiles(
              'Job Description : ', widget.JobDetail['description']),
          returnDivider(),
          returnListTiles('Company Name : ', widget.JobDetail['companyName']),
          returnDivider(),
          returnListTiles('Category : ', widget.JobDetail['Category']),
          returnDivider(),
          returnListTiles('Sub-Category : ', widget.JobDetail['Sub-category']),
          returnDivider(),
          returnListTiles('Field : ', widget.JobDetail['Field']),
          returnDivider(),
          returnListTiles(
              'Qualification : ', widget.JobDetail['Qualification']),
          returnDivider(),
          returnListTiles('Designation : ', widget.JobDetail['designation']),
          returnDivider(),
          returnListTiles(
              'Offered-Salary : ', widget.JobDetail['Offered-Salary']),
          returnDivider(),
          returnListTiles('Post-Date : ', widget.JobDetail['Post-date']),
          returnDivider(),
          returnListTiles('Deadline : ', widget.JobDetail['Deadline']),
          returnDivider(),
          returnListTiles('Job Status : ', widget.JobDetail['status']),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: RaisedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text("Applying, Please Wait ....."),
                        content: SpinKitRotatingCircle(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      ),
                    );
                    final prefrences = await SharedPreferences.getInstance();
                    Response response = await post(
                        "http://freetechtip.in/app/file/candidate_application_for_job.php",
                        body: {
                          'userid': prefrences.getString('UserId'),
                          'contact':
                              prefrences.getString('CandidatePhoneNumber'),
                          'emp_id': widget.JobDetail['emp_id'],
                          'jobid': widget.JobDetail['id'],
                          'first_name': prefrences.getString('FirstName'),
                          'last_name': prefrences.getString('LastName'),
                          'companyName': widget.JobDetail['companyName'],
                          'jobTitle': widget.JobDetail['job-title'],
                          'Country': 'India',
                          'State': widget.JobDetail['state'],
                          'City': widget.JobDetail['city'],
                        });
                    Fluttertoast.showToast(
                        msg: "Applied SuucessFully",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pop(context);
                  },
                  highlightColor: Colors.pinkAccent,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40),
                    side: new BorderSide(color: Colors.red),
                  ),
                  child: Text('Apply')),
            ),
          )
        ],
      ),
    );
  }
}
