import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appTitle),
      ),
      body: Center(
        child: Text(Strings.appTitle),
      ),
    );
  }
}
