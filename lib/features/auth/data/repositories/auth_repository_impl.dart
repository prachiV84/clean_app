import 'package:clean_app/core/error/exception.dart';
import 'package:clean_app/core/error/failures.dart';
import 'package:clean_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:clean_app/features/auth/domain/entities/user.dart';
import 'package:clean_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> signInwithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.signInwithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpwithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await remoteDataSource.signUpwithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentData();
      if (user == null) {
        return left(Failure('user not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

Future<Either<Failure, User>> _getUser(
  Future<User> Function() fn,
) async {
  try {
    final user = await fn();

    return right(user);
  } on sb.AuthException catch (e) {
    return left(
      Failure(e.message),
    );
  } on ServerException catch (e) {
    return left(Failure(e.message));
  }
}
