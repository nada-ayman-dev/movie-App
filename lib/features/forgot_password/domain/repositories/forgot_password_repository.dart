import 'package:dartz/dartz.dart';
import 'package:movie/features/login/domain/failures/failure.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, String>> sendPasswordResetEmail(String email);
}
