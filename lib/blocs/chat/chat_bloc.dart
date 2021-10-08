import 'package:bloc/bloc.dart';
import 'package:chat_app_ahoy/model/ahoy_message_model.dart';
import 'package:chat_app_ahoy/model/ahoy_user_model.dart';
import 'package:chat_app_ahoy/services/chat_service.dart';

import 'chat_event.dart';
import 'chat_state.dart';


class ChatBloc extends Cubit<ChatState> {
  ChatBloc({required this.chatService}): super(ChatInitial());

  final ChatService chatService;
  late List<Message> messagesLoaded;

  void loadUsers() async {
    emit(ChatLoading());
    try {
      final userList = await chatService.getUsers();
      print('lllllllllllllll $userList');
      emit(ChatLoaded(userList));
    } catch(e) {
      emit(ChatFailure('Error'));
    }
  }

  void getMessagesBetweenUsers(String userId1, String userId2) async {
    emit(ChatLoading());
    try {
      messagesLoaded = await chatService.getMessagesBetweenUsers(userId1: userId1, userId2: userId2);
      emit(MessagesLoaded(messages: messagesLoaded));
    } catch (e) {
      emit(ChatFailure('Error'));
    }
  }

  void sendMessage(String text, String userSenderId, String userId2) async {
    emit(MessagesLoaded(messages: messagesLoaded));
    try {
      messagesLoaded =await chatService.sendMessage(message: text, userSenderId: userSenderId, userId2: userId2);
      emit(MessagesLoaded(messages: messagesLoaded));
    } catch (e) {
      emit(ChatFailure('Error'));
    }
  }
}