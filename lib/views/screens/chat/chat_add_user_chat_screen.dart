import 'package:chat_app_ahoy/blocs/chat/chat_bloc.dart';
import 'package:chat_app_ahoy/services/chat_service.dart';
import 'package:chat_app_ahoy/views/widgets/chat/users_to_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAddUserChatScreen extends StatelessWidget {
  ChatAddUserChatScreen({Key? key}) : super(key: key);

  static const String routeName = '/chats/choose-user';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(chatService: ChatServiceImpl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select a friend to chat'),
        ),
        body: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.group_add),
              ),
              title: Text('Create Group'),
            ),
            Divider(),
            Container(
              child: UsersToChat(),
            ),
          ],
        ),
      ),
    );
  }
}
