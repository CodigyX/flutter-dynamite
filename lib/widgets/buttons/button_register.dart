import 'package:flutter/material.dart';
import 'package:flutter_template/pallete.dart';

class MyRegisterButton extends StatelessWidget {
  final Function onPressed;
  final bool enabled;
  final bool loading;

  const MyRegisterButton(
      {super.key,
      required this.onPressed,
      required this.enabled,
      required this.loading});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: enabled ? () => onPressed() : null,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          primary: Colors.transparent, // Fondo transparente
          shadowColor: Colors.transparent, // Sin sombra
        ),
        child: Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
