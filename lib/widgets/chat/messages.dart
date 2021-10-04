import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Future<dynamic> getUser() {
    return Future.value(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (ctx, futureSnapshot) {
          while (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy('created_at', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print('wdqwdqdqwd $chatSnapshot');
                final chatDocs = chatSnapshot.data.docs;
                print("uuuu ${chatDocs[0].id}");
                return ListView.builder(
                  reverse: true,
                  itemBuilder: (ctx, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['userId'] == futureSnapshot.data.uid,
                    chatDocs[index]['username'],
                    chatDocs[index]['userImage'],
                    key: ValueKey(chatDocs[index].id),
                  ),
                  itemCount: chatDocs.length,
                );
              }
            },
          );
        });
  }
}
