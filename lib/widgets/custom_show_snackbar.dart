import 'package:captone_app/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CustomShowSnackBar extends StatelessWidget {
  const CustomShowSnackBar(
      {super.key,
      required this.isHoanThanh,
      required this.isTaidulieu,
      required this.status,
      required this.text});
  final bool isTaidulieu;
  final bool isHoanThanh;
  final bool status;
  final String text;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black.withOpacity(.15),
      alignment: Alignment.center,
      height: height,
      width: width,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            height: 150,
            width: 300,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, .1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromRGBO(255, 255, 255,
                    0.5), // Stroke color 40% white (40% của màu trắng)
                width: 3.0, // Độ dày của stroke
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isTaidulieu)
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                if (isHoanThanh)
                  Icon(
                    status ? Icons.check_circle_outline : Icons.cancel_outlined,
                    color: status ? Colors.green : Colors.red,
                  ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    text,
                    style: AppStyles.h3.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
