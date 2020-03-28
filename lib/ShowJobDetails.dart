import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowJobDetails extends StatefulWidget {
  Map<String, dynamic> JobDetail;

  ShowJobDetails({this.JobDetail});

  @override
  _ShowJobDetailsState createState() => _ShowJobDetailsState();
}

class _ShowJobDetailsState extends State<ShowJobDetails> {
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
        ],
      ),
    );
  }
}
