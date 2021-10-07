import 'package:chat_app_ahoy/blocs/chat/chat_bloc.dart';
import 'package:chat_app_ahoy/blocs/chat/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Messages extends StatefulWidget {
  Messages(this.userId1, this.userId2);

  final String userId1;
  final String userId2;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context)
        .getMessagesBetweenUsers(widget.userId1, widget.userId2);
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is MessagesLoaded) {
        if (state.messages.length == 0) {
          return const Center(
            child: Text('No messages. Send your first message.'),
          );
        } else {
          return ListView.builder(
            reverse: true,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              print("uuuuu ${state.messages[index].sended_at.toDate()}");
              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(state.messages[index].text),
                      Text(DateFormat.Hm().format(state.messages[index].sended_at.toDate())),
                    ],
                  ),
                ),
                color: state.messages[index].sender == 'vytbUEPdPCYwY2lJwpRX'
                    ? Colors.grey
                    : Colors.pink,
              );
            },
          );
        }
      } else {
        return Text('No Connection');
      }
    });
  }
}
