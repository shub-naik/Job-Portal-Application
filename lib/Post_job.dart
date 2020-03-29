import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'EmployerManageJobs.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class Post_job extends StatefulWidget {
  @override
  _Post_jobState createState() => _Post_jobState();
}

class _Post_jobState extends State<Post_job> {
  int _page = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

// Date Picker
  DateTime _dod;

  // Ends Here
  // Category, SubCategory , Fields By Shubham
  String mainService, subMainService, field;
  bool boolSubCategory = true;
  List<DropdownMenuItem<String>> SubCategoryList = List();
  List<Map<String, String>> FieldList = List();
  String FieldListValuess = '';

  final MakableSubCategory = {
    'POLISHING': 'POLISHING',
    'BRUTING': 'BRUTING',
    'ASORTING': 'ASORTING',
    'PLANE/MARKING': 'PLANE/MARKING',
    'LASER-4P': 'LASER-4P',
    'CLEVING/MARKER': 'CLEVING/MARKER',
  };
  final FadchiSubCategory = {
    'POLISHING': 'POLISHING',
    'BRUTING': 'BRUTING',
    'ASORTING': 'ASORTING',
    'PLANE/MARKING': 'PLANE/MARKING',
    'LASER-4P': 'LASER-4P',
    'CLEVING/MARKER': 'CLEVING/MARKER',
    'SOWING': 'SOWING',
  };
  final BothSubCategory = {
    'POLISHING': 'POLISHING',
    'BRUTING': 'BRUTING',
    'ASORTING': 'ASORTING',
    'PLANE/MARKING': 'PLANE/MARKING',
    'LASER-4P': 'LASER-4P',
    'CLEVING/MARKER': 'CLEVING/MARKER',
  };

  final MakablePolishing = {
    'TABLE': 'TABLE',
    'BOTTOM/TALIYA': 'BOTTOM/TALIYA',
    'TOP-8 PALE': 'TOP-8 PALE',
    'TOP-MATHAL': 'TOP-MATHAL',
    'FULL TOP': 'FULL TOP',
    'BLOCKING': 'BLOCKING',
    'FIXING': 'FIXING',
    'GIRDLE/DHAR-POLISH': 'GIRDLE/DHAR-POLISH',
    'RART AND ARROW/AAA': 'RART AND ARROW/AAA',
  };
  final MakableBruting = {
    'RUSSIAN': 'RUSSIAN',
    'DOUBLE SPINDALE': 'DOUBLE SPINDALE',
    'DESHI GHAT/DANDA GHAT': 'DESHI GHAT/DANDA GHAT',
  };
  final MakableAsorting = {
    'ROUGH ASSORT': 'ROUGH ASSORT',
    'ABC-ASORT': 'ABC-ASORT',
    'OFFICE WORK': 'OFFICE WORK',
  };
  final MakablePlane = {
    'LASER MARKING(LM)': 'LASER MARKING(LM)',
    'PAN MARKING': 'PAN MARKING',
  };
  final MakableLaser = {
    '4P-STIKING': '4P-STIKING',
  };
  final MakableCleving = {
    'MARKER': 'MARKER',
    'STICKING': 'STICKING',
    'ABC-SORTING': 'ABC-SORTING',
  };

  final FadchiPolishing = {
    'TS/TABLE ': 'TS/TABLE ',
    'BOTTOM/TALIYA': 'BOTTOM/TALIYA',
    'TOP-8 PALE': 'TOP-8 PALE',
    'HALF TOP-MATHAL': 'HALF TOP-MATHAL',
    'FULL TOP': 'FULL TOP',
    'BLOCKING': 'BLOCKING',
    'FIXING': 'FIXING',
    'RART AND ARROW/AAA': 'RART AND ARROW/AAA',
  };
  final FadchiBruting = {
    'RUSSIAN': 'RUSSIAN',
    'DOUBLE SPINDALE': 'DOUBLE SPINDALE',
  };
  final FadchiAsorting = {
    'ROUGH ASSORT': 'ROUGH ASSORT',
    'POLISH ASSORTING': 'POLISH ASSORTING',
  };
  final FadchiPlane = {
    'LASER MARKING(LM)': 'LASER MARKING(LM)',
    'PAN MARKING': 'PAN MARKING',
  };
  final FadchiLaser = {
    '4P-STIKING': '4P-STIKING',
    'ABC-ASORT': 'ABC-ASORT',
  };
  final FadchiCleving = {
    'MARKER': 'MARKER',
    'BLADE SAWING': 'BLADE SAWING',
    'ABC-SORTING': 'ABC-SORTING',
  };
  final FadchiSowing = {
    'MARKING': 'MARKING',
    'BLADE SAWING': 'BLADE SAWING',
    'LASER SOWING': 'LASER SOWING',
  };
  final BothPolishing = {
    'TABLE/TS': 'TABLE/TS',
    'BOTTOM/TALIYA': 'BOTTOM/TALIYA',
    'TOP-8 PALE': 'TOP-8 PALE',
    'TOP-MATHAL': 'TOP-MATHAL',
    'HALF TOP': 'HALF TOP',
    'FULL TOP': 'FULL TOP',
    'BLOCKING': 'BLOCKING',
    'FIXING': 'FIXING',
    'GIRDLE/DHAR-POLISH': 'GIRDLE/DHAR-POLISH',
    'RART AND ARROW/AAA': 'RART AND ARROW/AAA',
  };

  final BothBruting = {
    'RUSSIAN': 'RUSSIAN',
    'DOUBLE SPINDALE': 'DOUBLE SPINDALE',
    'DESHI GHAT/DANDA GHAT': 'DESHI GHAT/DANDA GHAT',
  };

  final BothAsorting = {
    'ROUGH ASSORT': 'ROUGH ASSORT',
    'ABC-ASORT': 'ABC-ASORT',
    'OFFICE WORK': 'OFFICE WORK',
  };
  final BothPlane = {
    'LASER MARKING(LM)': 'LASER MARKING(LM)',
    'PAN MARKING': 'PAN MARKING',
  };
  final BothLaser = {
    '4P-STIKING': '4P-STIKING',
    'ABC-ASORT': 'ABC-ASORT',
  };
  final BothCleving = {
    'MARKER': 'MARKER',
    'BLADE SAWING': 'BLADE SAWING',
    'ABC-SORTING': 'ABC-SORTING',
  };

  void populateMakableSubCategory() {
    SubCategoryList.clear();
    for (String key in MakableSubCategory.keys) {
      SubCategoryList.add(DropdownMenuItem(
          value: MakableSubCategory[key],
          child: Text(
            MakableSubCategory[key],
          )));
    }
    subMainService = MakableSubCategory[0];
  }

  void populateFadchiSubCategory() {
    SubCategoryList.clear();
    for (String key in FadchiSubCategory.keys) {
      SubCategoryList.add(DropdownMenuItem(
          value: FadchiSubCategory[key],
          child: Text(
            FadchiSubCategory[key],
          )));
    }
    subMainService = FadchiSubCategory[0];
  }

  void populateBothSubCategory() {
    SubCategoryList.clear();
    for (String key in BothSubCategory.keys) {
      SubCategoryList.add(DropdownMenuItem(
          value: BothSubCategory[key],
          child: Text(
            BothSubCategory[key],
          )));
    }
    subMainService = BothSubCategory[0];
  }

  void populateMakablePolishing() {
    FieldList.clear();
    for (String key in MakablePolishing.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateMakableBruting() {
    FieldList.clear();
    for (String key in MakableBruting.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateMakableAsorting() {
    FieldList.clear();
    for (String key in MakableAsorting.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateMakablePlane() {
    FieldList.clear();
    for (String key in MakablePlane.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateMakableLaser() {
    FieldList.clear();
    for (String key in MakableLaser.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateMakableMarker() {
    FieldList.clear();
    for (String key in MakableCleving.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateFadchiPolishing() {
    FieldList.clear();
    for (String key in MakableCleving.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateFadchiBruting() {
    FieldList.clear();
    for (String key in FadchiBruting.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateFadchiAsorting() {
    FieldList.clear();
    for (String key in FadchiAsorting.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateFadchiPlane() {
    FieldList.clear();
    for (String key in FadchiPlane.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateFadchiLaser() {
    FieldList.clear();
    for (String key in FadchiLaser.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateFadchiMarker() {
    FieldList.clear();
    for (String key in FadchiCleving.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateFadchiSowing() {
    FieldList.clear();
    for (String key in FadchiSowing.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateBothPolishing() {
    FieldList.clear();
    for (String key in BothPolishing.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateBothBruting() {
    FieldList.clear();
    for (String key in BothBruting.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateBothAsorting() {
    FieldList.clear();
    for (String key in BothAsorting.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateBothPlane() {
    FieldList.clear();
    for (String key in BothPlane.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateBothLaser() {
    FieldList.clear();
    for (String key in BothLaser.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void populateBothMarker() {
    FieldList.clear();
    for (String key in BothCleving.keys) {
      var map = {'display': key, 'value': key};
      FieldList.add(map);
    }
  }

  void secondValueChanged(String _value) {
    if (mainService == "MAKABLE" && _value == "POLISHING") {
      populateMakablePolishing();
    } else if (mainService == "MAKABLE" && _value == "BRUTING") {
      populateMakableBruting();
    } else if (mainService == "MAKABLE" && _value == "ASORTING") {
      populateMakableAsorting();
    } else if (mainService == "MAKABLE" && _value == "PLANE/MARKING") {
      populateMakablePlane();
    } else if (mainService == "MAKABLE" && _value == "LASER-4P") {
      populateMakableLaser();
    } else if (mainService == "MAKABLE" && _value == "CLEVING/MARKER") {
      populateMakableMarker();
    } else if (mainService == "FADCHI" && _value == "POLISHING") {
      populateFadchiPolishing();
    } else if (mainService == "FADCHI" && _value == "BRUTING") {
      populateFadchiBruting();
    } else if (mainService == "FADCHI" && _value == "ASORTING") {
      populateFadchiAsorting();
    } else if (mainService == "FADCHI" && _value == "PLANE/MARKING") {
      populateFadchiPlane();
    } else if (mainService == "FADCHI" && _value == "LASER-4P") {
      populateFadchiLaser();
    } else if (mainService == "FADCHI" && _value == "CLEVING/MARKER") {
      populateFadchiMarker();
    } else if (mainService == "FADCHI" && _value == "SOWING") {
      populateFadchiSowing();
    } else if (mainService == "BOTH" && _value == "POLISHING") {
      populateBothPolishing();
    } else if (mainService == "BOTH" && _value == "BRUTING") {
      populateBothBruting();
    } else if (mainService == "BOTH" && _value == "ASORTING") {
      populateBothAsorting();
    } else if (mainService == "BOTH" && _value == "PLANE/MARKING") {
      populateBothPlane();
    } else if (mainService == "BOTH" && _value == "LASER-4P") {
      populateBothLaser();
    } else if (mainService == "BOTH" && _value == "CLEVING/MARKER") {
      populateBothMarker();
    } else {}
    setState(() {
      this.subMainService = _value;
    });
  }

  void valueChanged(String newValue) {
    if (newValue == 'MAKABLE') {
      populateMakableSubCategory();
    }
    if (newValue == 'FADCHI') {
      populateFadchiSubCategory();
    }
    if (newValue == 'BOTH') {
      populateBothSubCategory();
    }

    setState(() {
      boolSubCategory = false;
      this.mainService = newValue;
    });
  }

  // Ends Here

  void pageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        EmployerManageJobs(),
      ],
    );
  }

  void bottomTapped(int index) {
    setState(() {
      _page = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  Country _selectedCountry;

//  date picker starts here
  DateTime _currentdate = new DateTime.now();

  Future<Null> _selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentdate,
        firstDate: DateTime(1990),
        lastDate: DateTime(3000),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != Null) {
      setState(() {
        _currentdate = _seldate;
      });
    }
  }

//  date picker ends here
  String value = " ",
      catvalue = " ",
      deadline_date = " ",
      c_name = " ",
      c_phone = " ",
      c_designation = " ";
  int offered_sal = 0, experience = 0;
  bool disabledropdown = true, _validate = false;
  String Job_title, Email, c_email;
  final _descriptText = TextEditingController();
  String current_job_type_selected = 'Part-Time';
  var job_type = ['Part-Time', 'Full-Time'];

  var gender = ['Male', 'Female', 'Other'];
  String current_gender_type_selected = 'Female';
  var qualification = [
    'Below 10th Grade',
    '10th Grade',
    '12th Grade',
    'Graduate'
  ];
  String current_qualification_selected = "Graduate";
  List<DropdownMenuItem<String>> menuitems = List();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget JobTitle() {
    return ListTile(
      leading: Icon(Icons.add),
      title: TextFormField(
          maxLength: 10,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Job_Title"),
          validator: (String value) {
            if (value.isEmpty) {
              return 'A Job Title is Required';
            }
            return null;
          },
          onSaved: (String value) {
            Job_title = value;
          }),
    );
  }

  Widget CompanyEmail() {
    return ListTile(
      leading: Icon(Icons.email),
      title: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
              hintText: "Company Email"),
          keyboardType: TextInputType.emailAddress,
          validator: (String value) {
            if (!RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(value)) {
              return 'Valid And Correct Company Email is Required';
            }
            return null;
          },
          onSaved: (String value) {
            Email = value;
          }),
    );
  }

  Widget OfferedSalary() {
    return ListTile(
      leading: Icon(Icons.monetization_on),
      title: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Salary Offered",
              hintText: "Offered Salary"),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Enter some salary amount';
            }
            return null;
          },
          onSaved: (String value) {
            offered_sal = int.parse(value);
          }),
    );
  }

  Widget ContactPersonDetails() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Contact Person Details",
            style: TextStyle(
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold,
                fontSize: 23),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: TextFormField(
                maxLength: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Name"),
                validator: (String value) {
                  if (value.isEmpty) {
                    return ''
                        'Name is Required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  c_name = value;
                }),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Company Email",
                    hintText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)) {
                    return 'Valid And Correct Email is Required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  c_email = value;
                }),
          ),
          ListTile(
              leading: Icon(Icons.phone),
              title: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Phone"),
                  keyboardType: TextInputType.phone,
                  validator: (String value) {
                    if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value)) {
                      return 'Correct 10 digit Phone Number is Required';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    c_phone = value;
                  })),
          ListTile(
            leading: Icon(Icons.eject),
            title: TextFormField(
                maxLength: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Desgination"),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Designation is Required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  c_designation = value;
                }),
          ),
        ],
      ),
    );
  }

  Widget Experience() {
    return ListTile(
      leading: Icon(Icons.hourglass_empty),
      title: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Experience "),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Enter an Experience';
            }
            return null;
          },
          onSaved: (String value) {
            experience = int.parse(value);
          }),
    );
  }

  // Country and City Starts Here.
  List<String> citiesList = [];
  List<String> cityListDisplay = [];
  static List<String> indianStateList = [
    'Andhra Pradesh',
    'Assam',
    'Arunachal Pradesh',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Odisha',
    'Nagaland',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttarakhand',
    'Uttar Pradesh',
    'West Bengal'
  ];
  static String stateSelected = indianStateList[0];
  String citySelected='';

  bool _disabled_city = true;

  void stateValueChanged(String value) async {
    citiesList.clear();
    String citiesUrl =
        'https://indian-cities-api-nocbegfhqg.now.sh/cities?State=';
    citiesUrl = citiesUrl + value;
    Response response = await get(citiesUrl);
    List<dynamic> cityList = jsonDecode(response.body);
    cityList.forEach((element) {
      Map<String, dynamic> i = element;
      if (!citiesList.contains(i['City'])) {
        citiesList.add(i['City']);
      }
    });
    setState(() {
      _disabled_city = false;
      citySelected = citiesList[0];
      stateSelected = value;
    });
  }

  // Ends Here

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 1.0;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Container(
              width: c_width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(.0),
                child: Form(
                    key: globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Job Details",
                          style: TextStyle(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        SizedBox(height: 12),
                        JobTitle(),
                        SizedBox(
                          height: 6,
                        ),
                        ListTile(
                          leading: Icon(Icons.details),
                          title: TextField(
                            controller: _descriptText,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Job Description",
                              hintText: 'Job Description',
                              errorText:
                                  _validate ? 'Value Can\'t Be Empty' : null,
                            ),
                            maxLines: null,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        CompanyEmail(),
                        SizedBox(
                          height: 6,
                        ),
                        // JOB TYPE SELECTION DROPDOWN
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: DropdownButton<String>(
                            items: job_type.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem));
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this.current_job_type_selected =
                                    newValueSelected;
                              });
                            },
                            hint: Text("Select a Job Type"),
                            value: current_job_type_selected,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        ListTile(
                          leading: Icon(Icons.add_box),
                          title: DropdownButton<String>(
                            items: ['MAKABLE', 'FADCHI', 'BOTH']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text('Select Services'),
                            onChanged: (_value) => valueChanged(_value),
                            value: mainService,
                          ),
                        ),
                        SizedBox(height: 6),
                        ListTile(
                          leading: Icon(Icons.add_box),
                          title: DropdownButton<String>(
                            items: SubCategoryList,
                            onChanged: boolSubCategory
                                ? null
                                : (_value) => secondValueChanged(_value),
                            hint: Text('Select Services'),
                            disabledHint: Text('Please Select Services First'),
                            value: boolSubCategory ? null : subMainService,
                          ),
                        ),
                        SizedBox(height: 6),
                        ListTile(
                          leading: Icon(Icons.add_box),
                          title: MultiSelect(
                            autovalidate: true,
                            titleText: 'Fields Type',
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select Category and SubCategory First';
                              }
                            },
                            errorText:
                                'Please Select Category and SubCategory First',
                            dataSource: FieldList,
                            textField: 'display',
                            valueField: 'value',
                            filterable: true,
                            required: true,
                            value: null,
                            change: (values) {
                              values.forEach((element) {
                                FieldListValuess =
                                    FieldListValuess + element + ',';
                              });
                            },
                          ),
                        ),
                        OfferedSalary(),
                        Experience(),
                        ListTile(
                          leading: Icon(Icons.perm_identity),
                          title: DropdownButton<String>(
                            items: gender.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem));
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this.current_gender_type_selected =
                                    newValueSelected;
                              });
                            },
                            hint: Text("Select a Job Type"),
                            value: current_gender_type_selected,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.school),
                          title: DropdownButton<String>(
                            items:
                                qualification.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem));
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this.current_qualification_selected =
                                    newValueSelected;
                              });
                            },
                            hint: Text("Select a Job Type"),
                            value: current_qualification_selected,
                          ),
                        ),
                        //                                Date PICKER
                        Column(
                          children: <Widget>[
                            SizedBox(height: 5),
//                                    Text("Application Deadline Date",textScaleFactor: 1.5,),
                            ListTile(
                              leading: Icon(Icons.calendar_today),
                              title: RaisedButton(
                                  color: Colors.pinkAccent,
                                  child: _dod == null
                                      ? Text('Add A Deadline',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15))
                                      : Text(
                                          "Deadline : " +
                                              _dod
                                                  .toIso8601String()
                                                  .split('T')[0],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23),
                                        ),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate:
                                          _dod == null ? DateTime.now() : _dod,
                                      firstDate: DateTime.now()
                                          .subtract(Duration(days: 1)),
                                      lastDate: DateTime.now()
                                          .add(Duration(days: 90)),
                                    ).then((value) {
                                      setState(() {
                                        _dod = value;
                                      });
                                    });
                                  }),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.location_on,
                              ),
                              title: DropdownButton(
                                  items: indianStateList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: Text('Select the State'),
                                  value: stateSelected,
                                  onChanged: (value) {
                                    stateValueChanged(value);
                                  }),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.location_city,
                              ),
                              title: DropdownButton(
                                items: citiesList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                disabledHint: Text('Select State First'),
                                onChanged: _disabled_city
                                    ? null
                                    : (value) {
                                        setState(() {
                                          citySelected = value;
                                        });
                                      },
                                value: citySelected,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ContactPersonDetails(),
                            RaisedButton(
                                onPressed: () async {
                                  if (globalKey.currentState.validate() &&
                                      !_validate) {
                                    globalKey.currentState.save();
//                                    buildPageView();
                                    // make POST request
                                    final prefrences =
                                        await SharedPreferences.getInstance();
                                    Response response = await post(
                                        "http://freetechtip.in/app/file/employer_post_job.php",
                                        body: {
                                          'username':
                                              prefrences.getString('emp_name'),
                                          'emp_id':
                                              prefrences.getString('emp_id'),
                                          'job_title': Job_title.toString(),
                                          'description': _descriptText.text.toString(),
                                          'comp_email': Email.toString(),
                                          'job_type': current_job_type_selected.toString(),
                                          'category': mainService.toString(),
                                          'subcategory': subMainService.toString(),
                                          'field':FieldListValuess.toString(),
                                          'salary': offered_sal.toString(),
                                          'experience': experience.toString(),
                                          'gender': current_gender_type_selected.toString(),
                                          'qualification':
                                          current_qualification_selected.toString(),
                                          'deadline': _dod
                                              .toIso8601String()
                                              .split('T')[0],
                                          'state': stateSelected.toString(),
                                          'city': citySelected.toString(),
                                          'email': Email.toString(),
                                          'contact_person_name': c_name.toString(),
                                          'contact': c_phone.toString(),
                                          'designation': c_designation.toString(),
                                        });

                                    Map<String, dynamic> map =
                                        jsonDecode(response.body);
                                  }
                                },
                                child: Text("Post",
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.lightBlue),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
