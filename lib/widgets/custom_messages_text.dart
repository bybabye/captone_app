import 'package:captone_app/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomMessageText extends StatelessWidget {
  const CustomMessageText({
    super.key,
    required this.isUser,
    required this.avatar,
    required this.time,
    required this.text,
  });
  final bool isUser;
  final String text;
  final String time;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isUser)
              CircleAvatar(
                backgroundImage: NetworkImage(avatar),
                radius: 20,
              ),
            Flexible(
              child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isUser ? Colors.black : Colors.grey),
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: AppStyles.h2.copyWith(
                            color: isUser ? Colors.white : Colors.black),
                      ),
                      Text(time,
                          style: AppStyles.h4.copyWith(
                              color: isUser ? Colors.grey : Colors.black))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
