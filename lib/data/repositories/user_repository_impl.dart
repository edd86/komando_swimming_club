import 'package:komando_swimming_club/data/mappers/user_mapper.dart';
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
  Future<bool> getUserLogged(String username, String password) {
    // TODO: implement getUserLogged
    throw UnimplementedError();
  }

  @override
  Future<User> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
