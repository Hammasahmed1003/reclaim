import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  var messages = <Message>[].obs;
  var messageController = TextEditingController();

  void sendMessage(String text, bool isMe) {
    if (text.trim().isNotEmpty) {
      messages.add(Message(text: text, isMe: isMe));
      messageController.clear();
    }
  }
}

class Message {
  final String text;
  final bool isMe;
  Message({required this.text, required this.isMe});
}