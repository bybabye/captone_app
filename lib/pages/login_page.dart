import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/routers/navigation_service.dart';
import 'package:captone_app/routers/routers.dart';

import 'package:captone_app/theme/app_assets.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_button.dart';
import 'package:captone_app/widgets/custom_show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:captone_app/widgets/custom_textfield.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int indexSelected = -1;
  late double height;
  late double width;
  int status = 0;
  /* 
  Các trạng thái khi mở loadding
  */
  bool _isChuamo = false;
  bool _dangtaidulieu = false;
  bool _hoanthanh = false;
  String _result = "";
  bool _status = false;

  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthencationProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Appcolors.backgruondFirstColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 350,
                  child: Image.asset(
                    AppAssets.logo,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                lbTextAndTextFormField(
                  labelText: "Tên người dùng",
                  controller: userNameController,
                  index: 0,
                ),
                lbTextAndTextFormField(
                  labelText: "Mật khẩu",
                  controller: passwordController,
                  index: 1,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      navigationService.goPage(Routers.signUpPage);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.024, vertical: 8),
                      child: Text(
                        "Bạn chưa có tài khoản ?",
                        style: AppStyles.h3.copyWith(
                          decoration:
                              TextDecoration.underline, // Thêm đường gạch chân
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (status != 0) {
                          setState(() {
                            _isChuamo = !_isChuamo;
                            _dangtaidulieu = !_dangtaidulieu;
                          });
                          _result = await auth.signInWithGmailAndPassword(
                              email: userNameController.text,
                              password: passwordController.text);
                          if (_result == "Đăng nhập thành công") {
                            _status = !_status;
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
                      },
                      child: CustomButton(
                        isCheck: status == 0 ? true : false,
                        icon: Icon(
                          Iconsax.login,
                          color: status == 0
                              ? Appcolors.unActiveIcon
                              : Appcolors.activeIcon,
                        ),
                        text: "Login",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GoogleAuthButton(
                      onPressed: () async {
                        await auth.signInWithGoogle();
                      },
                      materialStyle: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFE7EBEF)),
                        elevation: MaterialStateProperty.all(
                            10), // Điều chỉnh độ nâng của nút
                        shadowColor: MaterialStateProperty.all(Colors.black
                            .withOpacity(0.5)), // Điều chỉnh màu của shadow
                        overlayColor: MaterialStateProperty.all(
                          Colors.white.withOpacity(0.6),
                        ), // Điều chỉnh màu overlay
                      ),
                    ),
                  ],
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
