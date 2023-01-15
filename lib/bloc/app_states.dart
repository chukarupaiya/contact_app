import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../user_class.dart';

@immutable
abstract class UserState extends Equatable {}

//this class is used to load the data
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

//we should declare another class for loaded data and error loading
class UserLoadedState extends UserState {
  final List<user> users;
  UserLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

class UserLoadedState2 extends UserState {
  final user users;
  UserLoadedState2(this.users);

  @override
  List<Object?> get props => [user];
}

class UserErrorLoadingState extends UserState {
  final String error;

  UserErrorLoadingState(this.error);

  @override
  List<Object?> get props => [error];
}
