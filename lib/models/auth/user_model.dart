import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String username;
  final String email;

  const UserModel({required this.username, required this.email});

  @override
  List<Object> get props => [username, email];
}
