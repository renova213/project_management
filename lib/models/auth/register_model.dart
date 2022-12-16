import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;

  const RegisterModel(
      {required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.passwordConfirmation});

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "phone_number": phone,
        "password": password,
        "password_confirmation": passwordConfirmation
      };
  @override
  List<Object> get props => [
        firstName,
        lastName,
        username,
        email,
        phone,
        password,
        passwordConfirmation
      ];
}
