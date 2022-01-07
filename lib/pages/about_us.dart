
import 'package:flutter/material.dart';





class AboutUs extends StatefulWidget {





  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {


  @override
  Widget build(BuildContext context) {



              return  Scaffold(




                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.blue[900],
                    title: Text("About Us"),
                    centerTitle: true,
                    elevation: 0,


                  ),
                  body: ListView(

                    padding:  EdgeInsets.all(8),
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Container(
                          height: 50,


                          child:
                          Text( 'The way your team works is unique — so is Scrum.', textAlign: TextAlign.center, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ))),

                      SizedBox(height: 50,),
                      Container(
                          height: 200,

                          child:
                          Text( 'Scrum is the flexible work management tool where teams can ideate plans, collaborate on projects, organize workflows, and track progress in a visual, productive, and rewarding way. From brainstorm to planning to execution, Scrum manages the big milestones and the day-to-day tasks of working together and getting things done.', textAlign: TextAlign.center, style: TextStyle(

                              fontSize: 20
                          ))),




                    ],
                  )




              );}


          }












