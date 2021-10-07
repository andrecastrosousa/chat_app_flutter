import 'package:chat_app_ahoy/model/ahoy_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({
    required this.text,
    required this.sended_at,
    required this.sender,
  });

  final String text;
  final Timestamp sended_at;
  final String sender;
}