import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var messages = <Map<String, dynamic>>[].obs;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      messages.add({
        'sender': 'Me',
        'message': messageController.text,
      });
      messageController.clear();
    }
  }
}

