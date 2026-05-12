import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../failures/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> signInWithGoogle();
}
