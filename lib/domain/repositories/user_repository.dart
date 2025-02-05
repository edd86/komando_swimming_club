
import 'package:komando_swimming_club/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> addUser(User user);
  Future<User> getUsers();
  Future<bool> getUserLogged(String username, String password);
}
