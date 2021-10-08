import 'package:equatable/equatable.dart';

import 'ahoy_message_model.dart';

// this class is a singleton to make current user id accessible globally
class CurrentUser {
  factory CurrentUser() => _instance;

  CurrentUser._internal();

  static final CurrentUser _instance = CurrentUser._internal();

  static String _userId = '';

  static set setUserId(String id) {
    _userId = id;
  }

  static String get currentUserId => _userId;
}

class AhoyUser extends Equatable {
  AhoyUser({
    required this.id,
    required this.title,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.photoURL
  });

  factory AhoyUser.fromMap(Map<String, dynamic> data) {
    return AhoyUser(
      id: data['userId'] as String,
      title: data['title'] as String,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      photoURL: data['photoURL'] as String,
      phoneNo: data['phoneNo'] as String
    );
  }

  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  final String photoURL;
  late Message lastMessage;

  String get fullName =>
      firstName.isEmpty ? 'New User' : '$firstName $lastName';
  String get mobileNo => phoneNo.isEmpty ? '(000) 000-0000' : phoneNo;

  @override
  List<Object?> get props =>
      [id, title, email, firstName, lastName, photoURL, phoneNo, lastMessage];

  String get name => firstName;
}
