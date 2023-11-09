import 'package:captone_app/firebase_options.dart';
import 'package:captone_app/pages/list_home_page.dart';
import 'package:captone_app/pages/login_page.dart';
import 'package:captone_app/pages/post_page.dart';
import 'package:captone_app/pages/search_page.dart';
import 'package:captone_app/pages/sign_up_page.dart';
import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/providers/chat_provider.dart';
import 'package:captone_app/providers/notification_provider.dart';
import 'package:captone_app/providers/rental_provider.dart';
import 'package:captone_app/providers/room_provider.dart';
import 'package:captone_app/providers/socket_provider.dart';
import 'package:captone_app/providers/user_provider.dart';
import 'package:captone_app/routers/navigation_service.dart';
import 'package:captone_app/routers/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NavigationService().setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) {
          return AuthencationProvider();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return SocketIOProvider();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return RoomProvider();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return UserProvider();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return ChatProvider();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return NotificationProvider();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return RentalProvider();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: locator<NavigationService>().navigatorKey,
        initialRoute: Routers.loginPage,
        routes: {
          Routers.loginPage: (context) => const LoginPage(),
          Routers.homePage: (context) => const ListHomePage(),
          Routers.searchPage: (context) => const SearchPage(),
          Routers.postPage: (context) => const PostPage(),
          Routers.signUpPage: (context) => const SignUpPage(),
        },
      ),
    );
  }
}
