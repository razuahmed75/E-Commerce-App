import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constants/my_colors.dart';
import '../product_preview_screen.dart';

class ProductSlider extends StatefulWidget {
  final CarouselController carouselController;
  final urlImages;
  final imageTag;

  const ProductSlider({
    super.key,
    required this.carouselController,
    required this.urlImages,
    required this.imageTag,
  });

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            carouselController: widget.carouselController,
            itemCount: widget.urlImages.length,
            options: CarouselOptions(
              height: 210.h,
              viewportFraction: 1,
              autoPlay: false,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
            itemBuilder: ((context, index, realIndex) {
              final urlImage = widget.urlImages[index];
              return GestureDetector(
                  onTap: () => Get.to(() => ProductPreview(), arguments: [
                        {'image': urlImage}
                      ]),
                  child: buildImage(urlImage));
            }),
          ),
          SizedBox(height: 5.h),
          buildIndicator(widget.urlImages.length),
        ],
      ),
    );
  }

  Widget buildIndicator(imgLength) => AnimatedSmoothIndicator(
      onDotClicked: (index) => widget.carouselController.animateToPage(index),
      activeIndex: activeIndex,
      effect: WormEffect(
        dotColor: Colors.blue.shade100,
        activeDotColor: Colors.blue.shade900,
      ),
      count: imgLength == 0 ? 1 : imgLength);

  Widget buildImage(String urlImage) => ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Container(
          width: 0.85.sw,
          child: Hero(
            tag: widget.imageTag,
            child: Image.network(
              urlImage,
              height: 120.h,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.error,
                size: 40,
                color: black,
              ),
            ),
          ),
        ),
      );
}
