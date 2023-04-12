import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white12,
  filled: true,
  contentPadding: EdgeInsets.all(16.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);