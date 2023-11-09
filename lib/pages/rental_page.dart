import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/providers/rental_provider.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key, required this.rentalId});
  final String rentalId;
  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  late RentalProvider _rental;
  late AuthencationProvider _auth;
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthencationProvider>(context);
    _rental = Provider.of<RentalProvider>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Appcolors.backgruondFirstColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgruondFirstColor,
        automaticallyImplyLeading: true,
        title: const Text(
          "Rental",
          style: AppStyles.h1,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _rental.getRentalForId(
            idToken: _auth.idToken!, idRental: widget.rentalId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: Image.network(snapshot.data!.tenantId.avatar),
                    ),
                  ),
                  cardInfo(
                    name: snapshot.data!.tenantId.userName,
                    phone: snapshot.data!.tenantId.phoneNumber,
                    address: snapshot.data!.tenantId.address,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const CustomButton(
                            isCheck: false,
                            icon: Icon(
                              Icons.message,
                              color: Colors.green,
                            ),
                            text: "Liên hệ",
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            _rental.rentalConfirm(
                                idToken: _auth.idToken!, id: widget.rentalId);
                          },
                          child: const CustomButton(
                            isCheck: false,
                            icon: Icon(
                              Icons.add_task_sharp,
                              color: Colors.green,
                            ),
                            text: "Cho thuê",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget cardInfo(
      {required String name, required String phone, required String address}) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(12),
      width: width,
      decoration: BoxDecoration(
        color: Appcolors.backgruondFirstColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: const Color(0xFF434343).withOpacity(.25),
            offset: const Offset(3, 6),
            spreadRadius: 0,
          ),
          const BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 6,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "User Name",
              ),
              Text(name)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phone",
              ),
              if (phone.isNotEmpty) Text(phone)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Address",
              ),
              if (address.isNotEmpty) Text(address)
            ],
          ),
        ],
      ),
    );
  }
}
