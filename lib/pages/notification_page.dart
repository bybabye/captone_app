import 'package:captone_app/pages/rental_page.dart';
import 'package:captone_app/routers/navigation_service.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/providers/notification_provider.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_floatting_button.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late NotificationProvider _notifi;
  late AuthencationProvider _auth;
  late double height;
  late double width;
  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();
  String convertTimeToAgo(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    // ignore: unused_local_variable
    DateTime now = DateTime.now();

    const locale = 'vi'; // Chọn ngôn ngữ bạn muốn sử dụng, ở đây là tiếng Việt

    return timeago.format(dateTime, locale: locale);
  }

  @override
  Widget build(BuildContext context) {
    _notifi = Provider.of<NotificationProvider>(context);
    _auth = Provider.of<AuthencationProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: const CustomFloatingButton(),
      appBar: AppBar(
        backgroundColor: Appcolors.backgruondFirstColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "Thông báo",
          style: AppStyles.h1,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _notifi.listNotification(_auth.idToken),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await _notifi.readNotification(
                      idToken: _auth.idToken!,
                      idNotification: snapshot.data![index].id,
                    );
                    navigationService.navigateToPage(
                      RentalPage(
                        rentalId: snapshot.data![index].targetId,
                      ),
                    );
                  },
                  child: itemNotification(
                    read: snapshot.data![index].read,
                    url: snapshot.data![index].senderId.avatar,
                    content: snapshot.data![index].content,
                    time: snapshot.data![index].createdAt,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget itemNotification(
      {required bool read,
      required String url,
      required String content,
      required String time}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE7EBEF),
        borderRadius: BorderRadius.circular(4),
        boxShadow: read
            ? [
                BoxShadow(
                  color: const Color(0xFFEAE7DC),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 1.0,
                  inset: read,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: const Color(0xFFFFFFFF).withOpacity(.6),
                  offset: const Offset(
                    -1.0,
                    -1.0,
                  ),
                  blurRadius: 3.0,
                  inset: read,
                ),
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.6),
                  offset: const Offset(
                    1.0,
                    1.0,
                  ),
                  blurRadius: 3.0,
                  inset: read,
                ),
                BoxShadow(
                    color: const Color(0xFFFFFFFF).withOpacity(.6),
                    offset: const Offset(
                      -5.0,
                      -5.0,
                    ),
                    blurRadius: 15.0,
                    inset: read,
                    spreadRadius: 1),
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.3),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 15.0,
                  inset: read,
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
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(url),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  content,
                  maxLines: 2,
                  style: AppStyles.h3.copyWith(
                    color: Colors.black,
                    fontWeight: !read ? FontWeight.bold : FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  convertTimeToAgo(time),
                  style: AppStyles.h4.copyWith(color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
