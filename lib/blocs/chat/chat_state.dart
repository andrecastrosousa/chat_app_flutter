import 'package:chat_app_ahoy/model/ahoy_message_model.dart';
import 'package:chat_app_ahoy/model/ahoy_user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable{
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  const ChatLoaded(this.userList);

  final List<AhoyUser> userList;

  @override
  List<Object?> get props => [userList];
}

class ChatFailure extends ChatState {
  const ChatFailure(this.message);

  final String message;
}

class ChatFoundUserSuccessfully extends ChatState {
  const ChatFoundUserSuccessfully({required this.user});

  final AhoyUser user;
}

class SendMessageSuccess extends ChatState {}

class SendMessageFailure extends ChatState {
  const SendMessageFailure(this.message);

  final String message;
}

class SendingMessage extends ChatState {}

class MessagesLoaded extends ChatState {
  const MessagesLoaded({required this.messages});

  final List<Message> messages;
  
  @override
  // TODO: implement props
  List<Object?> get props => [messages];
}

class MessagesLoading extends ChatState{}

class ChatLoadingWithMessageSending extends ChatState {}
