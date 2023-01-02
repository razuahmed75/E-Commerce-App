import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_app/logic/profile_manager.dart';
import 'package:provider/provider.dart';
import '../../../../constants/svg/svg.dart';
import 'custom_loader.dart';
import 'listTileModel.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Consumer<ProfileManager>(builder: (context, provider, child) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('userForm')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CustomTileLoader();
            }

            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.data != null) {
              var data = snapshot.data;
              return Column(
                children: [
                  myListTile(
                    onTap: () {
                      provider.updateUserInfoDialog(
                        context: context,
                        UserInfo: data['Name'],
                        User: 'Name',
                      );
                    },
                    leading: kPerson,
                    title: 'Username',
                    trailing: data!['Name'] == '' || data['Name'] == null
                        ? 'xxx-xxx-xxx'
                        : data['Name'],
                    iconColor: Colors.grey.shade600,
                  ),
                  myListTile(
                    onTap: () {
                      provider.updateUserInfoDialog(
                        context: context,
                        UserInfo: data['Phone'],
                        User: 'Phone',
                      );
                    },
                    leading: kCall,
                    title: 'Phone',
                    trailing: data['Phone'] == '' || data['Phone'] == null
                        ? 'xxx-xxx-xxx'
                        : data['Phone'],
                    iconColor: Colors.grey.shade600,
                  ),
                  myListTile(
                    leading: kEmail,
                    title: 'Email',
                    trailing: auth.currentUser!.email.toString(),
                    iconColor: Colors.transparent,
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          });
    });
  }
}
