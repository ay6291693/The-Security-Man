import 'package:flutter/material.dart';
import 'package:thesecurityman/components/input_container.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({Key key, @required this.hint}) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        cursorColor: Colors.black,
        obscureText: true,
        validator: (String value){
          if(value.trim().isEmpty){
            return 'Password is required';
          }
          return null;
        },
        decoration: InputDecoration(
            icon: Icon(Icons.lock, color: Color(0xFF23408e)),
            hintText: hint,
            border: InputBorder.none),
      ),
    );
  }
}
