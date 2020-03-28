import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';

class EmployerJobDetail extends StatefulWidget {
  Map<String, dynamic> JobDetail;
  int index;

  EmployerJobDetail({this.JobDetail});

  @override
  _EmployerJobDetailState createState() => _EmployerJobDetailState();
}

class _EmployerJobDetailState extends State<EmployerJobDetail> {
  void ActivateDeactivateJob(String action) async {
    if (action == 'deactivate') {
      var data = await post('http://freetechtip.in/app/file/emp_manage_jobs.php',
          body: {
            'id': widget.JobDetail['id'],
            'inactive': 'inactive',
            'status': 'Inactive'
          });
      Map<dynamic, dynamic> map = jsonDecode(data.body);
      if (map['status'] == 'done') {
        Toast.show("Deactivated Successfully", context,
            backgroundColor: Colors.red,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
        setState(() {
          widget.JobDetail['status'] = 'InActive';
        });
      }
    } else {
      var data = await post('http://freetechtip.in/app/file/emp_manage_jobs.php',
          body: {
            'id': widget.JobDetail['id'],
            'active': 'active',
            'status': 'Active'
          });
      Map<dynamic, dynamic> map = jsonDecode(data.body);
      if (map['status'] == 'done') {
        Toast.show("Activated Successfully", context,
            backgroundColor: Colors.red,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
        setState(() {
          widget.JobDetail['status'] = 'Active';
        });
      }
    }
  }

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
        title: Text('${widget.JobDetail['username']} Manage Jobs'),
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
          returnDivider(),
          Row(
            children: <Widget>[
              returnSizedBox(),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      ActivateDeactivateJob('activate');
                    },
                    child: Text('Activate Job'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      color: Colors.red,
                      onPressed: () {
                        ActivateDeactivateJob('deactivate');
                      },
                      child: Text('De-Activate Job'),
                    )),
              ),
              returnSizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
