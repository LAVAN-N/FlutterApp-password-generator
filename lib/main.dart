import 'package:flutter/material.dart';
import 'package:password_generator/src/components/widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: const PasswordGenerator(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 192, 248, 255),
            brightness: Brightness.light),
      ),
    ),
  );
}



//Author:@lavanyan.fr