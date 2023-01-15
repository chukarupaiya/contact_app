import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

//this class is used to load the data
class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}
