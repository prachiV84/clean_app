import 'package:clean_app/core/error/exception.dart';
import 'package:clean_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpwithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInwithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  @override
  Future<UserModel> signInwithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException('user is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpwithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
       
        email: email,
        password: password,
         data: {
          'name': name,
        },
      );
      print(response);
      if (response.user == null) {
        throw ServerException('user is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      print(e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select('id,name')
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
