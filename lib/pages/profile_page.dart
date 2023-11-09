import 'package:captone_app/pages/list_home_page.dart';
import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/providers/user_provider.dart';
import 'package:captone_app/routers/navigation_service.dart';

import 'package:captone_app/widgets/custom_button.dart';
import 'package:captone_app/widgets/custom_floatting_button.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_show_snackbar.dart';
import 'package:captone_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double height;
  late double width;
  late AuthencationProvider _auth;
  late UserProvider _userProvider;
  String messages = "";
  String imgUser =
      "https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png";
  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();

  /* 
  Các trạng thái khi mở loadding
  */
  bool _isChuamo = false;
  bool _dangtaidulieu = false;
  bool _hoanthanh = false;
  String _result = "";
  bool _status = false;

  final Map<String, TextEditingController> _controllers = {
    'userName': TextEditingController(),
    'address': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'fullName': TextEditingController(),
    'no': TextEditingController(),
    'sex': TextEditingController(),
    'placeOfOrigin': TextEditingController(),
    'dateOfBirth': TextEditingController(),
    'placeOfResidence': TextEditingController(),
  };
  int indexSelected = -1;
  //
  int status = 0; // xem trạng thái người dùng đã đụng vào bất cứ gì hay chưa
  @override
  void initState() {
    super.initState();
    _auth = Provider.of<AuthencationProvider>(context, listen: false);

    _controllers['userName']?.text = _auth.user.userName;
    _controllers['address']?.text = _auth.user.address;
    _controllers['phoneNumber']?.text = _auth.user.phoneNumber;
    _controllers['fullName']?.text = _auth.user.cID.fullName;
    _controllers['no']?.text = _auth.user.cID.no;
    _controllers['sex']?.text = _auth.user.cID.sex;
    _controllers['placeOfOrigin']?.text = _auth.user.cID.placeOfOrigin;
    // dateOfBirth
    _controllers['placeOfResidence']?.text = _auth.user.cID.placeOfResidence;
  }

  //get value obj
  void getObjFormAndSendServer() async {
    Map<String, String> values = {};
    _controllers.forEach((key, controller) {
      values[key] = controller.text;
    });
    setState(() {
      _isChuamo = !_isChuamo;
      _dangtaidulieu = !_dangtaidulieu;
    });
    try {
      String result = await _userProvider.updateProfile(
        values,
        _auth.idToken!,
      );
      if (result == "Updated profile successfully") {
        // ignore: use_build_context_synchronously
        _result = result;
        _status = !_status;
        await _auth.userFunction();
        navigationService.goToPageAndRemoveAllRoutes(const ListHomePage());
      } else {
        // ignore: use_build_context_synchronously
        _result = result;
      }
    } catch (e) {
      _result = e.toString();
    }
    setState(() {
      _dangtaidulieu = !_dangtaidulieu;
      _hoanthanh = !_hoanthanh; // _hoanthanh da kich hoat
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isChuamo = !_isChuamo;
            _hoanthanh = !_hoanthanh;
            _result = "";
          });
        }
      });
    });
  }

  // dua vao 1 cai selectedIndex va 1 cai index trong field de chuyen
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthencationProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButton: const CustomFloatingButton(),
      backgroundColor: Appcolors.backgruondFirstColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    AvatarProfile(),
                    lbTextAndTextFormField(
                      labelText: "Tên người dùng",
                      controller:
                          _controllers['userName'] ?? TextEditingController(),
                      index: 0,
                    ),
                    lbTextAndTextFormField(
                      labelText: "Địa chỉ",
                      controller:
                          _controllers['address'] ?? TextEditingController(),
                      index: 1,
                    ),
                    lbTextAndTextFormField(
                      labelText: "Số điện thoại",
                      controller: _controllers['phoneNumber'] ??
                          TextEditingController(),
                      index: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.024,
                      ),
                      child: Text(
                        "Cid",
                        style: AppStyles.h2.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          lbTextAndTextFormField(
                            labelText: "Full Name",
                            controller: _controllers['fullName'] ??
                                TextEditingController(),
                            index: 3,
                          ),
                          lbTextAndTextFormField(
                            labelText: "No",
                            controller:
                                _controllers['no'] ?? TextEditingController(),
                            index: 4,
                          ),
                          lbTextAndTextFormField(
                            labelText: "Sex",
                            controller:
                                _controllers['sex'] ?? TextEditingController(),
                            index: 5,
                          ),
                          lbTextAndTextFormField(
                            labelText: "Place Of Origin",
                            controller: _controllers['placeOfOrigin'] ??
                                TextEditingController(),
                            index: 6,
                          ),
                          lbTextAndTextFormField(
                            labelText: "Date Of Birth",
                            controller: _controllers['dateOfBirth'] ??
                                TextEditingController(),
                            index: 7,
                          ),
                          lbTextAndTextFormField(
                            labelText: "Place Of Residence",
                            controller: _controllers['placeOfResidence'] ??
                                TextEditingController(),
                            index: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (status != 0) {
                              getObjFormAndSendServer();
                            }
                          },
                          child: CustomButton(
                            isCheck: status == 0 ? true : false,
                            icon: Icon(
                              Icons.update,
                              color: status == 0
                                  ? Appcolors.unActiveIcon
                                  : Appcolors.activeIcon,
                            ),
                            text: "Update",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isChuamo)
            CustomShowSnackBar(
              isHoanThanh: _hoanthanh,
              isTaidulieu: _dangtaidulieu,
              text: _result,
              status: _status,
            ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AvatarProfile() {
    return SizedBox(
      height: height * 0.3,
      width: width,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              padding: const EdgeInsets.only(top: 36),
              height: height * 0.231,
              width: width,
              color: const Color(0xffff8d76),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Edit Profile",
                    style: AppStyles.h2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: height * (-0.147),
            child: Center(
              child: CircleAvatar(
                radius: height * 0.08,
                backgroundColor: Appcolors.backgruondFirstColor,
                child: CircleAvatar(
                  radius: height * 0.074,
                  backgroundImage: NetworkImage(
                      _auth.user.avatar.isEmpty ? imgUser : _auth.user.avatar),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lbTextAndTextFormField({
    required String labelText,
    required TextEditingController controller,
    required int index,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.024,
          ),
          child: Text(
            labelText,
            style: AppStyles.h3
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        CustomTextField(
          controller: controller,
          index: index,
          indexSelected: indexSelected,
          onTap: () {
            setState(() {
              indexSelected = index;
              status = 1;
            });
          },
        ),
      ],
    );
  }
}
