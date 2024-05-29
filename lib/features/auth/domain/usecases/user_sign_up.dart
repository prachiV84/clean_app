import 'package:clean_app/core/error/failures.dart';
import 'package:clean_app/core/usecase/usecase.dart';
import 'package:clean_app/features/auth/domain/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class userSignUp implements UseCase<String, UseSignUpParams> {
  final AuthRepository authRepository;
  userSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UseSignUpParams params) async {
   return await authRepository.signUpwithEmailPassword(
      email: params.email,
      password: params.password,
      name:params.name,
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
