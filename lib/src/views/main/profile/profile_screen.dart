import 'package:flutter/material.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';
import 'package:project_restaurant/src/views/main/profile/components/profile_app_bar.dart';
import 'package:project_restaurant/src/views/main/profile/components/profile_details_block.dart';
import 'package:project_restaurant/src/views/main/profile/components/profile_header.dart';
import 'package:project_restaurant/src/views/main/profile/components/profile_option_card.dart';

class ProfileScreen extends StatelessWidget {
  //route
  static const String route = 'profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ProfileAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /***** Header *****/
                    const ProfileHeader(),
                    /***** -END- Header *****/

                    /***** profile details *****/
                    const ProfileDetailsBlock(),
                    /***** -END- profile details *****/

                    /***** Options Cards *****/
                    const ProfileOptionCard(
                      title: 'My Order',
                    ),
                    const Divider(color: Color.fromRGBO(155, 155, 155, 1)),
                    const ProfileOptionCard(
                      title: 'Shipping addresses',
                    ),
                    const Divider(color: Color.fromRGBO(155, 155, 155, 1)),
                    const ProfileOptionCard(
                      title: 'Payment Methods',
                    ),
                    const Divider(color: Color.fromRGBO(155, 155, 155, 1)),
                    const ProfileOptionCard(
                      title: 'Promocodes',
                    ),
                    const Divider(color: Color.fromRGBO(155, 155, 155, 1)),
                    const ProfileOptionCard(
                      title: 'My Reviews',
                    ),
                    const Divider(color: Color.fromRGBO(155, 155, 155, 1)),
                    const ProfileOptionCard(
                      title: 'Settings',
                    ),
                    const Divider(color: Color.fromRGBO(155, 155, 155, 1)),
                    ProfileOptionCard(
                        title: 'Logout',
                        onTap: () {
                          Auth.logout(context); 
                        }),
                    /***** -END- Options Cards *****/
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
