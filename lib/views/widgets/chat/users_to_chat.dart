import 'package:chat_app_ahoy/blocs/chat/chat_bloc.dart';
import 'package:chat_app_ahoy/blocs/chat/chat_state.dart';
import 'package:chat_app_ahoy/views/screens/chat/chat_screen.dart';
import 'package:chat_app_ahoy/views/screens/chat/chat_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersToChat extends StatelessWidget {
  const UsersToChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).loadUsersToChat();
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ChatLoaded) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                ),
                title: Text(state.userList[index].id == 'vytbUEPdPCYwY2lJwpRX'
                    ? 'Me'
                    : state.userList[index].firstName),
                onTap: () {
                  Navigator.of(context)
                            .pushNamed(ChatScreen.routeName, arguments: {
                          'userId1': 'vytbUEPdPCYwY2lJwpRX',
                          'userId2': state.userList[index].id,
                          'name': state.userList[index].name
                        }).then((value) {
                          Navigator.pushNamedAndRemoveUntil(context, ChatUsersScreen.routeName, (r) => false);
                        });
                },
              );
            },
            itemCount: state.userList.length,
          );
        } else {
          return const Text('Something wrong..');
        }
      },
    );
  }
}
