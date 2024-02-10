import 'package:flutter/material.dart';
import 'package:random_quote_generator/quotegenertor.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Random Quote Generator',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const QuoteGeneratorPage(),
  ));
}
