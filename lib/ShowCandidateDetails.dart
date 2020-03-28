import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowCandidateDetails extends StatefulWidget {
  Map<String, dynamic> CandidateDetail;

  ShowCandidateDetails({this.CandidateDetail});

  @override
  _ShowCandidateDetailsState createState() => _ShowCandidateDetailsState();
}

class _ShowCandidateDetailsState extends State<ShowCandidateDetails> {
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
        title: Text('${widget.CandidateDetail["username"]}\'s Profile'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Profile Details for ${widget.CandidateDetail["username"]}',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          returnListTiles('Mobile : ', widget.CandidateDetail['mobile']),
          returnDivider(),
          returnListTiles('Email : ', widget.CandidateDetail['email']),
          returnDivider(),
          returnListTiles('Username : ', widget.CandidateDetail['username']),
          returnDivider(),
          returnListTiles('First Name : ', widget.CandidateDetail['firstName']),
          returnDivider(),
          returnListTiles('Last Name : ', widget.CandidateDetail['lastName']),
          returnDivider(),
          returnListTiles('DOB : ', widget.CandidateDetail['dob']),
          returnDivider(),
          returnListTiles('Category : ', widget.CandidateDetail['categories']),
          returnDivider(),
          returnListTiles(
              'Sub-Category : ', widget.CandidateDetail['subcategory']),
          returnDivider(),
          returnListTiles(
              'Qualification : ', widget.CandidateDetail['qualification']),
          returnDivider(),
          returnListTiles(
              'Social Category : ', widget.CandidateDetail['socialCategory']),
          returnDivider(),
          returnListTiles(
              'Experiance : ', widget.CandidateDetail['experiance']),
        ],
      ),
    );
  }
}
