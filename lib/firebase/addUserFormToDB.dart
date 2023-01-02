// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/strings.dart';
import '../ui/bottom_nav_pages/bottomNav_controller.dart';
import '../utils/toast.dart';

void addUserFormToDb({
  required nameController,
  required phoneController,
  required ageController,
  required dobController,
  required genderControler,
  required context,
}) {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser = _auth.currentUser;
  CollectionReference user = FirebaseFirestore.instance.collection('userForm');
  user.doc(_currentUser!.email).set({
    'Name': nameController.text.trim(),
    'Phone': phoneController.text.trim(),
    'Age': ageController.text.trim(),
    'Date of birth': dobController.text.trim(),
    'Gender': genderControler.text.trim(),
    'Profile': avatar,
  }).then((_) {
    nameController.clear();
    phoneController.clear();
    ageController.clear();
    dobController.clear();
    genderControler.clear();

    FocusScope.of(context).unfocus();

    toast('Successfully submited');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => BottomNavPage()));
  }).catchError((onError) => toast(onError.toString()));
}
