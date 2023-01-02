import 'package:flutter/material.dart';
import 'package:online_shop_app/constants/my_colors.dart';
import 'package:online_shop_app/constants/svg/svg.dart';

import 'listTileModel.dart';

class CustomTileLoader extends StatelessWidget {
  const CustomTileLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myListTile(
          leading: kPerson,
          title: '',
          trailing: '',
        ),
        myListTile(
          leading: kCall,
          title: '',
          trailing: '',
        ),
        myListTile(
          leading: kEmail,
          title: '',
          trailing: '',
          iconColor: white,
        ),
      ],
    );
  }
}
