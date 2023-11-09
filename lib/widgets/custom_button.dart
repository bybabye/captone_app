import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.isCheck,
      required this.icon,
      required this.text,
      this.width = 140});
  final bool isCheck;
  final String text;
  final Icon icon;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFFE7EBEF),
          borderRadius: BorderRadius.circular(50),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(
              text,
              style: AppStyles.h3.copyWith(
                  color:
                      !isCheck ? Appcolors.activeIcon : Appcolors.unActiveIcon),
            )
          ],
        ));
  }
}
