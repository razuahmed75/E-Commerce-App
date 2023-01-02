import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/ui/search_page/search_page.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    required TextEditingController searchController,
  })  : _searchController = searchController,
        super(key: key);

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 0.85.sw,
            child: TextFormField(
              readOnly: true,
              onTap: () => Get.to(() => SearchPage()),
              controller: _searchController,
              style: GoogleFonts.actor(letterSpacing: 0.7.sp),
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 11, horizontal: 25).r,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => _searchController.clear(),
                        icon: _searchController.text.isEmpty
                            ? Container(width: 0)
                            : Icon(Icons.close)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40).w,
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.blue.shade50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
