import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.mainColor = const Color(0xFFF37878),
      this.subColor = const Color(0xFFFFBEBE),
      this.isSecret = false,
      this.isContents = false,
      this.hint = "",
      this.onChange,
      this.controller,
      this.initValue = ""})
      : super(key: key);

  final Color mainColor;
  final Color subColor;
  final bool isContents;
  final bool isSecret;
  final String hint;
  final ValueChanged? onChange;
  final TextEditingController? controller;
  final String? initValue;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  double minHeight = 0;
  int? maxLines = 1;

  @override
  initState() {
    super.initState();
    if (widget.isContents) {
      minHeight = 230;
      maxLines = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: "${widget.initValue}");
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
          border: Border.all(color: widget.mainColor, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: widget.subColor),
      child: TextField(
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            border: InputBorder.none,
            hintText: widget.hint),
        cursorColor: widget.mainColor,
        maxLines: maxLines,
        onChanged: widget.onChange,
        controller: controller,
        obscureText: widget.isSecret,
      ),
    );
  }
}
