import 'package:chat_app_ahoy/blocs/chat/chat_bloc.dart';
import 'package:chat_app_ahoy/blocs/chat/chat_state.dart';
import 'package:chat_app_ahoy/services/chat_service.dart';
import 'package:chat_app_ahoy/views/widgets/chat/users_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatUsersScreen extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ChatBloc(chatService: ChatServiceImpl()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Ahoy'),
            actions: [
              IconButton(
                icon: const Icon(Icons.group_add),
                tooltip: 'Create Group',
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Create Group')));
                },
              ),
            ],
          ),
          body: UsersChat(),
        ));
  }
}
