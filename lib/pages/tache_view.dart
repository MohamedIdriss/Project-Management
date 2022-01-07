import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_de_projets/pages/home_developer.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'login.dart';

class TacheView extends StatefulWidget {

  final String? tacheId;
  final String? currentgmail;
  final String? password;
  TacheView({this.tacheId,this.currentgmail,this.password});



  @override
  _TacheViewState createState() => _TacheViewState();
}

class _TacheViewState extends State<TacheView> {
  Future? _future;
  int selectedTool = 0;
  Future? _user;
  String etatSelected = "en_cours";











  Future<Map> oneTache() async {

    Response response = await http.post(
      Uri.parse('https://dsi32-todo.herokuapp.com/onetache'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tache_id': widget.tacheId!.toString() ,

      }),
    );

    Map<String,dynamic> rep = jsonDecode(response.body);




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


  void initState()  {

    super.initState();
    _future =oneTache();



  }





  @override
  Widget build(BuildContext context) {



    return WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      FutureBuilder(
          future: _future!,
          builder: (context, AsyncSnapshot? snapshot)  {




            if(snapshot!.hasData)
            {


              return  Scaffold(




                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.blue[900],
                    automaticallyImplyLeading: false,
                    leading: IconButton (icon:Icon(Icons.arrow_back),
                      onPressed: (){Navigator.push(context,
                          MaterialPageRoute(builder: (context) => home_developer(currentgmail: widget.currentgmail,password: widget.password)
                          ));

                      },),
                    title: Text("developer"),
                    centerTitle: true,
                    elevation: 0,
                    actions: [RaisedButton(
                      child:  Text("Save"),
                      textColor: Colors.white,
                      color: Colors.blue[900],

                      onPressed: () {

                        edittache();
                        showToast();









                      },

                    )],


                  ),
                  body: ListView(

                    padding:  EdgeInsets.all(8),
                    children: <Widget>[
                      SizedBox(height: 30,),
                      FadeInDown(
                        from: 50,
                        child:  Container(
                            height: 50,

                            child:
                            Text("About This Tache", textAlign: TextAlign.center, style: TextStyle(
                                color: Colors.blueGrey.shade400,
                                fontSize: 20
                            ))),
                      ),
                      Container(
                        height: 50,

                        child:
                        Row(
                          children:  <Widget>[
                            Expanded(
                              child:  Text('Tache Name:', textAlign: TextAlign.center, style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),

                            ),
                            Expanded(
                              child: Text(snapshot.data["tache_name"].toString(),  textAlign: TextAlign.center, style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,

                              ),),
                            ),


                          ],
                        ),
                      ),

                      Container(
                        height: 50,

                        child:
                        Row(
                          children:  <Widget>[
                            Expanded(
                              child:  Text('Project Name:', textAlign: TextAlign.center, style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),

                            ),
                            Expanded(
                              child: Text(snapshot.data["project_name"].toString(),  textAlign: TextAlign.center, style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,

                              ),),
                            ),


                          ],
                        ),
                      ),

                      Container(
                        height: 50,

                        child:
                        Row(
                          children:  <Widget>[
                            Expanded(
                              child:  Text('start date:', textAlign: TextAlign.center, style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Expanded(
                              child: Text(snapshot.data["date_debut"].toString(),  textAlign: TextAlign.center, style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,

                              ),),
                            ),


                          ],
                        ),
                      ),
                      Container(
                        height: 50,

                        child:
                        Row(
                          children:  <Widget>[
                            Expanded(
                              child:  Text('end date:', textAlign: TextAlign.center, style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Expanded(
                              child: Text(snapshot.data["date_fin"].toString(),  textAlign: TextAlign.center , style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,

                              ),),
                            ),


                          ],
                        ),
                      ),
                      Container(
                        height: 50,

                        child:
                        Row(
                          children:  <Widget>[
                            Expanded(
                              child:  Text('Etat:', textAlign: TextAlign.center, style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Expanded(
                              child: DropdownButton(
                                items: [
                                  DropdownMenuItem(child: Text("In progress"), value: "en_cours"),
                                  DropdownMenuItem(child: Text("waiting"), value: "en_attend"),
                                  DropdownMenuItem(child: Text("Completed"), value: "terminee"),

                                ],
                                value: etatSelected,
                                onChanged: (String? value) {
                                  setState(() {
                                    etatSelected = value!;
                                  });
                                },
                              )
                            ),





                          ],
                        ),
                      ),
                      ],
                  )




              );}
            else {

              print("mohamed " + snapshot.data.toString());
              return Scaffold(
                backgroundColor: Colors.blue[900],
                body: Center(
                  child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 80.0,
                  ),

                ),
              );
            }

          }
        // }





      ));

  }
  Future<void> edittache() async {



    var response = await http.post(
      Uri.parse('https://dsi32-todo.herokuapp.com/tacheedit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tache_id': widget.tacheId.toString(),
        'etat': etatSelected,

      }),
    );

    Map data = jsonDecode(response.body);


  }


}
