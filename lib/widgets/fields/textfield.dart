import 'package:flutter/material.dart';
import 'package:flutter_template/pallete.dart';

class TextFieldGeneric extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onPressed;

  const TextFieldGeneric({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.labelText,
    required this.keyboardType,
    this.obscureText = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        controller: textController,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          contentPadding: const EdgeInsets.all(27),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Pallete.borderColor,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Pallete.gradient2,
              width: 3,
            ),
          ),
          suffixIcon: onPressed != null
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: onPressed,
                )
              : null, // Mostrar el icono solo si onPressed no es nulo
        ),
      ),
    );
  }
}
