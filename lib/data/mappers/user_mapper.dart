import 'package:komando_swimming_club/data/models/user_model.dart';
import 'package:komando_swimming_club/domain/entities/user.dart';

class UserMapper {
  User userModelToUser(UserModel userModel) {
    return User(
      id: userModel.id,
      name: userModel.name,
      phone: userModel.phone,
      userName: userModel.userName,
      password: userModel.password,
    );
  }

  UserModel userToUserModel(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      phone: user.phone,
      userName: user.userName,
      password: user.password,
    );
  }
}
