import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/toast.dart';

class Fav {
  /// adding items to favorite
  static final userFavItems =
      FirebaseFirestore.instance.collection('users-fav-items');

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final userEmail = FirebaseAuth.instance.currentUser!.email;

  static addToFav({required Product}) {
    userFavItems
        .doc(userEmail)
        .collection('itemFavs')
        .doc()
        .set({
          'Photo': Product['product-img'],
          'Name': Product['product-name'],
          'Price': Product['product-price'],
        })
        .then((value) => toast('Added to Favorite'))
        .onError((error, stackTrace) => toast(error.toString()));
  }

  /// adding items to cart from fav
  static final userCartItems =
      FirebaseFirestore.instance.collection('users-cart-items');

  static addCartFromFav({
    required Photo,
    required Name,
    required Price,
  }) {
    userCartItems
        .doc(userEmail)
        .collection('itemLists')
        .doc()
        .set({
          'Photo': Photo,
          'Name': Name,
          'Price': Price,
        })
        .then((value) => toast('Added to Cart'))
        .onError((error, stackTrace) => toast(error.toString()));
  }

  /// delete item from fav
  static deleteFromFav(getId) {
    userFavItems
        .doc(userEmail)
        .collection('itemFavs')
        .doc(getId)
        .delete()
        .then((value) => toast('Deleted'))
        .onError((error, stackTrace) => toast(error.toString()));
  }
}
