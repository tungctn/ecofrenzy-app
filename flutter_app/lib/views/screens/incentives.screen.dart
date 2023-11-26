import 'package:flutter/material.dart';

class IncentivesScreen extends StatefulWidget {
  static const String routeName = '/incentives';

  const IncentivesScreen({Key? key}) : super(key: key);

  @override
  IncentivesScreenState createState() => IncentivesScreenState();
}

class IncentivesScreenState extends State<IncentivesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("Incentives Screen");
  }
}
