import 'package:chat_app_ahoy/services/chat_service.dart';
import 'package:chat_app_ahoy/views/screens/chat/chat_add_user_chat_screen.dart';
import 'package:chat_app_ahoy/views/screens/chat/chat_screen.dart';
import 'package:chat_app_ahoy/views/screens/chat/chat_users_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/chat/chat_event.dart';
import 'blocs/chat/chat_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
          create: (_) => ChatBloc(chatService: ChatServiceImpl()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        title: 'Ahoy Chat',
        initialRoute: "/",
        routes: {
          ChatUsersScreen.routeName: (_) => ChatUsersScreen(),
          ChatScreen.routeName: (_) => ChatScreen(),
          ChatAddUserChatScreen.routeName: (_) => ChatAddUserChatScreen(),
        },
      ),
    );
  }
}

/*  child: UsersChat(),
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
      routes: {ChatScreen.routeName: (_) => ChatScreen()},*/
