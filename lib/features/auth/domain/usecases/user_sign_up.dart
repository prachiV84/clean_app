import 'package:clean_app/core/error/failures.dart';
import 'package:clean_app/core/usecase/usecase.dart';
import 'package:clean_app/features/auth/domain/entities/user.dart';
import 'package:clean_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class userSignUp implements UseCase<User, UseSignUpParams> {
  final AuthRepository authRepository;
   const userSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>>
   call(UseSignUpParams params) async {
   return await authRepository.signUpwithEmailPassword(
      name:params.name,
      email: params.email,
      password: params.password,
     
    );
  }
}

class UseSignUpParams {
  final String email;
  final String password;
  final String name;
  UseSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
