import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  static const String routeName = '/learn';

  const LearnScreen({super.key});

  @override
  LearnScreenState createState() => LearnScreenState();
}

class LearnScreenState extends State<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("Learn Screen");
  }
}
