import '../repository.dart';
import './app_events.dart';
import './app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final String endpoint;
  final int id;

  UserBloc(this._userRepository, this.endpoint, this.id)
      : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        if (id == 0) {
          final user_temp = await _userRepository.getUsers(endpoint);
          //print(user_temp);
          emit(UserLoadedState(user_temp));
        } else {
          final user_temp = await _userRepository.getUsersById(endpoint+"/"+id.toString());
          //print(user_temp);
          emit(UserLoadedState2(user_temp));
        }
      } catch (e) {
        // emit(UserErrorLoadingState(e.toString()));
        print("some thing went wrong");
      }
    });
  }
}
