import 'package:captone_app/models/user_app.dart';
import 'package:captone_app/pages/chat_page.dart';
import 'package:captone_app/pages/list_home_page.dart';
import 'package:captone_app/pages/notification_page.dart';

import 'package:captone_app/pages/post_page.dart';
import 'package:captone_app/pages/profile_page.dart';
import 'package:captone_app/pages/search_page.dart';
import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/routers/navigation_service.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService =
        GetIt.instance.get<NavigationService>();
    final auth = Provider.of<AuthencationProvider>(context);

    return FabCircularMenuPlus(
      fabOpenIcon: const Icon(Icons.menu, color: Appcolors.textColor),
      ringColor: Colors.black.withOpacity(.4),
      fabCloseIcon: const Icon(Icons.close, color: Appcolors.unActiveIcon),
      fabColor: Appcolors.backgruondSecondColor,
      fabMargin: const EdgeInsets.all(16.0),
      fabSize: 64.0,
      children: [
        IconButton(
            icon: const Icon(
              Iconsax.home,
              color: Colors.white,
            ),
            iconSize: 32,
            onPressed: () {
              navigationService
                  .goToPageAndRemoveAllRoutes(const ListHomePage());
            }),
        IconButton(
          icon: const Icon(
            Iconsax.search_zoom_in,
            color: Colors.white,
          ),
          iconSize: 32,
          onPressed: () {
            navigationService.goToPageAndRemoveAllRoutes(const SearchPage());
          },
        ),
        IconButton(
          icon: const Icon(
            Iconsax.message,
            color: Colors.white,
          ),
          iconSize: 32,
          onPressed: () {
            navigationService.goToPageAndRemoveAllRoutes(const ChatPage());
          },
        ),
        // ignore: unrelated_type_equality_checks

        if (auth.user.roles == Roles.host)
          IconButton(
            onPressed: () {
              navigationService.goToPageAndRemoveAllRoutes(const PostPage());
            },
            icon: const Icon(
              Iconsax.add_circle,
              color: Colors.white,
            ),
            iconSize: 32,
          ),
        IconButton(
          icon: const Icon(
            Iconsax.user_edit,
            color: Colors.white,
          ),
          iconSize: 32,
          onPressed: () {
            navigationService.goToPageAndRemoveAllRoutes(const ProfilePage());
          },
        ),
        IconButton(
          icon: const Icon(
            Iconsax.notification,
            color: Colors.white,
          ),
          iconSize: 32,
          onPressed: () {
            navigationService
                .goToPageAndRemoveAllRoutes(const NotificationPage());
          },
        ),
        IconButton(
          icon: const Icon(
            Iconsax.logout,
            color: Colors.white,
          ),
          iconSize: 32,
          onPressed: () async {
            await auth.logout();
          },
        ),
      ],
    );
  }
}
