import 'package:captone_app/constants/api.dart';
import 'package:captone_app/models/rental.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RentalProvider extends ChangeNotifier {
  late final Dio dio;

  RentalProvider() {
    dio = Dio();
  }

  Future<String> addRental(
      {required String idToken,
      required String homeId,
      required double cost}) async {
    String result = "";
    Response response;
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $idToken',
      };

      response = await dio.post(Api.addRental,
          data: {'homeId': homeId, 'cost': cost, 'leasePeriod': 6},
          options: Options(headers: headers));
      final data = response.data;
      final id = data['data'];
      result = id;
    } catch (e) {
      print(e);
      result = "";
    }
    return result;
  }

  Future<Rental?> getRentalForId(
      {required String idToken, required String idRental}) async {
    try {
      Response response;
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $idToken',
      };

      response = await dio.get('${Api.getRentalForId}?rentalId=$idRental',
          options: Options(headers: headers));
      final data = response.data;

      Rental rental = Rental.fromJson(data['data']);

      return rental;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> rentalConfirm(
      {required String idToken, required String id}) async {
    try {
      Response response;
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $idToken',
      };
      response = await dio.patch('${Api.rentalConfirm}?rentalId=$id',
          options: Options(headers: headers));
    } catch (e) {
      print(e);
    }
  }
}
