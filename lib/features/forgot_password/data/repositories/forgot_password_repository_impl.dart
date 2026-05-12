import 'package:dartz/dartz.dart';
import 'package:movie/features/login/domain/failures/failure.dart';
import 'package:movie/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:movie/features/forgot_password/data/datasources/forgot_password_remote_data_source.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource remoteDataSource;

  ForgotPasswordRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> sendPasswordResetEmail(String email) async {
    try {
      if (email.isEmpty) {
        return Left(ValidationFailure('Email cannot be empty'));
      }

      if (!_isValidEmail(email)) {
        return Left(ValidationFailure('Invalid email format'));
      }

      final code = await remoteDataSource.sendPasswordResetEmail(email);
      return Right(code);
    } on Exception catch (e) {
      return Left(AuthenticationFailure(e.toString()));
    }
  }

  bool _isValidEmail(String email) {
    const String emailRegex =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(emailRegex).hasMatch(email);
  }
}
