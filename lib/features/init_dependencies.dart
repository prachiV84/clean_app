import 'package:clean_app/core/secrets/app_secrets.dart';
import 'package:clean_app/core/usecase/user_login.dart';
import 'package:clean_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:clean_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecretes.supabaseUrl,
    anonKey: AppSecretes.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator
  .registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator<SupabaseClient>(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(
    () => userSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(() =>
      AuthBloc(userSignUp: serviceLocator(), userLogin: serviceLocator()));
}
