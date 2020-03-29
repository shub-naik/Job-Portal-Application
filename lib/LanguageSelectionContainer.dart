import 'package:JobPortal/LanguageSelcectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_translations_delegate.dart';
import 'application.dart';
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
import 'EmployerSection.dart';
import 'CandidateSearchBar.dart';

class LanguageSelectionContainer extends StatefulWidget {
  @override
  _LanguageSelectionContainerState createState() => _LanguageSelectionContainerState();
}

class _LanguageSelectionContainerState extends State<LanguageSelectionContainer> {

  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
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
      debugShowCheckedModeBanner: false,
      home: LanguageSelcectionScreen(),
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("es", ""),
      ],
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
