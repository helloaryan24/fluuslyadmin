import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../All_Custom_Faction/Colors.dart';
import '../All_Custom_Faction/Image.dart';
import '../All_Custom_Faction/TextStyle.dart';
import '../Controller/BottomBarController.dart';
import '../Main Page/AddedToilets_Page.dart';
import '../Main Page/Dashboard_Page.dart';
import '../Main Page/Profile_Page.dart';
import '../Main Page/Reviews_Page.dart';

class BottomBar_Page extends StatelessWidget {
  final BottomBarController controller = Get.put(BottomBarController());

  final List<Widget> _pages = [
    Dashboard_Page(),
    Addedtoilets_Page(),
    Reviews_Page(),
    Profile_Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _pages[controller.selectedIndex.value];
      }),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whitecolor,
        padding: EdgeInsets.all(0),
        height: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures the BottomAppBar takes minimal space
          children: [
            Container(
              height: 2,
              width: double.infinity,
              color: AppColors.gradientcolor2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25,bottom: 5,top: 10,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildBottomNavItem(0),
                  buildBottomNavItem(1),
                  buildBottomNavItem(2),
                  buildBottomNavItem(3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavItem(int index) {
    String assetImage;
    if (index == 0) {
      assetImage = Images.add;
    } else if (index == 1) {
      assetImage = Images.wc;
    } else if (index == 2){
      assetImage = Images.review;
    } else {
      assetImage = Images.user;
    }

    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Obx(() {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            controller.selectedIndex.value == index ? AppColors.gradientcolor2 : Colors.transparent,
            BlendMode.srcATop,
          ),
          child: Image.asset(
            assetImage,
            height: 25,
            width: 25,
          )
        );
      }),
    );
  }
}
