import 'package:captone_app/models/home.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({super.key, required this.home, required this.favorites});
  final Home home;
  final List favorites;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool isFavorite = false;
  final String img =
      "https://nhatro.duytan.edu.vn/Content/Home/images/image_logo.jpg";
  String address = "";

  @override
  void initState() {
    super.initState();
    isFavorite = widget.favorites.contains(widget.home.homeId);

    handleAddress();
  }

  Widget handleUtilities() {
    String tienich = "";
    if (widget.home.utilities.isNotEmpty) {
      for (int i = 1; i < widget.home.utilities.length; i++) {
        tienich += widget.home.utilities[i];
        i == widget.home.utilities.length - 1
            ? tienich += "."
            : tienich += " | ";
      }
    }

    // Tạo một Text widget với nội dung tối đa 2 dòng và dấu ba chấm khi quá nhiều dòng
    final textWidget = Text(
      " ${widget.home.utilities[0]} | $tienich",
      style: AppStyles.h4,
      maxLines: 2, // Tối đa 2 dòng
      overflow:
          TextOverflow.ellipsis, // Hiển thị dấu ba chấm khi quá nhiều dòng
    );

    return textWidget;
  }

  void handleAddress() {
    if (widget.home.address.stress.isNotEmpty) {
      address += "${widget.home.address.stress} ,";
    }
    if (widget.home.address.subDistrict.isNotEmpty) {
      address += "${widget.home.address.subDistrict} ,";
    }
    if (widget.home.address.district.isNotEmpty) {
      address += "${widget.home.address.district} ,";
    }
    if (widget.home.address.city.isNotEmpty) {
      address += "${widget.home.address.city} .";
    }
    address.isEmpty ? "Đang cập nhật" : address;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFE7EBEF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0xCCFFFFFF).withOpacity(.8),
            blurRadius: 30,
            offset: const Offset(-3, -3),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.2),
            blurRadius: 30,
            offset: const Offset(3, 3),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 200,
              width: 200,
              // child: Image.network(
              //   home.images.isNotEmpty ? home.images[0] : img,
              //   fit: BoxFit.cover,
              // ),
              child: Image.network(
                  widget.home.images.isNotEmpty ? widget.home.images[0] : img),
            ),
          ),
          Text(
            widget.home.address.stress != ""
                ? widget.home.address.stress
                : "Đang cập nhật",
            style: AppStyles.h3,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(child: handleUtilities())
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.home_outlined,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  address,
                  style: AppStyles.h4,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.home.price != 0
                      ? "Giá : ${widget.home.price} Triệu"
                      : "Giá : Đang cập nhật",
                  style: AppStyles.h4.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (widget.favorites.contains(widget.home.homeId)) {
                      widget.favorites.remove(
                          widget.home.homeId); // Xóa khỏi danh sách nếu đã có
                    } else {
                      widget.favorites.add(
                        widget.home.homeId,
                      ); // Thêm vào danh sách nếu chưa có
                    }
                    isFavorite = !isFavorite;
                  });
                },
                child: Container(
                  child: isFavorite == false
                      ? const Icon(
                          Icons.favorite_border,
                          color: Appcolors.unActiveIcon,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Appcolors.activeIcon,
                        ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
