import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



class ProjectView extends StatefulWidget {

  final String? projetId;
  ProjectView({this.projetId});



  @override
  _home_clientState createState() => _home_clientState();
}

class _home_clientState extends State<ProjectView> {
  Future? _future;
  int selectedTool = 0;












  Future<Map> oneProjet() async {

    Response response = await http.post(
      Uri.parse('https://dsi32-todo.herokuapp.com/oneproject'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'project_id': widget.projetId!.toString() ,

      }),
    );
    print("t3adda");
    Map<String,dynamic> rep = jsonDecode(response.body);
    print(rep);



    return rep["data"];
  }


  void initState()  {

    super.initState();
    _future =oneProjet();



  }





  @override
  Widget build(BuildContext context) {



    return
        FutureBuilder(
            future: _future!,
            builder: (context, AsyncSnapshot? snapshot)  {


              if(snapshot!.hasData)
                {

              return  Scaffold(




                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.blue[900],
                  title: Text("Planning"),
                  centerTitle: true,
                  elevation: 0,


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
                          Text("About This Project", textAlign: TextAlign.center, style: TextStyle(
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
                            child:  Text('Project Name:', textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),

                          ),
                          Expanded(
                            child: Text(snapshot.data["projectname"].toString(),  textAlign: TextAlign.center, style: TextStyle(
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
                            child:  Text('Description:', textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Expanded(
                            child: Text(snapshot.data["description"].toString(),  textAlign: TextAlign.center, style: TextStyle(
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





        );
  }



}
