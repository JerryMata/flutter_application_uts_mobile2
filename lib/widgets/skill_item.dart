import 'package:flutter/material.dart';

class SkillItem extends StatelessWidget {
  final String name;

  const SkillItem({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Center(
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
