import 'package:dartz/dartz.dart';
import 'package:movie/features/login/domain/entities/user.dart';
import 'package:movie/features/login/domain/failures/failure.dart';
import 'package:movie/features/signup/domain/repositories/signup_repository.dart';
import 'dart:io';

class SignUpUseCase {
  final SignUpRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, User>> call(
    String email,
    String name,
    String password,
    String phone,
    File? image,
    int avatarIndex,
  ) {
    return repository.signup(email, name, password, phone, image, avatarIndex);
  }
}
