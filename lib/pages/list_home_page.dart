import 'package:captone_app/models/home.dart';
import 'package:captone_app/widgets/custom_floatting_button.dart';
import 'package:captone_app/widgets/home_card.dart';

import 'package:captone_app/pages/home_page.dart';

import 'package:captone_app/providers/room_provider.dart';
import 'package:captone_app/routers/navigation_service.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ListHomePage extends StatefulWidget {
  const ListHomePage({super.key});

  @override
  State<ListHomePage> createState() => _ListHomePageState();
}

class _ListHomePageState extends State<ListHomePage> {
  List favorites = ["64fec5432cd31a07815c0acc"];
  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    return Scaffold(
      floatingActionButton: const CustomFloatingButton(),
      appBar: AppBar(
        backgroundColor: Appcolors.backgruondFirstColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "IHMLMarket",
          style: AppStyles.h1,
        ),
        centerTitle: true,
      ),
      body: roomProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Appcolors.backgruondFirstColor, // Màu nền thứ 1
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Appcolors.backgruondSecondColor
                      .withOpacity(.2), // Màu nền thứ 1
                ),
                CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              childAspectRatio: .43

                              // Tỉ lệ giữa chiều rộng và chiều cao của mỗi ô
                              ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Home home = roomProvider.homes![index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 6),
                            child: InkWell(
                              onTap: () {
                                navigationService
                                    .navigateToPage(HomePage(home: home));
                              },
                              child: HomeCard(
                                home: home,
                                // favorites: auth.user.roomfavorites,
                                favorites: favorites,
                              ),
                            ),
                          );
                        },
                        childCount: roomProvider.homes!.length,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
