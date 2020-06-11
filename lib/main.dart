import 'package:flutter/material.dart';
import 'package:quiz/USER/login.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: LoginScreen(),
      ),
    );
