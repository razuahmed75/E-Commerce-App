import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop_app/constants/my_colors.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/home/components/header.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../firebase/Auth_services.dart';
import 'components/categories.dart';
import 'components/productList.dart';
import 'components/searchBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _carouselController = CarouselController();
  int activeIndex = 0;

  @override
  void initState() {
    _searchController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// hello, user name and profile pic
                HeaderWidget(),

                /// search option
                SearchBarWidget(searchController: _searchController),

                /// product slider
                carousel_Slider(),

                /// show more
                Categories(),

                /// list of products
                ProductList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding carousel_Slider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: AspectRatio(
          aspectRatio: 2 / 1.1,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('carousel-slider')
                  .snapshots(),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(child: CircularProgressIndicator());
                // }
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      height: 110.h,
                      width: 0.85.sw,
                      color: Colors.blue.shade50,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.data != null) {
                  List urlImages = snapshot.data!.docs;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CarouselSlider.builder(
                        carouselController: _carouselController,
                        itemCount: urlImages.length,
                        options: CarouselOptions(
                          height: 110.h,
                          viewportFraction: 1,
                          autoPlay: true,
                          onPageChanged: (index, reason) =>
                              setState(() => activeIndex = index),
                        ),
                        itemBuilder: ((context, index, realIndex) {
                          final urlImage = urlImages[index]['img-path'];
                          return buildImage(urlImage);
                        }),
                      ),
                      SizedBox(height: 5.h),
                      buildIndicator(urlImages.length),
                    ],
                  );
                }

                return CircularProgressIndicator();
              })),
    );
  }

  Widget buildIndicator(imgLength) {
    return AnimatedSmoothIndicator(
        onDotClicked: (index) => _carouselController.animateToPage(index),
        activeIndex: activeIndex,
        effect: WormEffect(
          dotColor: Colors.blue.shade100,
          activeDotColor: Colors.blue.shade900,
        ),
        count: imgLength == 0 ? 1 : imgLength);
  }

  Widget buildImage(String urlImage) => ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Container(
          width: 0.85.sw,
          color: Colors.blue.shade50,
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.error, size: 40, color: black),
          ),
        ),
      );
}
