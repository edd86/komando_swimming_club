import 'package:komando_swimming_club/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> addUser(User user);
  Future<List<User>?> getUsers();
  Future<bool?> getUserLogged(String username, String password);
  Future<User?> getUserByUserName(String userName);
  Future<User?> getUserById(int id);
  Future<int?> updateUser(User user);
}
