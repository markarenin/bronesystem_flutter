import 'package:flutter/material.dart';

class SafeContainer extends StatelessWidget {
  const SafeContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}