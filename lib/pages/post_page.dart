import 'dart:io';

import 'package:captone_app/firebase/firebase_storage_service.dart';
import 'package:captone_app/theme/app_colors.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_floatting_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  XFile? _image;

  bool _isLoading = false;

  final FirebaseStorageService _storage = FirebaseStorageService();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> _upload() async {
    setState(() {
      _isLoading = true;
    });
    if (_image != null) {
      _storage.uploadImageToStorage(name: "posts", file: File(_image!.path));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgruondFirstColor,
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (_image != null)
                    Image.file(File(_image!.path),
                        height: 200), // Hiển thị ảnh đã chọn
                  ElevatedButton(
                    onPressed: _pickImage, // Gọi hàm để mở kho ảnh và chọn ảnh
                    child: const Text("Chọn ảnh"),
                  ),
                  ElevatedButton(
                    onPressed: _upload, // Gọi hàm để mở kho ảnh và chọn ảnh
                    child: const Text("up ảnh"),
                  ),
                ],
              ),
            ),
    );
  }
}
