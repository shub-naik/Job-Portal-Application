import 'package:flutter/material.dart';

class CandidateSection extends StatefulWidget {
  @override
  _CandidateSectionState createState() => _CandidateSectionState();
}

class _CandidateSectionState extends State<CandidateSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Candidate Section'),
      backgroundColor: Colors.pinkAccent,
    ));
  }
}
