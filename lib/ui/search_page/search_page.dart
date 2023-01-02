import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/ui/details_page/details_page.dart';
import '../../constants/my_colors.dart';
import 'components/search_textfield.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _node = FocusNode();
  final _searchController = TextEditingController();
  String inputText = '';

  @override
  void initState() {
    _searchController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// search textfield
              querySearchBar(),

              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .snapshots(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.active ||
                          snapshot.data != null) {
                        List queryProducts = snapshot.data!.docs;
                        return ListView.builder(
                            itemCount: queryProducts.length,
                            itemBuilder: ((context, index) {
                              var productName =
                                  queryProducts[index]['product-name'];
                              if (inputText.isEmpty) {
                                return Container();
                              }
                              if (productName
                                      .toLowerCase()
                                      .startsWith(inputText.toLowerCase()) ||
                                  productName
                                      .toLowerCase()
                                      .contains(inputText.toLowerCase())) {
                                return productTile(
                                    context, queryProducts, index);
                              }

                              return Container();
                            }));
                      }
                      return Center(child: CircularProgressIndicator());
                    })),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// build methods ==========================
  GestureDetector productTile(
      BuildContext context, List<dynamic> queryProducts, int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => DetailsScreen(
                    Product: queryProducts[index],
                    tag: queryProducts[index],
                  ))),
      child: Card(
        child: ListTile(
          leading: Image.network(queryProducts[index]['product-img'][0]),
          title: Text(queryProducts[index]['product-name']),
        ),
      ),
    );
  }

  Padding querySearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
          SizedBox(
              width: 0.7.sw,
              height: 30.h,
              child: SearchField(
                autofocus: true,
                controller: _searchController,
                hintText: 'Search',
                onEditingComplete: () => _node.requestFocus(),
                onChanged: (value) => setState(() => inputText = value),
              )),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                right: 12,
              ).r,
              child: Text(
                'SEARCH',
                style: GoogleFonts.actor(color: kColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
