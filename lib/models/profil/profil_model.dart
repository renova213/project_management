import 'package:equatable/equatable.dart';

class ProfilModel extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;

  const ProfilModel(
      {required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.phone});
  factory ProfilModel.fromJson(Map<String, dynamic> json) => ProfilModel(
      firstName: json['firstname'] ?? "",
      lastName: json['lastname'] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone_number'] ?? "");

  @override
  List<Object> get props => [firstName, lastName, username, email, phone];
}
