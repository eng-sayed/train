import 'package:flutter/material.dart';

class TextField2 extends StatefulWidget {
  String? label, hint;
  TextEditingController? controller;
  String? Function(String?)? valid;
  TextInputType? textInputType;
  Widget? sufixIcon;
  TextField2(
      {Key? key,
      required this.controller,
      required this.valid,
      required this.textInputType,
      required this.hint,
      required this.label,
      this.sufixIcon})
      : super(key: key);

  @override
  State<TextField2> createState() => _TextField2State();
}

class _TextField2State extends State<TextField2> {
  bool? isPass, secure;
  @override
  void initState() {
    // TODO: implement initState

    if (widget.textInputType == TextInputType.visiblePassword) {
      isPass = true;
    } else {
      isPass = false;
    }
    secure = isPass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.valid,
        keyboardType: widget.textInputType,
        obscureText: secure!,
        decoration: InputDecoration(
            hintText: widget.hint,
            border: OutlineInputBorder(),
            label: Text(widget.label!),
            suffixIcon: isPass!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        secure = !secure!;
                      });
                    },
                    icon: Icon(Icons.visibility))
                : widget.sufixIcon),
      ),
    );
  }
}
