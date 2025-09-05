import 'package:equatable/equatable.dart';

class CreateAccountEntity extends Equatable {
  final String email;
  final String username;
  final String password;
  final String confirmPassword;
  final String db;

  const CreateAccountEntity(
      {required this.email,
      required this.confirmPassword,
      required this.username,
      required this.password,
      required this.db});

  @override
  List<Object?> get props => [];
}
