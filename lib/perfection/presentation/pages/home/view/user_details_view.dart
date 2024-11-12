import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../data/models/user_list_model.dart';
import '../../../../data/repositories/user_list_provider.dart';
import '../../../manager/resources/color_manager.dart';
import '../../../manager/resources/styles_manager.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'userDetails'.tr(),
        style: AppTextStyles.largeTitle20,
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "selectedUserDetails".tr(),
              style: AppTextStyles.largeTitle18,
            ),
            const SizedBox(height: 18),
            FutureBuilder(
              future: ApiService.fetchUserDetails(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitRotatingCircle(
                    color: ColorManager.primary,
                    size: 50.0,
                  ));
                  ;
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final user = snapshot.data as User;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: ColorManager.grey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(user.avatar)),
                        const SizedBox(height: 16),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                color: ColorManager.offWhite),
                            child: Text("First Name: ${user.firstName}",style: AppTextStyles.mediumTitle14)),
                        const SizedBox(height: 16),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                color: ColorManager.offWhite),
                            child: Text("Last Name: ${user.lastName}",style: AppTextStyles.mediumTitle14)),
                        const SizedBox(height: 16),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                color: ColorManager.offWhite),
                            child: Text("Email: ${user.email}",style: AppTextStyles.mediumTitle14)),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
