import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/strings.dart';
import '../utils/toast.dart';

void addEmptyFieldToDb() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser = _auth.currentUser;
  CollectionReference user = FirebaseFirestore.instance.collection('userForm');
  user
      .doc(_currentUser!.email)
      .set({
        'Name': '',
        'Phone': '',
        'Profile': avatar,
      })
      .then((_) {})
      // ignore: invalid_return_type_for_catch_error
      .catchError((onError) => toast(onError.toString()));
}
