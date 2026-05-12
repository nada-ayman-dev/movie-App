import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/failures/failure.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final RemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return Left(ValidationFailure('Email and password are required'));
      }

      if (!_isValidEmail(email)) {
        return Left(ValidationFailure('Invalid email format'));
      }

      if (password.length < 6) {
        return Left(
          ValidationFailure('Password must be at least 6 characters'),
        );
      }

      final userModel = await remoteDataSource.login(email, password);
      return Right(userModel);
    } on Exception catch (e) {
      return Left(AuthenticationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final userModel = await remoteDataSource.signInWithGoogle();
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
