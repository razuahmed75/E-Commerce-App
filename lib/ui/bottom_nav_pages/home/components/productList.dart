import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop_app/ui/details_page/details_page.dart';
import 'shimmar_loading.dart';
import 'eshop_item_tile.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 335.h,

        /// the product list is fixed , then renderflow error will be occured
      ),
      // height: 335.h, // sized box height
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return Skeleton();
            }

            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.data != null) {
              List products = snapshot.data!.docs;
              return GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(12.0).w,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 1.5,
                ),
                itemBuilder: ((context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => DetailsScreen(
                                    Product: products[index],
                                    tag: products[index],
                                  ))),
                      child: Hero(
                        tag: products[index],
                        child: EshopItemTile(
                          itemPath: products[index]['product-img'][0],
                          itemName: products[index]['product-name'],
                          itemPrice: products[index]['product-price'],
                        ),
                      ),
                    )),
              );
            }
            return Text('Something went wrong');
          })),
    );
  }
}
