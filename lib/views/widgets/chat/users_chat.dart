import 'package:chat_app_ahoy/blocs/chat/chat_bloc.dart';
import 'package:chat_app_ahoy/blocs/chat/chat_state.dart';
import 'package:chat_app_ahoy/views/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersChat extends StatefulWidget {
  @override
  State<UsersChat> createState() => _UsersChatState();
}

class _UsersChatState extends State<UsersChat> {
  Future<void> _reload() async {}

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).loadUsers();
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatLoaded) {
          return ListView.builder(
            itemCount: state.userList.length,
            itemBuilder: (context, index) => Material(
              child: state.userList[index].id != 'vytbUEPdPCYwY2lJwpRX'
                  ? ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.amber,
                      ),
                      title: Text(state.userList[index].name),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ChatScreen.routeName, arguments: {
                          'userId1': 'vytbUEPdPCYwY2lJwpRX',
                          'userId2': state.userList[index].id,
                          'name': state.userList[index].name
                        }).then((value) {
                          BlocProvider.of<ChatBloc>(context).loadUsers();
                        });
                      },
                      trailing: Text(state.userList[index].lastMessage.sender ==
                              "vytbUEPdPCYwY2lJwpRX"
                          ? 'You: ' + state.userList[index].lastMessage.text
                          : '' + state.userList[index].lastMessage.text),
                    )
                  : null,
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
