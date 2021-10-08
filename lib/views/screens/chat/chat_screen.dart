import 'package:chat_app_ahoy/blocs/chat/chat_bloc.dart';
import 'package:chat_app_ahoy/blocs/chat/chat_state.dart';
import 'package:chat_app_ahoy/model/ahoy_user_model.dart';
import 'package:chat_app_ahoy/services/chat_service.dart';
import 'package:chat_app_ahoy/views/widgets/chat/messages.dart';
import 'package:chat_app_ahoy/views/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat/user';
  late Future<AhoyUser> user;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final usersData =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    BlocProvider.of<ChatBloc>(context).getMessagesBetweenUsers(
        usersData['userId1'] as String, usersData['userId2'] as String);
    return BlocProvider(
      create: (context) => ChatBloc(chatService: ChatServiceImpl()),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, 'Passed Value');

          /// It's important that returned value (boolean) is false,
          /// otherwise, it will pop the navigator stack twice;
          /// since Navigator.pop is already called above ^
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(usersData['name'] as String),
          ),
          body: Column(
            children: [
              Expanded(
                child: Messages(usersData['userId1']!, usersData['userId2']!),
              ),
              NewMessage(
                  user1: usersData['userId1']!, user2: usersData['userId2']!),
            ],
          ),
        ),
      ),
    );
  }
}
