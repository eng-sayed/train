import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  TextInputType keyboardType;
  Widget? suffixIcon, prifix;
  TextEditingController controller;
  String label;
  String? Function(String?) validate;
  MyTextField(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      required this.label,
      this.suffixIcon,
      required this.validate,
      this.prifix})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool? isPass;
  bool? visible;
  @override
  void initState() {
    isPass =
        widget.keyboardType == TextInputType.visiblePassword ? true : false;
    visible = isPass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: visible!,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: widget.prifix,
        // suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(),
        label: Text(widget.label),
        suffixIcon: widget.suffixIcon ??
            (isPass!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        visible = !visible!;
                      });
                    },
                    icon: Icon(
                      visible! ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                  )
                : widget.suffixIcon),
      ),
      validator: widget.validate,
    );
  }
}
