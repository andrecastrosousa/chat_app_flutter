import 'package:chat_app_ahoy/model/ahoy_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../blocs/chat/chat_state.dart';
import '../model/ahoy_user_model.dart';

abstract class ChatService {
  Future<List<Message>> sendMessage({
    required String message,
    required String userSenderId,
    required String userId2,
  });
  Future<List<AhoyUser>> getUsers();
  Future<List<Message>> getMessagesBetweenUsers(
      {required String userId1, required String userId2});
}

class ChatServiceImpl extends ChatService {
  ChatServiceImpl() {
    _firestore = firestore ?? FirebaseFirestore.instance;
    _userCollection = _firestore!.collection('users');
    _chatCollection = _firestore!.collection('chats');
  }

  FirebaseFirestore? firestore;

  late FirebaseFirestore? _firestore;
  late CollectionReference _userCollection;
  late CollectionReference _chatCollection;

  @override
  Future<List<Message>> sendMessage({
    required String message,
    required String userSenderId,
    required String userId2,
  }) async {
    List<Message> messagesList = <Message>[];
    try {
      String chatMessagesId = await _getChatMessageId(userSenderId, userId2);

      if (chatMessagesId == '') {
        await _chatCollection
            .add({'userId1': userSenderId, 'userId2': userId2}).then(
                (value) => chatMessagesId = value.id);
        messagesList = [];
      }
      await FirebaseFirestore.instance
          .collection('chats/' + chatMessagesId + '/messages')
          .add(
            {
              'text': message,
              'sended_at': Timestamp.now(),
              'sender': userSenderId,
            },
          )
          .then((value) => print("ola Message Sended"))
          .catchError((onError) => print("ola Error on sending message"));

      messagesList = await _getMessagesFromChatId(chatMessagesId);

      return messagesList;
    } catch (e) {
      throw SendMessageFailure('No connection...');
    }
  }

  Future<String> _getChatMessageId(String userId1, String userId2) async {
    var chatMessageId = '';
    await _chatCollection
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((element) {
                if ((userId1 == element['userId1'] &&
                        userId2 == element['userId2']) ||
                    (userId1 == element['userId2'] &&
                        userId2 == element['userId1'])) {
                  chatMessageId = element.id;
                  return;
                }
              })
            })
        .catchError((value) => {chatMessageId = ''});
    return chatMessageId;
  }

  Future<List<Message>> _getMessagesFromChatId(String chatMessagesId) async {
    List<Message> messagesList = <Message>[];
    await FirebaseFirestore.instance
        .collection('chats/' + chatMessagesId + '/messages')
        .orderBy('sended_at', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((element) {
                messagesList.add(
                  Message(
                    text: element['text'],
                    sender: element['sender'],
                    sended_at: element['sended_at'],
                  ),
                );
              })
            });
    return messagesList;
  }

  @override
  Future<List<Message>> getMessagesBetweenUsers(
      {required String userId1, required String userId2}) async {
    List<Message> messagesList = <Message>[];
    try {
      String chatMessagesId = await _getChatMessageId(userId1, userId2);
      if (chatMessagesId != '') {
        messagesList = await _getMessagesFromChatId(chatMessagesId);
      } else {
        messagesList = [];
      }

      return messagesList;
    } catch (e) {
      throw Exception('No connection...');
    }
  }

  @override
  Future<List<AhoyUser>> getUsers() async {
    List<AhoyUser> userList = <AhoyUser>[];
    List<List<String>> chatsId = [];
    try {
      // take every user in firebase
      final querySnapshot =
          await _userCollection.get().then((QuerySnapshot querySnapshot) => {
                userList = querySnapshot.docs
                    .map((user) => AhoyUser(
                          id: user.id,
                          title: "",
                          firstName: user['name'],
                          lastName: "",
                          email: "",
                          photoURL: "",
                          phoneNo: "",
                        ))
                    .toList()
              });

      // find everychat opened by authenticated user (vytbUEPdPCYwY2lJwpRX)
      final querySnapshotLastMessage =
          await _chatCollection.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((chat) {
          if (chat['userId1'] == 'vytbUEPdPCYwY2lJwpRX' ||
              chat['userId2'] == 'vytbUEPdPCYwY2lJwpRX') {
            chatsId.add([chat.id, chat['userId1'], chat['userId2']]);
          }
        });
      });

      Map<String, dynamic> listMessages = {};

      // find last message for every opened chat by authenticated user
      await Future.forEach(
          chatsId,
          (List<String> element) async => {
                listMessages[element[0]] = await FirebaseFirestore.instance
                    .collection('chats/' + element[0] + '/messages')
                    .orderBy('sended_at', descending: true)
                    .limit(1)
                    .get()
              });

      // Relation between chat with certain user with last message take
      userList.forEach((user) {
        chatsId.forEach((chatInfo) {
          if (chatInfo[1] == user.id || chatInfo[2] == user.id) {
            var messageInfo = listMessages[chatInfo[0]].docs[0].data();
            user.lastMessage = Message(
                text: messageInfo['text'],
                sended_at: messageInfo['sended_at'],
                sender: messageInfo['sender']);
          }
        });
      });

      return userList;
    } catch (e) {
      throw ChatFailure('No connection...');
    }
  }
}
