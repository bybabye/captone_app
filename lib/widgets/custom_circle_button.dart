import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton(
      {super.key, required this.icon, required this.onPressed});
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Hành động khi người dùng nhấn vào
      child: Container(
        width: 48.0, // Độ rộng của biểu tượng tròn
        height: 48.0, // Chiều cao của biểu tượng tròn
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Đặt hình dạng của container thành hình tròn
          color: Colors.black.withOpacity(.5), // Màu nền của biểu tượng tròn
        ),
        child: icon,
      ),
    );
  }
}
