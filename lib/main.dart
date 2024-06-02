import 'package:clean_app/core/secrets/app_secrets.dart';
import 'package:clean_app/core/theme/theme.dart';
import 'package:clean_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:clean_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_app/features/auth/domain/usecases/user_sign_up.dart';
/* import 'package:clean_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:clean_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_app/features/auth/domain/usecases/user_sign_up.dart'; */
import 'package:clean_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_app/features/auth/presentation/pages/Login_page.dart';
import 'package:clean_app/features/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/* const supabaseUrl = 'https://yumlcpxnqhuxxkfndtpg.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl1bWxjcHhucWh1eHhrZm5kdHBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY4NzM0OTYsImV4cCI6MjAzMjQ0OTQ5Nn0.6p-MhsyN-NGliBYAyf4gpi84-3GQgOyedYTbN5A1nrQ'; */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* final supabase = await Supabase.initialize(
    url: AppSecretes.supabaseUrl,
    anonKey: AppSecretes.supabaseAnonKey,
  ); */
   await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
           create: (_) => serviceLocator<AuthBloc>(), 
          /* create: (_) => AuthBloc(
              userSignUp: userSignUp(
                AuthRepositoryImpl(
                  AuthRemoteDataSourceImpl(
                    supabase.client
                    ),
                 ),
               ),
              ), */
            ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
    );
  }
}
