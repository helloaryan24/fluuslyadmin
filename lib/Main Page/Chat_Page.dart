import 'package:flutter/material.dart';
import 'package:fluuslyadmin/All_Custom_Faction/Colors.dart';
import 'package:get/get.dart';
import '../All_Custom_Faction/All_Widget.dart';
import '../All_Custom_Faction/TextStyle.dart';
import '../Controller/ChatController.dart';

class Chat_Page extends StatelessWidget {
  final Map<String, dynamic> message;
  final ChatController chatController = Get.put(ChatController());

  Chat_Page({required this.message});

  @override
  Widget build(BuildContext context) {
    // Add the initial message to the chatController messages
    chatController.messages.add(message);
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 0),
        child: Column(

          children: [
            Text(
              '${message['name']}',
              style: TextStyles.Montserratbold,
            ),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  reverse: false,
                  controller: chatController.scrollController,
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final msg = chatController.messages[index];
                    return Align(
                      alignment: msg['sender'] == 'Me'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: msg['sender'] == 'Me'
                                ? Colors.blueAccent
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            msg['message'] ?? 'No message',
                            style: msg['sender'] == 'Me' ? TextStyles.MontserratRegular : TextStyles.MontserratRegular9,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: buildInputField1(
                      hintText: "Type here..",
                      controller: chatController.messageController,
                      keyboardType: TextInputType.name,
                      onChanged: (query) {
                        // controller.searchLocation(query);
                      },
                    )
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: AppColors.contcolor1,
                    radius: 25,
                    child: IconButton(
                        onPressed: (){
                          chatController.sendMessage();
                          Future.delayed(Duration(milliseconds: 100), () {
                            chatController.scrollController.animateTo(
                              chatController.scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          });
                        }, icon: Icon(Icons.send,color: AppColors.whitecolor,)),),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
