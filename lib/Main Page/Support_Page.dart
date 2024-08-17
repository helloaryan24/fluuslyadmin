import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../All_Custom_Faction/All_Widget.dart';
import '../All_Custom_Faction/Colors.dart';
import '../All_Custom_Faction/Image.dart';
import '../All_Custom_Faction/TextStyle.dart';

class Support_Page extends StatelessWidget {
  const Support_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Support',
              style: TextStyles.Montserratbold,
            ),
            const SizedBox(height: 100),
            Image.asset(
              Images.Supportimg,
              height: 100,
              width: double.infinity,
            ),
            const SizedBox(height: 20),
            Text(
              'Hello,How can we help you?',
              style: TextStyles.MontserratSemibold6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SupportOption(
              icon: Icons.message_outlined,
              text: 'Contact Live Chat',
              onTap: () {
                // Add your logic here
              },
            ),
            const SizedBox(height: 10),
            SupportOption(
              icon: Icons.email_outlined,
              text: 'Send us an E-mail',
              onTap: () {
                // Add your logic here
              },
            ),
            const SizedBox(height: 10),
            SupportOption(
              icon: Icons.quiz,
              text: 'FAQs',
              onTap: () {
                // Add your logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}

