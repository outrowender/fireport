import 'package:flutter/material.dart';

class MaterialFormWidgets {
  static Widget textField({
    String label,
    TextInputType inputType,
    TextEditingController controller,
    bool isPassword,
    Function callback,
  }) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: TextField(
        keyboardAppearance: Brightness.dark,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        obscureText: isPassword,
        keyboardType: inputType,
        onChanged: callback,
      ),
    );
  }

  static Widget checkbox(String label) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: false,
          onChanged: (val) {},
        ),
        Text(label),
      ],
    );
  }
}
