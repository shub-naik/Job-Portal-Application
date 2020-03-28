import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:heera_polish/EmployerManageJobs.dart';
import 'Employer_zone_company_profile.dart';
import 'Employer_zone_home.dart';
import 'Employer_zone_transactions.dart';
import 'Employer_zone_choose_plan.dart';
import 'Post_job.dart';
import 'SelectRole.dart';

class Employer_Zone extends StatefulWidget {
  @override
  _Employer_ZoneState createState() => _Employer_ZoneState();
}

class _Employer_ZoneState extends State<Employer_Zone>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 300);
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _page = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Employer_zone_home(),
        EmployerManageJobs(),
        Employer_zone_transactions(),
        Employer_zone_choose_plan(),
        Employer_zone_company_profile(),
        Post_job(),
      ],
    );
  }

  bool isCollapsed = true;
  double screenWidth, screenHeight;

  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onbackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Do u really want to exit ?"),
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



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/unnamed.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
            body: Stack(children: <Widget>[
          menu(context),
          dashboard(context),
        ])),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  child: RaisedButton.icon(
                      onPressed: () async {
                        final prefrences = await SharedPreferences.getInstance();
                        await prefrences.clear();
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => SelectRole()));
                      },
                      icon: Icon(Icons.remove_circle_outline),
                      label: Text("Logout")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      duration: duration,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          elevation: 0,
          child: Container(
            child: Stack(
              children: <Widget>[
                new Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.white,
                  appBar: new AppBar(
                    title: new Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Icon(Icons.menu, color: Colors.white),
                          onTap: () {
                            setState(() {
                              if (isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();

                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                        SizedBox(width:30),
                        Text(
                          "Heerapolish",
                          textScaleFactor: 1.4,
                        ),
                      ],
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0.0,
                  ),
//          floatingActionButtonLocation:
//            FloatingActionButtonLocation.endFloat,
//            floatingActionButton: FloatingActionButton.extended(
//              icon : Icon(Icons.add,),
//              backgroundColor: Colors.pinkAccent,
//              onPressed: () {
//                Navigator.pushNamed(context, '/post_job');
//              },
//              label: Text('Post a Job'),
//            ),
                  bottomNavigationBar: CurvedNavigationBar(
                      height: 46,
                      backgroundColor: Colors.transparent,
                      color: Colors.blueAccent,
                      buttonBackgroundColor: Colors.pinkAccent,
                      key: _bottomNavigationKey,
                      items: <Widget>[
                        Icon(Icons.home, color: Colors.white),
                        Icon(Icons.build, color: Colors.white),
                        Icon(Icons.account_balance_wallet, color: Colors.white),
                        Icon(Icons.payment, color: Colors.white),
                        Icon(Icons.perm_identity, color: Colors.white),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ],
                      onTap: (index) {
                        setState(() {
                          bottomTapped(index);
                        });
                      }),
                  body: buildPageView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
