import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_de_projets/pages/home_developer.dart';
import 'package:gestion_de_projets/pages/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';




class ProfilePageDev extends StatefulWidget {
  final String? cugmail;
  final String? pw;
  ProfilePageDev({this.cugmail, this.pw});


  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePageDev>
    with SingleTickerProviderStateMixin {
  UserModel user= UserModel("", "", "", "");
  Future? _future;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController fnController = TextEditingController();

  TextEditingController lnController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();


  Future<Map> getuser() async {
    Response response = await http.post(
      Uri.parse('https://dsi32-todo.herokuapp.com/oneuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.cugmail!.toString(),

      }),
    );
    Map<String,dynamic> rep = jsonDecode(response.body);
    print(rep);

    fnController.text=rep["data"]["username"];
    mobileController.text=rep["data"]["phoneNumber"];
    ageController.text=rep["data"]["age"].toString();
    lnController.text=rep["data"]["lastname"];
    pwController.text= widget.pw!;


    user= UserModel(fnController.text,lnController.text,mobileController.text,ageController.text);

    return rep["data"];
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: 'Informations saved',
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 20,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
    );
  }


  @override
  void initState() {

    _future = getuser();

   super.initState();





  }

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot snapshot) {




            if(snapshot.hasData)
            {


              return WillPopScope(
                  onWillPop: () => Future.value(false),
                  child: Scaffold(
                      backgroundColor: Colors.white,

                      appBar: AppBar(
                        backgroundColor: Colors.blue[900],
                        automaticallyImplyLeading: false,
                        leading: IconButton (icon:Icon(Icons.arrow_back),
                          onPressed: (){Navigator.push(context,
                              MaterialPageRoute(builder: (context) => home_developer(currentgmail: widget.cugmail,password: pwController.text)
                              ));

                          },),

                        title: Text('Profile'),
                        centerTitle: true,
                        elevation: 0,

                      ),
                      body: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                              child: Container(
                                color: Colors.white,
                                child:
                                Column(
                                  children: <Widget>[

                                    Container(
                                      color: Color(0xffFFFFFF),
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 25.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 25.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Personal Information',
                                                          style: TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .end,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        _status
                                                            ? _getEditIcon()
                                                            : Container(),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 25.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          "First Name",
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 2.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: TextFormField(
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
                                                        ],

                                                        controller: fnController,
                                                        decoration: const InputDecoration(
                                                          hintText: "Enter Your First Name",
                                                        ),
                                                        enabled: !_status,
                                                        autofocus: !_status,
                                                        validator: (String? value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter your first name';
                                                          } else if (value.length > 14) {
                                                            return 'Your first name is too long!';
                                                          }
                                                          return null;
                                                        },


                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 25.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          "Last Name",
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 2.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: TextFormField(
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú]")),
                                                        ],

                                                        controller: lnController,
                                                        decoration: const InputDecoration(
                                                          hintText: "Enter Your Last Name",

                                                        ),

                                                        enabled: !_status,
                                                        autofocus: !_status,
                                                        validator: (String? value) {
                                                          if ( value!.isEmpty) {
                                                            return 'Please enter your Last Name';
                                                          } else if (value.length > 14) {
                                                            return 'Your last name is too long !';
                                                          }

                                                          return null;
                                                        },


                                                      ),
                                                    ),
                                                  ],
                                                )),

                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 25.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          'Mobile',
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 2.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: TextFormField(
                                                        controller: mobileController,
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter.digitsOnly
                                                        ],
                                                        decoration: const InputDecoration(
                                                            hintText: "Enter Mobile Number"),
                                                        enabled: !_status,
                                                        validator: (String? value) {
                                                          if ( value!.isEmpty) {
                                                            return 'Please enter your mobile number';
                                                          } else if (value.length != 8) {
                                                            return 'Your number is not validate !';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 25.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                        child: Text(
                                                          'Age',
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                      flex: 2,
                                                    ),

                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 2.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 10.0),
                                                        child: TextFormField(
                                                          controller: ageController,
                                                          keyboardType: TextInputType.number,
                                                          inputFormatters: <TextInputFormatter>[
                                                            FilteringTextInputFormatter.digitsOnly
                                                          ],
                                                          decoration: const InputDecoration(
                                                              hintText: "Enter Your Age"),
                                                          enabled: !_status,
                                                          validator: (String? value) {
                                                            if ( value!.isEmpty) {
                                                              return 'Please enter your age';
                                                            } else if (int.parse(value) > 99 || int.parse(value) < 18) {
                                                              return 'Please enter Valid age  !';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),

                                                      flex: 2,
                                                    ),


                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 25.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          "Password",
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.0, right: 25.0, top: 2.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: TextFormField(

                                                        controller: pwController,
                                                        decoration: const InputDecoration(
                                                          hintText: "Enter Your Password",
                                                        ),
                                                        enabled: !_status,
                                                        autofocus: !_status,
                                                        obscureText: true,
                                                        validator: (String? value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter your password';
                                                          } else if (value.length < 3) {
                                                            return 'Your password is too week!';
                                                          }
                                                          return null;
                                                        },


                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            !_status ? _getActionButtons() : Container(),

                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),


                              )))));}
            else  {
              return Scaffold(
                backgroundColor: Colors.blue[900],
                body: Center(
                  child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 80.0,
                  ),

                ),
              );
            };
          }
      );
  }

  @override
  void dispose() {

    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child:  Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child:  RaisedButton(
                    child:  Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          // _formKey.currentState!.save();
                          edituser();
                          showToast();

                          _status = true;
                          FocusScope.of(context).requestFocus( FocusNode());



                        }





                      });


                    },
                    shape:  RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child:  RaisedButton(
                    child:  Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        fnController.text=user.fnController;
                        lnController.text=user.lnController;
                        ageController.text=user.ageController;
                        mobileController.text=user.mobileController;



                        _status = true;
                        FocusScope.of(context).requestFocus( FocusNode());

                      });
                    },
                    shape:  RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
  Future<void> edituser() async {


    Map<String,String> informations ={'email': widget.cugmail!} ;
    if(fnController.text != "")
    {
      informations['firstName'] = fnController.text;
    }
    if(lnController.text != "")
    {
      informations['lastName'] = lnController.text;
    }
    if(ageController.text != "")
    {
      informations['age'] = ageController.text;
    }
    if(mobileController.text != "")
    {
      informations['phoneNumber'] = mobileController.text;
    }
    if(pwController.text != "")
    {
      informations['password'] = pwController.text;
    }



    var response = await http.post(
      Uri.parse('https://dsi32-todo.herokuapp.com/useredit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(informations),
    );

    Map data = jsonDecode(response.body);
    print(data);



  }

  Widget _getEditIcon() {
    return  GestureDetector(
      child:  CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child:  Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}