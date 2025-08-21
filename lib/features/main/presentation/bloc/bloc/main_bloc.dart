import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/src/application/router/app_router.dart';
import 'package:sham/src/application/router/app_routes.dart';

import '../../../../../src/application/di/injection.dart';
import '../../../../../src/infrastructure/storage/local_storage.dart';
import 'main_event.dart';
import 'main_state.dart';

@lazySingleton
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<ChangeBottomItemEvent>(_changeBottomItemEvent);
    on<LogOutEvent>(_logout);
  }
  FutureOr<void> _changeBottomItemEvent(
      ChangeBottomItemEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(selectedIndex: event.selectedItem));
    debugPrint("state.selectedIndex");
    debugPrint(state.selectedIndex.toString());
    debugPrint("event.selectedItem");
    debugPrint(event.selectedItem.toString());
  }

  FutureOr<void> _logout(LogOutEvent event, Emitter<MainState> emit) async {
    final LocalStorage localeStorage = sl<LocalStorage>();
    await localeStorage.removeUserInfo();
    await localeStorage.removeSecuredString();
    // AppRouter(AppRoutes.initScreen);
    emit(state.copyWith(logOut: true,selectedIndex: 0));
    Future.delayed(Duration(milliseconds: 300));
    emit(state.copyWith(logOut: false));

  }
}
