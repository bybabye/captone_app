import 'package:captone_app/providers/auth_provider.dart';

import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_button.dart';
import 'package:captone_app/widgets/custom_show_snackbar.dart';
import 'package:captone_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int indexSelected = -1;
  int status = 0;
  late double height;
  late double width;
/* 
  Các trạng thái khi mở loadding
   */
  bool _isChuamo = false;
  bool _dangtaidulieu = false;
  bool _hoanthanh = false;
  String _result = "";
  bool _status = false;
  final Map<String, TextEditingController> _controllers = {
    'gmail': TextEditingController(),
    'password': TextEditingController(),
    'userName': TextEditingController(),
    'cmnd': TextEditingController(),
  };
  late AuthencationProvider auth;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      backgroundColor: Appcolors.backgruondFirstColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios_new),
                        ),
                        Text(
                          "Sign Up",
                          style: AppStyles.h1.copyWith(color: Colors.black),
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      lbTextAndTextFormField(
                        labelText: "Gmail",
                        controller:
                            _controllers['gmail'] ?? TextEditingController(),
                        index: 0,
                      ),
                      lbTextAndTextFormField(
                        labelText: "Mật khẩu",
                        controller:
                            _controllers['password'] ?? TextEditingController(),
                        index: 1,
                        isPassword: true,
                      ),
                      lbTextAndTextFormField(
                        labelText: "Tên người dùng",
                        controller:
                            _controllers['userName'] ?? TextEditingController(),
                        index: 2,
                      ),
                      lbTextAndTextFormField(
                        labelText: "CMND",
                        controller:
                            _controllers['cmnd'] ?? TextEditingController(),
                        index: 3,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (status != 0) {
                            if (_controllers['gmail']!.text.isNotEmpty &&
                                _controllers['password']!.text.isNotEmpty &&
                                _controllers['userName']!.text.isNotEmpty &&
                                _controllers['cmnd']!.text.isNotEmpty) {
                              setState(() {
                                _isChuamo = !_isChuamo;
                                _dangtaidulieu = !_dangtaidulieu;
                              });
                              String result =
                                  await auth.signUpWithGmailAndPassword(
                                      email: _controllers['gmail']!.text,
                                      password: _controllers['password']!.text,
                                      userName: _controllers['userName']!.text,
                                      cmnd: _controllers['cmnd']!.text);
                              if (result == "User created successfully") {
                                // ignore: use_build_context_synchronously
                                _result = "Đăng ký thành công";
                                _status = !_status;
                              } else {
                                // ignore: use_build_context_synchronously
                                _result = result;
                              }
                              setState(() {
                                _dangtaidulieu = !_dangtaidulieu;
                                _hoanthanh =
                                    !_hoanthanh; // _hoanthanh da kich hoat
                                Future.delayed(const Duration(seconds: 1), () {
                                  if (mounted) {
                                    setState(() {
                                      _isChuamo = !_isChuamo;
                                      _hoanthanh = !_hoanthanh;
                                      // lúc này đã hoàn thành form
                                      _result = "";
                                    });
                                  }
                                });
                              });
                            }
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
                          text: "Đăng Ký",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

  Widget lbTextAndTextFormField(
      {required String labelText,
      required TextEditingController controller,
      required int index,
      bool isPassword = false}) {
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
          isPassword: isPassword,
        ),
      ],
    );
  }
}
