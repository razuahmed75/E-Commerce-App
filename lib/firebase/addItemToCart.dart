import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shop_app/utils/toast.dart';

class Cart {
  /// adding items to cart
  static final userCartItems =
      FirebaseFirestore.instance.collection('users-cart-items');

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final userEmail = FirebaseAuth.instance.currentUser!.email;

  static addToCart({required Product}) {
    userCartItems
        .doc(userEmail)
        .collection('itemLists')
        .doc()
        .set({
          'Photo': Product['product-img'],
          'Name': Product['product-name'],
          'Price': Product['product-price'],
        })
        .then((value) => toast('Added to Cart'))
        .onError((error, stackTrace) => toast(error.toString()));
  }

  /// adding items to favorite from cart
  static final userFavItems =
      FirebaseFirestore.instance.collection('users-fav-items');

  static addFavFromCart({
    required Photo,
    required Name,
    required Price,
  }) {
    userFavItems
        .doc(userEmail)
        .collection('itemFavs')
        .doc()
        .set({
          'Photo': Photo,
          'Name': Name,
          'Price': Price,
        })
        .then((value) => toast('Added to Favorite'))
        .onError((error, stackTrace) => toast(error.toString()));
  }

  /// delete item from cart
  static deleteFromCart(getId) {
    userCartItems
        .doc(userEmail)
        .collection('itemLists')
        .doc(getId)
        .delete()
        .then((value) => toast('Deleted'))
        .onError((error, stackTrace) => toast(error.toString()));
  }
}
