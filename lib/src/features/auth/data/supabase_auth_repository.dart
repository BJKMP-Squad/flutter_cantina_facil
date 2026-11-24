import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/auth_repository.dart';
import '../domain/profile.dart';

part 'supabase_auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    SupabaseAuthRepository(Supabase.instance.client);

@Riverpod(keepAlive: true)
Stream<String?> authUserId(Ref ref) =>
    ref.watch(authRepositoryProvider).authUserIds();

@riverpod
Future<Profile> profile(Ref ref, String userId) =>
    ref.watch(authRepositoryProvider).getProfile(userId);

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);

  final SupabaseClient _client;

  @override
  Stream<String?> authUserIds() => _client.auth.onAuthStateChange
      .map((event) => event.session?.user.id)
      .distinct();

  @override
  Future<Profile> getProfile(String userId) async {
    final data = await _client
        .from('cantina_profiles')
        .select('id, nome, email, role')
        .eq('id', userId)
        .single();
    return Profile(
      id: data['id'] as String,
      nome: data['nome'] as String?,
      email: data['email'] as String?,
      role: data['role'] as String,
    );
  }

  @override
  Future<void> signOut() => _client.auth.signOut();
}
