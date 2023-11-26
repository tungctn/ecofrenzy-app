import 'package:flutter/material.dart';
import 'package:flutter_app/models/challenge.dart';
import 'challenge.card.dart';

class ChallengeList extends StatelessWidget {
  final List<Challenge> challenges;
  const ChallengeList({super.key, required this.challenges});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        return ChallengeCard(challenge: challenges[index]);
      },
    );
  }
}
