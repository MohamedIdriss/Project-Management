import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:gestion_de_projets/pages/profile_page.dart';
import 'package:gestion_de_projets/pages/project_view.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'about_us.dart';
import 'login.dart';

class home_client extends StatefulWidget {

   final String? currentgmail;
   final String? password;
  home_client({this.currentgmail,this.password});



  @override
  _home_clientState createState() => _home_clientState();
}

class _home_clientState extends State<home_client> {
Future? _future;
int selectedTool = 0;
Future? _user;










  Future<List<dynamic>> getProjectByEmail() async {
    Response response = await http.post(
      Uri.parse('https://dsi32-todo.herokuapp.com/getprojectbyclient'),
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
    if(rep["message"]=="project not found") {
      //print(rep);
      //print(test["data"]);
      return test["data"];
    }

    return rep["data"];
  }


  void initState()  {

     _future =getProjectByEmail();

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
                backgroundColor: Colors.white,
                drawer: getDrawer(snap!),



                appBar: AppBar(
                  backgroundColor: Colors.blue[900],
                  title: Text("Planning"),
                  centerTitle: true,
                  elevation: 0,


                ),
                body:


                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      FadeInDown(
                        from: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      FadeInDown(
                        from: 50,
                        child: Text("List of Projects", style: TextStyle(
                            color: Colors.blueGrey.shade400,
                            fontSize: 26
                        ),),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.75,
                        child: ListView.builder(
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            if (snap[0]["error"] == "404") {
                              return Text("No Project Yet", style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),);
                            }

                            int c=0;
                            int total=snap[index]["tache"].length;

                            snap[index]["tache"].forEach((var i) {

                              print(i['etat']);
                              if(i['etat']=='terminee')
                                {
                                  c++;

                                }


                            }


                            );
                            double pourcentage=(c/total) ;
                            print(pourcentage);

                             Shader co= LinearGradient(colors: <Color>[Color(0xffC22C4E),Color(0xff7A0C72)]).createShader(Rect.fromLTRB(0.0, 0.0, 200.0, 70.0));

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTool = index;
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => ProjectView(projetId: snap[index]['id'].toString())
                                    ));
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
                                  child: Column(



                                    children: [
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [


                                          Text(snap[index]["projectname"],
                                            style: TextStyle(

                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              foreground: Paint()..shader= co
                                            ),),



                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child:  LinearPercentIndicator(
                                          width: 280,
                                          animation: true,
                                          lineHeight: 20.0,
                                          animationDuration: 2000,
                                          percent: pourcentage,
                                          center: Text("${pourcentage*100}"),
                                          linearStrokeCap: LinearStrokeCap.roundAll,
                                          progressColor: Colors.greenAccent,
                                        ),
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
                    /*Text(
                      a.toString(),

                    ),*/
                    Text(widget.currentgmail!),

                  ],
                ),
              ),
            ),




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
                    MaterialPageRoute(builder: (context) => ProfilePage(cugmail: widget.currentgmail,pw: widget.password)
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
