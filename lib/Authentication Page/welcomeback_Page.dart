import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../All_Custom_Faction/All_Widget.dart';
import '../All_Custom_Faction/Colors.dart';
import '../All_Custom_Faction/Image.dart';
import '../All_Custom_Faction/TextStyle.dart';
import 'Login_Page.dart';
import 'Signup_Page.dart';

class Welcomeback_Page extends StatelessWidget {
  const Welcomeback_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.whitecolor,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Images.fluushynamewithlogo,
                width: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Welcome\nBack...",
                    style: TextStyles.MontserratRegular8),
              ),
              Spacer(),
              CustomButton(
                text: 'Sign in',
                backgroundColor: AppColors.contcolor1,
                onTap: () {
                  Get.to(() => LoginPage_Screen());

                },
                style: TextStyles.MontserratMedium3,
                icon: Icon(
                  Icons.arrow_forward,
                  color: AppColors.whitecolor,
                  size: 30,
                ),
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'Sign up',
                backgroundColor: AppColors.whitecolor,
                onTap: () {
                  Get.to(() => SignupPage_Screen());
                },
                style: TextStyles.MontserratMedium6,
                icon: Icon(
                  Icons.arrow_forward,
                  color: AppColors.contcolor1,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
