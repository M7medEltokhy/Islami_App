import 'package:flutter/material.dart';
import 'package:islami/features/tabs/radio_tab/widget/radio_card.dart';

class RecitersList extends StatelessWidget {
  const RecitersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const RadioCard(title: 'Ibrahim Al-Akdar');
      },
    );
  }
}
