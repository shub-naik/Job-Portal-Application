import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:toast/toast.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class CandidateSignupPersonalDetails extends StatefulWidget {
  // Here username means first name
  String username, mobile;

  CandidateSignupPersonalDetails({this.username, this.mobile});



  @override
  _CandidateSignupPersonalDetailsState createState() =>
      _CandidateSignupPersonalDetailsState(username, mobile);
}

class _CandidateSignupPersonalDetailsState
    extends State<CandidateSignupPersonalDetails> {
  List<dynamic> FieldListValue =[];
  // For Makable and Fadchi
  String mainService, subMainService, field;
  bool boolSubCategory = true;
  List<String> AllSelectedFieldValue = [];
  List<DropdownMenuItem<String>> SubCategoryList = List();
  List<Map<String, String>> FieldList = List();

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

  void FieldValueChanged(String newValue) {
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

  List<String> citiesList = [];
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
  String citySelected;

  bool _disabled_city = true;

  void valueChanged(String value) async {
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

  final _temporary_address = TextEditingController();
  final _permanent_address = TextEditingController();

  String username,
      experienceValue,
      lastnamevalue,
      fathernamevalue,
      gendervalue,
      mobilefieldvalue,
      emailfieldvalue,
      agevalue,
      socialcategoryvalue,
      maritalvalue,
      year_of_passing_field,
      pincodevalue,
      qualificationvalue;

  DateTime _dob;

  int teamSize = 0;
  bool _validate = false;
  bool _permanent_validate = false;
  bool boolPermanentAddress = false;
  var gender = ['Male', 'Female', 'Others'];
  var socail_category = ['OBC', 'SC', 'ST', 'GENERAL', 'Others'];
  var marriage_status = ['Single', 'Married'];
  var year_experience = ['1+', '2+', '3+', '5+'];
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  _CandidateSignupPersonalDetailsState(this.username, this.mobilefieldvalue);

  Widget LastNameField() {
    return TextFormField(
        maxLength: 50,
        decoration: InputDecoration(labelText: "Last Name"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Last Name is Required';
          }
          return null;
        },
        onSaved: (String value) {
          lastnamevalue = value;
        });
  }

  Widget AgeField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Phone Number"),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (!RegExp(r"^(?:[+0]9)?[0-9]{2}$").hasMatch(value)) {
            return 'Correct 2 digit Age Value is Required';
          }
          return null;
        },
        onSaved: (String value) {
          agevalue = value;
        });
  }

  Widget YearField() {
    return TextFormField(
        maxLength: 4,
        decoration: InputDecoration(labelText: "Year Of Passing"),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (!RegExp(r"^(?:[+0]9)?[0-9]{4}$").hasMatch(value)) {
            return 'Correct 4 digit Year Value is Required';
          }
          return null;
        },
        onSaved: (String value) {
          year_of_passing_field = value;
        });
  }

  Widget PincodeField() {
    return TextFormField(
        maxLength: 6,
        decoration: InputDecoration(labelText: "Pincode"),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (!RegExp(r"^(?:[+0]9)?[0-9]{6}$").hasMatch(value)) {
            return 'Correct 6 digit Pincode Value is Required';
          }
          return null;
        },
        onSaved: (String value) {
          pincodevalue = value;
        });
  }

  Widget EmailField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Email"),
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
          emailfieldvalue = value;
        });
  }

  Widget FatherNameField() {
    return TextFormField(
        maxLength: 60,
        decoration: InputDecoration(labelText: "Father Name"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Father Name is Required';
          }
          return null;
        },
        onSaved: (String value) {
          fathernamevalue = value;
        });
  }

  @override
  void dispose() {
    _temporary_address.dispose();
    super.dispose();
  }

  // Image Upload Functions Starts here

// To store the file provided by the image_picker
  File _imageFile;

  // To track the file uploading state
  bool _isUploading = false;

  String baseUrl = 'http://freetechtip.in/app/file/api.php';

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = image;
    });

    // Closes the bottom sheet
    Navigator.pop(context);
  }

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    print('Uploading');

    // Find the mime type of the selected file by looking at the header bytes of the file
    final mimeTypeData =
    lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    // Intilize the multipart request
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse(baseUrl));

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['username'] = username;
    imageUploadRequest.fields['firstName'] = username;
    imageUploadRequest.fields['lastName'] = lastnamevalue;
    imageUploadRequest.fields['fatherName'] = fathernamevalue;
    imageUploadRequest.fields['gender'] = gendervalue;
    imageUploadRequest.fields['mobile'] = mobilefieldvalue;
    imageUploadRequest.fields['dob'] = _dob.toIso8601String().split('T')[0];
    imageUploadRequest.fields['email'] = emailfieldvalue;
    imageUploadRequest.fields['socialCategory'] = socialcategoryvalue;
    imageUploadRequest.fields['maritalStatus'] = maritalvalue;
    imageUploadRequest.fields['qualification'] = qualificationvalue;
    imageUploadRequest.fields['passingYear'] = year_of_passing_field;
    imageUploadRequest.fields['experiance'] = experienceValue;
    imageUploadRequest.fields['tempAddress'] = _temporary_address.text;
    imageUploadRequest.fields['permanentAddress'] = _permanent_address.text;
    imageUploadRequest.fields['pinCode'] = pincodevalue;
    imageUploadRequest.fields['country'] = 'India';
    imageUploadRequest.fields['state'] = stateSelected;
    imageUploadRequest.fields['city'] = citySelected;
    imageUploadRequest.fields['categories'] = mainService;
    imageUploadRequest.fields['subcategory'] = subMainService;
    imageUploadRequest.fields['field'] = FieldListValue.toString();

    try {
      final streamedResponse = await imageUploadRequest.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        return null;
      }
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);

      return responseData;
    } catch (e) {
      return null;
    }
  }

  void _startUploading() async {
    print('Uploading');
    final Map<String, dynamic> response = await _uploadImage(_imageFile);
    // Check if any error occured
    if (response == null) {
      Toast.show("Image Upload Failed!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Image Uploaded Successfully!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
    });
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }
//
//  Widget _buildUploadBtn() {
//    Widget btnWidget = Container();
//
//    if (_isUploading) {
//      // File is being uploaded then show a progress indicator
//      btnWidget = Container(
//          margin: EdgeInsets.only(top: 10.0),
//          child: CircularProgressIndicator());
//    } else if (!_isUploading && _imageFile != null) {
//      // If image is picked by the user then show a upload btn
//
//      btnWidget = Container(
//        margin: EdgeInsets.only(top: 10.0),
//        child: RaisedButton(
//          child: Text('Upload'),
//          onPressed: () {
//            _startUploading();
//          },
//          color: Colors.pinkAccent,
//          textColor: Colors.white,
//        ),
//      );
//    }
//
//    return btnWidget;
//  }

  // Image Upload Functions Ends Here




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile for $username'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                color: Colors.cyanAccent,
                child: Column(
                  children: <Widget>[
                    // For Image Upload
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                      child: OutlineButton(
                        onPressed: () => _openImagePickerModal(context),
                        borderSide:
                        BorderSide(color: Theme.of(context).accentColor, width: 1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.camera_alt),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Add Image'),
                          ],
                        ),
                      ),
                    ),
                    _imageFile == null
                        ? Text('Please pick an image')
                        : Image.file(
                      _imageFile,
                      fit: BoxFit.cover,
                      height: 300.0,
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width,
                    ),
//                    _buildUploadBtn(),
                    // Image Upload Ends Here
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                            key: globalKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  'Personal Details',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )),
                                Divider(
                                  color: Colors.red,
                                ),
                                Text(
                                  "Username : " + username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Phone Number : '+mobilefieldvalue,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20)),
                                SizedBox(
                                  height: 10,
                                ),
                                FatherNameField(),
                                SizedBox(
                                  height: 10,
                                ),
                                LastNameField(),
                                SizedBox(
                                  height: 10,
                                ),
                                RaisedButton(
                                    color: Colors.black26,
                                    child: _dob == null
                                        ? Text('Click to Pick your Date Of Birth',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))
                                        : Text(
                                            "Selected DOB is : " +
                                                _dob
                                                    .toIso8601String()
                                                    .split('T')[0],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: _dob == null
                                                  ? DateTime(
                                                      DateTime.now().year - 18)
                                                  : _dob,
                                              firstDate: DateTime(1970),
                                              lastDate: DateTime(
                                                  DateTime.now().year - 18))
                                          .then((value) {
                                        setState(() {
                                          _dob = value;
                                        });
                                      });
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                EmailField(),
                                SizedBox(
                                  height: 10,
                                ),
                                DropdownButton<String>(
                                  items: gender.map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem));
                                  }).toList(),
                                  onChanged: (String newValueSelected) {
                                    setState(() {
                                      this.gendervalue = newValueSelected;
                                    });
                                  },
                                  hint: Text('Select the Gender'),
                                  value: gendervalue,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DropdownButton<String>(
                                  items: socail_category
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem));
                                  }).toList(),
                                  onChanged: (String newValueSelected) {
                                    setState(() {
                                      this.socialcategoryvalue = newValueSelected;
                                    });
                                  },
                                  hint: Text('Select the Social Category'),
                                  value: socialcategoryvalue,
                                ),
                                DropdownButton<String>(
                                  items: marriage_status
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem));
                                  }).toList(),
                                  onChanged: (String newValueSelected) {
                                    setState(() {
                                      this.maritalvalue = newValueSelected;
                                    });
                                  },
                                  hint: Text('Select the Marital Status'),
                                  value: maritalvalue,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: Text(
                                  'Educational Details',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )),
                                Divider(
                                  color: Colors.redAccent,
                                ),
                                DropdownButton<String>(
                                  items: ['10th', '12th', '12+']
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem));
                                  }).toList(),
                                  onChanged: (String newValueSelected) {
                                    setState(() {
                                      this.qualificationvalue = newValueSelected;
                                    });
                                  },
                                  hint: Text('Select the Qualification'),
                                  value: qualificationvalue,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                YearField(),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: Text(
                                  'Contact Details',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )),
                                Divider(
                                  color: Colors.redAccent,
                                ),
                                TextField(
                                  autofocus: false,
                                  controller: _temporary_address,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: 'Temporary Address',
                                    errorText: _validate
                                        ? 'Temporary Address Can\'t Be Empty'
                                        : null,
                                  ),
                                  maxLines: null,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                          value: boolPermanentAddress,
                                          onChanged: (bool value) {
                                            setState(() {
                                              boolPermanentAddress = value;
                                              if (boolPermanentAddress == true) {
                                                _permanent_address.text =
                                                    _temporary_address.text;
                                                print(_permanent_address.text);
                                              } else {
                                                _permanent_address.text = "";
                                              }
                                            });
                                          },
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          "Temporary Address Same as Permanent Address"),
                                    ),
                                  ],
                                ),
                                boolPermanentAddress
                                    ? Container(
                                        child: Text(''),
                                      )
                                    : TextField(
                                        autofocus: false,
                                        controller: _permanent_address,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          hintText: 'Permanent Address',
                                          errorText: _permanent_validate
                                              ? 'Permanent Address Can\'t Be Empty'
                                              : null,
                                        ),
                                        maxLines: null,
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                PincodeField(),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Country : India",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DropdownButton(
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
                                      valueChanged(value);
                                    }),
                                DropdownButton(
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
                                DropdownButton<String>(
                                  items: ['MAKABLE', 'FADCHI', 'BOTH']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: Text('Select Services'),
                                  onChanged: (_value) => FieldValueChanged(_value),
                                  value: mainService,
                                ),
                                DropdownButton<String>(
                                  items: SubCategoryList,
                                  onChanged: boolSubCategory
                                      ? null
                                      : (_value) => secondValueChanged(_value),
                                  hint: Text('Select Services'),
                                  disabledHint:
                                      Text('Please Select Services First'),
                                  value: boolSubCategory ? null : subMainService,
                                ),
                                MultiSelect(
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
                                    print("$values");
                                    FieldListValue = values;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DropdownButton<String>(
                                  items: year_experience.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: Text('Select Experience'),
                                  onChanged: (_value) {
                                    setState(() {
                                      experienceValue = _value;
                                    });
                                  },
                                  value: experienceValue,
                                ),
                                Container(
                                  child: RaisedButton(
                                    splashColor: Colors.blue,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(40),
                                      side: new BorderSide(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _temporary_address.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        _permanent_address.text.isEmpty
                                            ? _permanent_validate = true
                                            : _permanent_validate = false;
                                      });
                                      if (globalKey.currentState.validate() &&
                                          !_validate) {
                                        globalKey.currentState.save();
                                        _startUploading();
                                      }
                                    },
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Send Personal Data',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
