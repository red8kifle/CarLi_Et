import 'package:flutter/material.dart';

class InputLineWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;


  const InputLineWidget({
    required this.label,
    required this.hintText,
    this.validator,
    this.controller,
    super.key
  });

  @override
  State<InputLineWidget> createState() => _InputLineWidgetState();
}

class _InputLineWidgetState extends State<InputLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 27),
        Container(
            width: double.infinity,
            child: Text(
          widget.label,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )
        )
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14
              ),
              border: UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF008080), width: 2),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              )
            ),
            controller: widget.controller,
            validator: widget.validator,
          )
        ),
        SizedBox(width: 25)
      ],
    );
  }
}
