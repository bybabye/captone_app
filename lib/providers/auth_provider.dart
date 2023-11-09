import 'dart:async';

import 'package:captone_app/constants/api.dart';
import 'package:captone_app/models/user_app.dart';

import 'package:captone_app/pages/login_page.dart';
import 'package:captone_app/routers/navigation_service.dart';
import 'package:captone_app/routers/routers.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class AuthencationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;

  String? idToken;
  String? tokenAppCheck;
  late UserApp user;
  late final NavigationService navigationService;
  // biến này để kiểm soát người dùng đang đăng ký

  Dio dio = Dio();
  AuthencationProvider() {
    navigationService = GetIt.instance.get<NavigationService>();

    _auth = FirebaseAuth.instance;

    // ignore: no_leading_underscores_for_local_identifiers
    _auth.authStateChanges().listen((_user) async {
      if (_user != null) {
        // Thiết lập một timer để làm mới ID Token sau mỗi 30 phút
        idToken = await _user.getIdToken();
        print(idToken);

        userFunction();
      } else {
        idToken = null;
      }
    });
  }
  // hàm gọi user khi app lắng nghe được uid .

  Future<void> userFunction() async {
    Response response;
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $idToken',
      };
      // sẽ trả về 1 json {uid : "", userName : ""}
      response = await dio.post(Api.login,
          data: {'uid': _auth.currentUser!.uid},
          options: Options(headers: headers));

      final data = response.data;
      print(data);
      //convert từ data => Sang User
      user = UserApp.fromJson(data);
      navigationService.goPage(Routers.homePage);
    } catch (e) {
      // ignore: avoid_print
      print("dong 49 for Auth : $e");
      await _auth.signOut();
    }
  }

  Future<String> signInWithGmailAndPassword(
      {required String email, required String password}) async {
    // tạo biến result để kiểm soát thông báo hàm trả về
    String result = "";
    try {
      // gọi tới hàm signIn của firebase để kiểm tra đăng nhập
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      result = "Đăng nhập thành công";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = "tài khoản chưa tồn tại";
      } else if (e.code == 'wrong-password') {
        result = "sai mật khẩu";
      } else {
        result = "Lỗi đăng nhập";
      }
    } catch (e) {
      result = "Lỗi đăng nhập";
    }
    return result;
  }

  Future<String> signUpWithGmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String cmnd,
  }) async {
    // tạo biến result để kiểm soát thông báo hàm trả về
    String result = "";
    // cờ theo dõi request quá lâu .
    bool success = false;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // tạo 1 data để đẩy lên server
      Map<String, dynamic> data = {
        "uid": credential.user!.uid,
        "userName": userName,
        "cmnd": cmnd,
        "avatar":
            "https://firebasestorage.googleapis.com/v0/b/captone1-3fba1.appspot.com/o/avatar%2F848043-removebg-preview.png?alt=media&token=6ae10d99-498d-49aa-af94-d848194f0227&_gl=1*88td7o*_ga*MjEyMjQzOTQ1LjE2NzcwODM3NjA.*_ga_CW55HF8NVT*MTY5Njg4MzkwMy40My4xLjE2OTY4ODQ2MTUuNTQuMC4w",
      };
      // nếu api gọi quá 10s thì sẽ tự ngắt.
      // nếu thành công thì cờ sẽ được set true và không chạy vào điều kiện if bên dưới
      if (credential.user != null) {
        Response response;

        response = await dio
            .post(Api.signUp, data: data)
            .timeout(const Duration(seconds: 10));
        result = await response.data['message'];

        success = true;
      }

      if (!success && credential.user != null) {
        // trường hợp này authen từ firebase đã có tài khoản nhưng database lại chưa có dữ liệu phải xoá để người dùng đăng ký lại
        result = "Lỗi Từ Hệ thống";
        credential.user!.delete();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result = "Mật khẩu yếu";
      } else if (e.code == 'email-already-in-use') {
        result = "Email đã tồn tại";
      }
    } catch (e) {
      result = e.toString();
    }

    // ignore: avoid_print
    print("alo alo $result");
    return result;
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Check if the user canceled or didn't select an account
    if (googleUser == null) {
      // Handle the case where the user canceled or didn't select an account
      throw Exception(
          'User canceled Google Sign-In'); // Throwing a custom exception
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Check if googleAuth is null (e.g., if the user didn't complete the sign-in process)
    // ignore: unnecessary_null_comparison
    if (googleAuth == null) {
      // Handle the case where googleAuth is null
      throw Exception(
          'Google Sign-In authentication failed'); // Throwing a custom exception
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    String result;

    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (user.user != null) {
      Map<String, dynamic> data = {
        'userName': user.user!.displayName,
        'avatar': user.user!.photoURL,
        'uid': user.user!.uid,
        'cmnd': const Uuid().v4()
      };
      Response response;
      response = await dio.post(Api.signUp, data: data);
      result = await response.data['message'];
      // ignore: avoid_print
      print(result);
    }

    // Once signed in, return the UserCredential
    return user;
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    navigationService.goToPageAndRemoveAllRoutes(const LoginPage());
  }
}
