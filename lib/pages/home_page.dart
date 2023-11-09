import 'package:captone_app/models/home.dart';
import 'package:captone_app/pages/message_page.dart';
import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/providers/chat_provider.dart';
import 'package:captone_app/providers/notification_provider.dart';
import 'package:captone_app/providers/rental_provider.dart';
import 'package:captone_app/routers/navigation_service.dart';
import 'package:captone_app/widgets/custom_button.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_circle_button.dart';
import 'package:captone_app/widgets/custom_show_snackbar.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.home});
  final Home home;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height;
  late double width;
  late AuthencationProvider _auth;
  late ChatProvider _chat;
  late RentalProvider _rent;
  late NotificationProvider _notifi;
  // chiều dài của mảng url ảnh
  int lenImg = 0;
  // theo dõi sự kiện nhấn vào nhắn tin
  bool isLoading = false;
  // image error o day
  String error = "";
  // lấy vị trí của ảnh đang được focus
  int selectedIndex = 0;
  String? image;
  String address = "";
  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();

  // các sự kiên loading Custom snackbar
  bool _isChuamo = false;
  bool _dangtaidulieu = false;
  bool _hoanthanh = false;
  String _result = "";
  bool _status = false;

  @override
  void initState() {
    super.initState();
    lenImg = widget.home.images.length;
    image = lenImg == 0
        ? "https://nhatro.duytan.edu.vn/Content/Home/images/image_logo.jpg"
        : widget.home.images[0];
    handleAddress();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthencationProvider>(context);
    _chat = Provider.of<ChatProvider>(context);
    _rent = Provider.of<RentalProvider>(context);
    _notifi = Provider.of<NotificationProvider>(context);
    final NavigationService navigationService =
        GetIt.instance.get<NavigationService>();
    return Scaffold(
      backgroundColor: Appcolors.backgruondFirstColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : _isChuamo
              ? Center(
                  child: CustomShowSnackBar(
                    isHoanThanh: _hoanthanh,
                    isTaidulieu: _dangtaidulieu,
                    text: _result,
                    status: _status,
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(
                            height: 500,
                            width: width,
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  // CachedNetworkImage(
                                  //   imageUrl: image!,
                                  //   imageBuilder: (context, imageProvider) => Container(
                                  //     decoration: BoxDecoration(
                                  //       image: DecorationImage(
                                  //         image: imageProvider,
                                  //         fit: BoxFit.cover,
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   placeholder: (context, url) =>
                                  //       const CircularProgressIndicator(),
                                  //   errorWidget: (context, url, error) =>
                                  //       const Icon(Icons.error),
                                  // ),
                                  SizedBox(
                                    height: 500,
                                    child: Image.network(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      top: 30,
                                      left: 30,
                                      child: CustomCircleButton(
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          navigationService.goBack();
                                        },
                                      )),
                                  if (lenImg != 1)
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                          height: 100,
                                          color: Colors.black.withOpacity(
                                              0.5), // Đặt màu nền và độ trong suốt
                                          width:
                                              width, // Đặt chiều rộng của Container bằng chiều rộng của màn hình
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: lenImg, // Số lượng ảnh
                                            itemBuilder: (context, index) {
                                              // Thay thế "imageURLs" bằng danh sách URL của ảnh của bạn

                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    image = widget
                                                        .home.images[index];
                                                    selectedIndex = index;
                                                  });
                                                },
                                                child: Container(
                                                  width:
                                                      100, // Đặt kích thước của mỗi ảnh ở đây
                                                  margin: const EdgeInsets.all(
                                                      8), // Đặt khoảng cách giữa các ảnh
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: selectedIndex ==
                                                              index
                                                          ? Colors.white
                                                          : Colors
                                                              .black, // Màu sắc của viền
                                                      width: selectedIndex ==
                                                              index
                                                          ? 4.0
                                                          : 1, // Độ dày của viền
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    widget.home.images[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.all(12),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE7EBEF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              shadows: [
                                const BoxShadow(
                                  color: Color(0xCCFFFFFF),
                                  blurRadius: 30,
                                  offset: Offset(-5, -5),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color:
                                      const Color(0xFF000000).withOpacity(.2),
                                  blurRadius: 30,
                                  offset: const Offset(-5, -5),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.home.address.stress != ""
                                            ? capitalize(
                                                widget.home.address.stress)
                                            : "Đang cập nhật",
                                        style: AppStyles.h2,
                                      ),
                                      const Icon(
                                        Icons.favorite,
                                        color: Appcolors.activeIcon,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    widget.home.price != 0
                                        ? "Giá : ${widget.home.price} Triệu"
                                        : "Giá : Đang cập nhật",
                                    style: AppStyles.h2.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  handleUtilities(),
                                  Text(
                                    "Loại nhà trọ : ${widget.home.roomType}",
                                    style: AppStyles.h3,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                ],
                              ),
                            ),
                          ),
                          if (widget.home.des.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.all(12),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFE7EBEF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                shadows: [
                                  const BoxShadow(
                                    color: Color(0xCCFFFFFF),
                                    blurRadius: 30,
                                    offset: Offset(-5, -5),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color:
                                        const Color(0xFF000000).withOpacity(.2),
                                    blurRadius: 30,
                                    offset: const Offset(-5, -5),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget.home.des
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: Text(
                                              "• $e",
                                              style: AppStyles.h3,
                                            ),
                                          ))
                                      .toList()),
                            ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.all(12),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE7EBEF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              shadows: [
                                const BoxShadow(
                                  color: Color(0xCCFFFFFF),
                                  blurRadius: 30,
                                  offset: Offset(-5, -5),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color:
                                      const Color(0xFF000000).withOpacity(.2),
                                  blurRadius: 30,
                                  offset: const Offset(-5, -5),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Tên chủ nhà : ",
                                      style: AppStyles.h3,
                                    ),
                                    Text(
                                      widget.home.ownerId.userName,
                                      style: AppStyles.h3,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Số điện thoại : ",
                                      style: AppStyles.h3,
                                    ),
                                    Text(
                                      widget.home.ownerId.phoneNumber,
                                      style: AppStyles.h3,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                if (widget.home.ownerId.uid != _auth.user.uid)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _launchPhoneCall(
                                              _auth.user.phoneNumber);
                                        },
                                        child: CustomButton(
                                          isCheck: false,
                                          icon: Icon(
                                            Icons.phone,
                                            color: Colors.green[700],
                                          ),
                                          text: "Điện thoại",
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            isLoading = !isLoading;
                                          });
                                          final data = await _chat.addChat(
                                            yid: widget.home.ownerId.uid,
                                            token: _auth.idToken,
                                          );

                                          navigationService.navigateToPage(
                                            MessagePage(
                                              yId: widget.home.ownerId.uid,
                                              chatId: data!['chatId'],
                                              avatar: data['avatar'],
                                              userName: data['userName'],
                                            ),
                                          );

                                          setState(() {
                                            isLoading = !isLoading;
                                          });
                                        },
                                        child: CustomButton(
                                          isCheck: false,
                                          icon: Icon(
                                            Icons.message,
                                            color: Colors.green[700],
                                          ),
                                          text: "Nhắn tin",
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (widget.home.ownerId.uid != _auth.user.uid)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: CustomButton(
                                          isCheck: false,
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.green[700],
                                          ),
                                          text: "Ưa thích",
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            _isChuamo = !_isChuamo;
                                            _dangtaidulieu = !_dangtaidulieu;
                                          });
                                          String idRental =
                                              await _rent.addRental(
                                            idToken: _auth.idToken!,
                                            homeId: widget.home.homeId,
                                            cost: widget.home.price,
                                          );
                                          if (idRental.isNotEmpty) {
                                            print("dang thue");
                                            _result =
                                                await _notifi.addNotification(
                                              receiverId:
                                                  widget.home.ownerId.id,
                                              idToken: _auth.idToken!,
                                              content:
                                                  "${_auth.user.userName} Muốn thuê căn nhà ở ${widget.home.address.stress}",
                                              target: "rental",
                                              targetId: idRental,
                                            );

                                            if (_result ==
                                                "Đã gửi thông báo cho chủ nhà!! Hãy chờ hồi đáp nhé") {
                                              _status = !_status;
                                            }
                                          } else {
                                            _result =
                                                "Nhà đã có người thuê hoặc bạn đang thuê nhà của chủ nhà khác";
                                          }
                                          setState(() {
                                            _dangtaidulieu = !_dangtaidulieu;
                                            _hoanthanh =
                                                !_hoanthanh; // _hoanthanh da kich hoat
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              if (mounted) {
                                                setState(() {
                                                  _isChuamo = !_isChuamo;
                                                  _hoanthanh = !_hoanthanh;
                                                  _result = "";
                                                });
                                              }
                                            });
                                          });
                                        },
                                        child: CustomButton(
                                          isCheck: false,
                                          icon: Icon(
                                            Icons.add_task,
                                            color: Colors.green[700],
                                          ),
                                          text: "Thuê nhà",
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
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
      "Tiện ích : ${widget.home.utilities[0]} | $tienich",
      style: AppStyles.h3,
      maxLines: 2, // Tối đa 2 dòng
      overflow:
          TextOverflow.ellipsis, // Hiển thị dấu ba chấm khi quá nhiều dòng
    );

    return textWidget;
  }

  void _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Không thể mở ứng dụng Gọi Điện Thoại';
    }
  }
}
