import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shop_app/utils/inputText_field.dart';
import 'package:online_shop_app/utils/toast.dart';

class ProfileManager extends ChangeNotifier {
  /// loader
  get isLoading => _isLoading;

  bool _isLoading = false;

  setLoding(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// imagePicker
  dynamic get image => _image;

  var _image;

  /// from camera
  Future imagePickerFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      this._image = image.path;
      uploadImage();
      notifyListeners();
    }
  }

  /// from gallery
  Future imagePickerFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image != null) {
      this._image = image.path;
      uploadImage();
      notifyListeners();
    }
  }

  /// bottomSheet
  void showBottomSheet({
    required BuildContext context,
  }) {
    // var controller = ScrollController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        elevation: 15,
        context: context,
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            expand: false,
            snap: true,
            builder: (_, controller) => SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      Icon(Icons.remove),
                      ListTile(
                        onTap: () {
                          imagePickerFromGallery();
                          Get.back();
                        },
                        leading: Icon(Icons.collections),
                        title: Text("Open Gallery"),
                      ),
                      ListTile(
                        onTap: () {
                          imagePickerFromCamera();
                          Get.back();
                        },
                        leading: Icon(Icons.camera),
                        title: Text("Open Camera"),
                      ),
                    ],
                  ),
                )));
  }

  /// upload image to firebase storage
  var getDownloadUrl;

  uploadImage() async {
    setLoding(true);
    Reference reference = FirebaseStorage.instance.ref();
    Reference imageDirectory = reference.child('images');
    var imageUniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference imageName =
        imageDirectory.child('${auth.currentUser!.email}' + imageUniqueName);
    try {
      await imageName.putFile(File(_image));
      getDownloadUrl = await imageName.getDownloadURL();
      uploadImageToUserFrom();
    } catch (e) {
      throw Exception('something went wrong');
    }
    notifyListeners();
  }

  /// upload image link into userFrom
  final user = FirebaseFirestore.instance.collection('userForm');
  final FirebaseAuth auth = FirebaseAuth.instance;

  uploadImageToUserFrom() {
    user.doc(auth.currentUser!.email).update({
      'Profile': getDownloadUrl.toString(),
    }).then((value) {
      toast('Profile updated');
      setLoding(false);
      _image = null;
    }).onError((error, stackTrace) {
      toast(error.toString());
      setLoding(false);
    });
    notifyListeners();
  }

  /// updateUserInfo
  final controller = TextEditingController();
  final focusNode = FocusNode();

  updateUserInfoDialog({
    required BuildContext context,
    required UserInfo,
    required User,
  }) {
    controller.text = UserInfo;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text('Update $User')),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text('Do you want to update $User?'),
              SizedBox(height: 20.h),
              InputTextField(
                controller: controller,
                focusNode: focusNode,
                autoFocus: true,
                onEditingComplete: () => focusNode.requestFocus(),
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: Icon(Icons.close)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () {
                updateUserForm(User);
                Get.back();
              },
              child: Text('Update')),
        ],
      ),
    );
  }

  /// updateUserForm
  updateUserForm(User) {
    user
        .doc(auth.currentUser!.email)
        .update({
          User: controller.text,
        })
        .then((value) => toast('Successfully updated'))
        .onError((error, stackTrace) => toast(error.toString()));
  }
}
