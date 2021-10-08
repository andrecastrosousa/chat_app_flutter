import 'package:chat_app_ahoy/blocs/chat/chat_bloc.dart';
import 'package:chat_app_ahoy/blocs/chat/chat_state.dart';
import 'package:chat_app_ahoy/services/chat_service.dart';
import 'package:chat_app_ahoy/views/screens/chat/chat_add_user_chat_screen.dart';
import 'package:chat_app_ahoy/views/widgets/chat/users_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatUsersScreen extends StatelessWidget {
  static const routeName = "/";

  void addUser(BuildContext context) {
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ChatBloc(chatService: ChatServiceImpl()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Chat Ahoy'),
          ),
          body: UsersChat(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ChatAddUserChatScreen.routeName);
            },
          ),
        ));
  }
}
