import 'package:clean_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
 Future<Either<Failure, String>>signUpwithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> signInwithEmailPassword({
    required String email,
    required String password,
  });
}
