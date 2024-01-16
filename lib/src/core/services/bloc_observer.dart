import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class BlocObserverWrapper extends BlocObserver{
  @override
  void onEvent(Bloc bloc , Object? event){
    super.onEvent(bloc, event);
    log('bloc event accord');
    log('${bloc.runtimeType} $event');
  }
  @override
  void onChange(BlocBase bloc , Change change){
    super.onChange(bloc, change);
    log('bloc change accord');
    log('${bloc.runtimeType} $change');
  }
  @override
  void onTransition(Bloc bloc , Transition transition){
    super.onTransition(bloc, transition);
    log('bloc transition accord');
    log('${bloc.runtimeType} $transition');
  }
  @override
  void onError(BlocBase bloc,Object error , StackTrace stackTrace){
    log('bloc error accord');
    log('${bloc.runtimeType} $error');
    super.onError(bloc, error,stackTrace);
  }
}