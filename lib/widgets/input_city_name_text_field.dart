import 'package:flutter/material.dart';

class InputCityNameTextField extends StatelessWidget {
  const InputCityNameTextField(
      {super.key,
      required this.textEditingController,
      required this.cityNamePressed});

  final TextEditingController textEditingController;
  final VoidCallback cityNamePressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white, fontSize: 25),
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: 'Input City',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white70,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: cityNamePressed,
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
