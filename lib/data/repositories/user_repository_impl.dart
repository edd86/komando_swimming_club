import 'package:komando_swimming_club/data/mappers/user_mapper.dart';
import 'package:komando_swimming_club/data/models/user_model.dart';
import 'package:komando_swimming_club/domain/entities/user.dart';
import 'package:komando_swimming_club/domain/repositories/user_repository.dart';
import 'package:sqflite/sqflite.dart';

class UserRepositoryImpl implements UserRepository {
  final Database db;
  UserRepositoryImpl({required this.db});
  @override
  Future<User?> addUser(User user) async {
    final userModel = UserMapper().userToUserModel(user);
    try {
      int id = await db.insert('users', userModel.toJson());
      return UserMapper().userModelToUser(userModel.copyWith(id: id));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> getUserLogged(String username, String password) async {
    try {
      final users = await getUsers();
      if (users != null && users.isNotEmpty) {
        for (var user in users) {
          if (user.userName == username && user.password == password) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<User>?> getUsers() async {
    try {
      final usersResponse = await db.query('users');
      final users = usersResponse
          .map((userRes) =>
              UserMapper().userModelToUser(UserModel.fromJson(userRes)))
          .toList();
      return users;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> getUserByUserName(String userName) async {
    try {
      final userResponse =
          await db.query('users', where: 'userName = ?', whereArgs: [userName]);
      if (userResponse.isNotEmpty) {
        final user = UserMapper()
            .userModelToUser(UserModel.fromJson(userResponse.first));
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
