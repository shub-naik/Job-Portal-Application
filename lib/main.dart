import 'package:flutter/material.dart';
import 'EmployerProfileSection.dart';
import 'CandidateFilterJobs.dart';
import 'CandidateLogin.dart';
import 'CandidateSection.dart';
import 'CandidateSignupPage.dart';
import 'Candidate_Zone.dart';
import 'EmployerLogin.dart';
import 'EmployerZone.dart';
import 'ChangePassword.dart';
import 'SelectRole.dart';
import 'SplashScreen.dart';
import 'EmployerSection.dart';
import 'CandidateSearchBar.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => SplashScreen(),
        '/select_role': (context) => SelectRole(),
        '/employer_section': (context) => EmployerSection(),
        '/employer_profile_section': (context) => EmployerProfileSection(),
        '/EmployerLogin': (context) => EmployerLogin(),
        '/EmployerZone': (context) => Employer_Zone(),

        // Candidate Routes
        '/candidate_section': (context) => CandidateSection(),
        '/CandidateSignUpSection': (context) => CandidateSignUpSection(),
        '/CandidateZone': (context) => Candidate_Zone(),
        '/CandidateLogin': (context) => CandidateLogin(),
        '/ChangePassword': (context) => ChangePassword(),
        '/CandidateSearchBar': (context) => CandidateSearchBar(),
        '/CandidateFilterJobs': (context) => CandidateFilterJobs(),
      },
    ));
