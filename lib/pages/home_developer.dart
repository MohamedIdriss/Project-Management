import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_de_projets/pages/about_us.dart';

import 'package:gestion_de_projets/pages/profile_page_dev.dart';
import 'package:gestion_de_projets/pages/tache_view.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'login.dart';

class home_developer extends StatefulWidget {


  final String? currentgmail;
  final String? password;
  home_developer({this.currentgmail, this.password});

  @override
  _home_developerState createState() => _home_developerState();
}

class _home_developerState extends State<home_developer> {
  Future? _future;
  int selectedTool = 0;


  Future<List<dynamic>> gettacheByEmail() async {
    Response response = await http.post(
      Uri.parse('https://dsi32-todo.herokuapp.com/gettachebydeveloper'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.currentgmail!.toString(),

      }),
    );
    Map<String,dynamic> rep = jsonDecode(response.body);
    print(rep);
    Map<String,dynamic> test= {"data":[{"error":"404"}]};
    if(rep["message"]=="tache not found") {

      return test["data"];
    }

    return rep["data"];
  }


  void initState()  {

    _future =gettacheByEmail();

    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child:
        FutureBuilder(
            future: _future!,
            builder: (context, AsyncSnapshot? snapshot)  {
              List? snap =  snapshot!.data;


              if (!snapshot.hasData) {
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

              return  Scaffold(
                drawer: getDrawer(snap!),


                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.blue[900],
                  title: Text("Planning"),
                  centerTitle: true,
                  elevation: 0,


                ),
                body:


                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      SizedBox(height: 10,),
                      FadeInDown(
                        from: 50,
                        child: Text("List of taches", style: TextStyle(
                            color: Colors.blueGrey.shade400,
                            fontSize: 20
                        ),),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [


                          Text('Tache Name',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),




                          Text('State',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          Text('',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),


                      SizedBox(height: 20,),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.71,
                        child: ListView.builder(
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            if (snap[0]["error"] == "404") {
                              return Text("No Tache Yet", style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),);
                            }
                            String e='';
                            if (snap[index]['etat'] =='en_attend')
                              {
                                e='Waiting';
                              }
                            if (snap[index]['etat'] =='terminee')
                            {
                              e='Completed';
                            }
                            if (snap[index]['etat'] =='en_cours')
                            {
                              e='In progress';
                            }

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTool = index;
                                });
                              },
                              child: FadeInUp(
                                delay: Duration(milliseconds: index * 100),
                                child: AnimatedContainer(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  margin: EdgeInsets.only(bottom: 20),
                                  duration: Duration(milliseconds: 500),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: selectedTool == index ? Colors
                                              .blue : Colors.white.withOpacity(
                                              0),
                                          width: 2
                                      ),
                                      boxShadow: [
                                        selectedTool == index ?
                                        BoxShadow(
                                            color: Colors.blue.shade100,
                                            offset: Offset(0, 3),
                                            blurRadius: 10
                                        ) : BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(0, 3),
                                            blurRadius: 10
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [


                                      Text(snap[index]["tache_name"],
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),),


                                      Text(e ,
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      TextButton(
                                        style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                        ),
                                        onPressed: () {

                                           Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => TacheView(tacheId: snap[index]['tache_id'].toString(), currentgmail: widget.currentgmail, password: widget.password)
                                              ));

                                        },
                                        child: Text('Details'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),



              );
            }
          // }





        ));
  }


  Widget getDrawer(List? da) {



    return  Drawer(

      child: Container(
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            CustomPaint(

              child: DrawerHeader(
                decoration:BoxDecoration(

                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [

                        Colors.blueAccent,
                        Colors.white,
                      ],
                    )
                ),

                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 55,
                      backgroundImage: NetworkImage("https://www.trustedclothes.com/blog/wp-content/uploads/2019/02/anonymous-person-221117.jpg"),
                    ),
                    SizedBox(
                      width: 20,
                    ),

                    Text(widget.currentgmail!),

                  ],
                ),
              ),
            ),
            Column(children: <Widget>[]),



            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(

                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),

              ),
              trailing: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePageDev(cugmail: widget.currentgmail, pw: widget.password)
                    ));

              },
            ),
            ListTile(
              title: Text(
                'About Us',
                style: TextStyle(

                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),

              ),
              trailing: Icon(
                Icons.wrap_text,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()
                    ));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Logout',
                      style: TextStyle(

                        fontSize: 16,
                        fontWeight: FontWeight.w500,

                      ),

                    ),
                    Icon(
                      Icons.settings_power,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}

