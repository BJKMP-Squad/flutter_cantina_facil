import 'profile.dart';

abstract interface class AuthRepository {
  Stream<String?> authUserIds();
  Future<Profile> getProfile(String userId);
  Future<void> signOut();
}
