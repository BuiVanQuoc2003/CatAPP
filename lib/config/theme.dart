import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      )),
);
