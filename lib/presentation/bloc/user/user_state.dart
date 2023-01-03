import 'package:github_apps_deall/data/models/body/user_body.dart';

class UserState {}

class InitialUserState extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final ResponseUserBody userBody;

  UserLoaded(this.userBody);
}

class UserNotLoaded extends UserState {
  final String error;

  UserNotLoaded(this.error);
}
