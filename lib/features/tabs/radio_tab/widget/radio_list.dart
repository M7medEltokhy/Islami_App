import 'package:flutter/material.dart';
import 'package:islami/features/tabs/radio_tab/widget/radio_card.dart';

class RadioList extends StatelessWidget {
  const RadioList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const RadioCard(title: 'Radio Ibrahim Al-Akdar');
      },
    );
  }
}


