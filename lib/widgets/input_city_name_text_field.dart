import 'package:flutter/material.dart';

class InputCityNameTextField extends StatelessWidget {
  const InputCityNameTextField(
      {super.key,
      required this.textEditingController,
      required this.voidCallback});

  final TextEditingController textEditingController;
  final VoidCallback voidCallback;

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
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: voidCallback,
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
