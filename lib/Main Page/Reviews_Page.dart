import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../All_Custom_Faction/Colors.dart';
import '../All_Custom_Faction/TextStyle.dart';
import '../Controller/MyreviewsController.dart';

class Reviews_Page extends StatelessWidget {
  final MyReviewsController controller = Get.put(MyReviewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reviews',
              style: TextStyles.Montserratbold,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    final review = controller.reviews[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.greycolor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage('${review['avatar']}'),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${review['name']}',
                                            style: TextStyles.Montserratbold8,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${review['rating']}',
                                                style: TextStyles
                                                    .MontserratMedium4,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${review['date']}',
                                          style: TextStyles.MontserratRegular2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${review['user']}',
                                    style: TextStyles.Montserratbold7,
                                  ),
                                  SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: AppColors.gradientcolor2,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.reply,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Reply',
                                            style: TextStyles.MontserratMedium4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
