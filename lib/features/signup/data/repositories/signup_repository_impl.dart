import 'package:dartz/dartz.dart';
import 'package:movie/features/login/domain/entities/user.dart';
import 'package:movie/features/login/domain/failures/failure.dart';
import 'package:movie/features/signup/domain/repositories/signup_repository.dart';
import 'package:movie/features/login/data/datasources/remote_data_source.dart';
import 'dart:io';

class SignUpRepositoryImpl implements SignUpRepository {
  final RemoteDataSource remoteDataSource;

  SignUpRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> signup(
    String email,
    String name,
    String password,
    String phone,
    File? image,
    int avatarIndex,
  ) async {
    try {
      if (email.isEmpty || name.isEmpty || password.isEmpty || phone.isEmpty) {
        return Left(ValidationFailure('All fields are required'));
      }

      if (!_isValidEmail(email)) {
        return Left(ValidationFailure('Invalid email format'));
      }

      if (name.length < 3) {
        return Left(ValidationFailure('Name must be at least 3 characters'));
      }

      if (password.length < 6) {
        return Left(
          ValidationFailure('Password must be at least 6 characters'),
        );
      }

      final userModel = await remoteDataSource.register(
        email,
        name,
        password,
        phone,
        image,
        avatarIndex,
      );
      return Right(userModel);
    } on Exception catch (e) {
      return Left(AuthenticationFailure(e.toString()));
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
