import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData leading;
  final String title;
  final String subtitle;

  const InfoCard({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(leading),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
