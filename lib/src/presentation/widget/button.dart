import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final void Function()? onTap;
  final IconData icon;
  final String label;
  const Button({required this.onTap, required this.icon, required this.label, Key? key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 130,
      child: Material(
        color: const Color.fromRGBO(245, 245, 246, 1),
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 70,
                color: const Color.fromRGBO(156, 100, 166, 1),
              ),
              const SizedBox(height: 5,),
              Text(
                widget.label,
                style: const TextStyle(color: Color.fromRGBO(156, 100, 166, 1), fontSize: 16.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
