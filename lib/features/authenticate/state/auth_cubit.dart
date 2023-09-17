import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/static/kocek_general_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/static/constant_variable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthOnGoing());

  Future<void> go() async {
    emit(AuthOnGoing());
    await Future.delayed(duration);

    switch (Env.scope) {
      case KocekScope.internal:
        emit(AuthOnLogin());
        break;
      case KocekScope.external:
        String? token =
            (await SharedPreferences.getInstance()).getString("token");
        if (token == null) {
          emit(AuthOnLogin());
        } else {
          try {
            Response response =
                await KocekApi.post(path: '/history-location', formdata: {
              "note": "Buka Aplikasi Tanpa Login"
            });

            var model = KocekGeneralModel.fromJson(response.data);
            if (model.success) {
              emit(AuthOnDashboard());
            } else {
              emit(const AuthOnDashboardWithNotification(
                  message: "Gagal Menyimpan Lokasi Masuk"));
            }
          } catch (e) {
            emit(const AuthOnDashboardWithNotification(
                message: "Gagal Menyimpan Lokasi Masuk"));
          }
        }
        break;
    }
  }
}
