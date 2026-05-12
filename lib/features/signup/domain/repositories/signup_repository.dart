import 'package:dartz/dartz.dart';
import 'package:movie/features/login/domain/entities/user.dart';
import 'package:movie/features/login/domain/failures/failure.dart';
import 'dart:io';

abstract class SignUpRepository {
  Future<Either<Failure, User>> signup(
    String email,
    String name,
    String password,
    String phone,
    File? image,
    int avatarIndex,
  );
}
