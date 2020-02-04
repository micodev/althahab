import 'dart:async';

import 'package:mrooj_althahab/models/ApiToken.dart';
import 'package:mrooj_althahab/models/Users.dart';
import 'package:mrooj_althahab/repository/AppRepository.dart';

class UsersBloc {
  final AppRepository appRepo = AppRepository();

  Future<ApiToken> addUser(Users user) async {
    var person = appRepo.createUser(user);
    return person;
  }

  Future<Users> getbalance() async {
    return appRepo.getBalance();
  }

  Future<Users> loginUser(String number, String password) async {
    return await appRepo.loginUser(number, password);
  }
}
