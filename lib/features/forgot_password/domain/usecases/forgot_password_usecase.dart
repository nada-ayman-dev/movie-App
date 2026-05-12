import 'package:dartz/dartz.dart';
import 'package:movie/features/login/domain/failures/failure.dart';
import 'package:movie/features/forgot_password/domain/repositories/forgot_password_repository.dart';

class ForgotPasswordUseCase {
  final ForgotPasswordRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call(String email) {
    return repository.sendPasswordResetEmail(email);
  }
}
