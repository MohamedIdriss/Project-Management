import 'package:flutter/material.dart';
import 'package:gestion_de_projets/pages/login.dart';
import 'package:gestion_de_projets/pages/home_client.dart';
import 'package:gestion_de_projets/pages/home_developer.dart';
import 'package:gestion_de_projets/pages/home_master.dart';
void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => LoginPage(),
      '/home_client': (context) => home_client(),
      '/home_developer': (context) => home_developer(),
      '/home_master': (context) => home_master(),

    },
  ) );
}

