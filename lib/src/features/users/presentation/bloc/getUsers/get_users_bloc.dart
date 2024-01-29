import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';
import 'package:hometasks/src/features/users/domain/use_cases/get_users_use_case.dart';
import 'package:hometasks/src/features/users/presentation/bloc/getUsers/get_users_event.dart';
import 'package:hometasks/src/features/users/presentation/bloc/getUsers/get_users_state.dart';

class GetUsersBloc extends Bloc<GetUsersEvent,GetUsersState>{
  GetUsersBloc({
    required GetUsersUseCase getUsersUseCase
}):_getUsersUseCase=getUsersUseCase,super(const GetUsersState()){
    on<OnGetUsers>(_onGetUsers);
    on<OnGetUsersSuccess>(_onGetUsersSuccess);
    on<OnGetUsersFailed>(_onGetUsersFailed);

  }

  final GetUsersUseCase _getUsersUseCase;


  @override
  Future<void> close() {
    // Close any resources here
    // Close the stream
    return super.close();
  }

  Future<void> _onGetUsers(OnGetUsers event,Emitter<GetUsersState> emitter ) async{

    try{
      emit(state.copyWith(status: ()=>GetUsersStatus.loading));
      Result<List<UserEntity>> result= await _getUsersUseCase.call();
      if(!result.isSuccess){
        add(const OnGetUsersFailed());
        return;
      }
      add(OnGetUsersSuccess(usersList: result.value!));
    }
    catch(e){
        add(const OnGetUsersFailed());
        return;
    }
  }
  Future<void> _onGetUsersSuccess(OnGetUsersSuccess event,Emitter <GetUsersState> emitter) async{
    emit(state.copyWith(users: ()=>event.usersList,status: ()=>GetUsersStatus.success));
  }
  Future<void> _onGetUsersFailed(OnGetUsersFailed event,Emitter <GetUsersState> emitter) async{
    emit(state.copyWith(status: ()=>GetUsersStatus.failure));
  }

}