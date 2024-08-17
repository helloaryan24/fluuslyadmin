import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../All_Custom_Faction/Colors.dart';
import '../All_Custom_Faction/TextStyle.dart';
import '../Controller/Messages_Contoller.dart';
import 'Chat_Page.dart';

class Message_Page extends StatelessWidget {
  final MessagesContoller controller = Get.put(MessagesContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Messages',
              style: TextStyles.Montserratbold,
            ),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => Chat_Page(message: message));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(message['avatar']),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                message['name'],
                                                style: TextStyles.Montserratbold8,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          message['message'],
                                          style: TextStyles.Montserratbold4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        message['time'],
                                        style: TextStyles.MontserratRegular2,
                                      ),
                                      SizedBox(height: 5),
                                      if (message['unread'] > 0)
                                        CircleAvatar(
                                          backgroundColor: AppColors.contcolor1,
                                          radius: 12,
                                          child: Text(
                                            '${message['unread']}',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: AppColors.greycolor),
                        ],
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
