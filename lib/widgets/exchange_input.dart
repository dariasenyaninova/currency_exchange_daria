import 'package:flutter/material.dart';

class ExchangeInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  ExchangeInput({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: TextInputType.number,
    );
  }
}
