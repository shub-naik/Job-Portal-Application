import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heera_polish/SelectRole.dart';
import 'package:heera_polish/CandidateJobsAppliedTab.dart';
import 'package:heera_polish/CandidateHomeTab.dart';
import 'package:heera_polish/CandidateProfileTab.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'CandidateJobsAlertTab.dart';

class Candidate_Zone extends StatefulWidget {
  @override
  _Candidate_ZoneState createState() => _Candidate_ZoneState();
}

class _Candidate_ZoneState extends State<Candidate_Zone> {
  //for bottom navigation bar
  int _current_index = 0;
  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  // Home Page Varibales and functions ends here.

  final List<Widget> tabs = [
    CandidateHomeTab(
      key: PageStorageKey('Home'),
    ),
    CandidateJobsAppliedTab(
      key: PageStorageKey('AppliedJobs'),
    ),
    CandidateJobsAlertTab(
      key: PageStorageKey('JobsAlert'),
    ),
    CandidateProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    Future<bool> _onbackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Do you really want to exit ?"),
          actions: <Widget>[
            OutlineButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No")),
            OutlineButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Yes"))
          ],
        ),
      );
    }

    void CandidateMenuItem(String value) async {
      if (value == 'Logout') {
        final prefrences = await SharedPreferences.getInstance();
        await prefrences.clear();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SelectRole()));
      } else if (value == 'Change Password') {
        Navigator.pushNamed(context, '/ChangePassword');
      } else {}
    }

    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Candidate Zone'),
          backgroundColor: Colors.pinkAccent,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/CandidateSearchBar');
                }),
            IconButton(
              icon: Icon(
                Icons.filter_list,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/CandidateFilterJobs');
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                CandidateMenuItem(value);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "Logout",
                  child: Text("Logout"),
                ),
                PopupMenuItem(
                  value: "Change Password",
                  child: Text("Change Password"),
                ),
              ],
            )
          ],
        ),
        body: PageStorage(
          child: tabs[_current_index],
          bucket: pageStorageBucket,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _current_index,
            iconSize: 20,
            onTap: (index) {
              setState(() {
                _current_index = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  backgroundColor: Colors.red),
              // In Home Section,Show All the Jobs in ListView and On tap List The Details of the Particular Job

              BottomNavigationBarItem(
                  icon: Icon(Icons.verified_user), title: Text('JobApplied')),

              BottomNavigationBarItem(
                  icon: Icon(Icons.alarm), title: Text('Jobs Alert')),

              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile')),
            ]),
      ),
    );
  }
}
