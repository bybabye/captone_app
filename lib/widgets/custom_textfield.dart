import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.index,
    required this.indexSelected,
    required this.onTap,
    this.isPassword = false,
  });
  final TextEditingController controller;
  final int indexSelected;
  final int index;
  final bool isPassword;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isCheck = !(indexSelected == index);
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.024, vertical: height * 0.024),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.024, vertical: height * 0.024),
      decoration: BoxDecoration(
        color: const Color(0xFFE7EBEF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isCheck
            ? [
                BoxShadow(
                  color: const Color(0xFFEAE7DC),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1.0,
                  inset: isCheck,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: const Color(0xFFFFFFFF).withOpacity(.6),
                  offset: const Offset(
                    -1.0,
                    -1.0,
                  ),
                  blurRadius: 3.0,
                  inset: isCheck,
                ),
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.6),
                  offset: const Offset(
                    1.0,
                    1.0,
                  ),
                  blurRadius: 3.0,
                  inset: isCheck,
                ),
                BoxShadow(
                    color: const Color(0xFFFFFFFF).withOpacity(.6),
                    offset: const Offset(
                      -5.0,
                      -5.0,
                    ),
                    blurRadius: 15.0,
                    inset: isCheck,
                    spreadRadius: 1),
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.3),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 15.0,
                  inset: isCheck,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.2),
                  offset: const Offset(
                    10.0,
                    10.0,
                  ),
                  blurRadius: 20.0,
                ),
                BoxShadow(
                  color: const Color(0xFFFFFFFF).withOpacity(.8),
                  offset: const Offset(
                    -10.0,
                    -10.0,
                  ),
                  blurRadius: 20.0,
                ),
              ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration.collapsed(hintText: ""),
        onTap: onTap,
        obscureText: isPassword,
      ),
    );
  }
}
