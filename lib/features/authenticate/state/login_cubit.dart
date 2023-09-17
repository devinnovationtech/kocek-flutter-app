import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/features/authenticate/model/auth_model.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/permission_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginOnIdle());
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Future<void> go(BuildContext context,
      {required String email, required String password}) async {
    SharedPreferences preferences = await prefs;
    switch (Env.scope) {
      case KocekScope.internal:
        emit(LoginOnGoing());
        await Future.delayed(duration);
        var model = AuthModel.onDefault();
        emit(LoginOnSucceed(model: model));
        break;
      case KocekScope.external:
        if (email.isEmpty) {
          context.alert(label: "Username masih kosong");
        } else if (password.isEmpty) {
          context.alert(label: "Password masih kosong");
        } else {
          emit(LoginOnGoing());
          await Future.delayed(duration);
          try {

            Response response =
                await KocekApi.post(path: '/login', withToken: false, formdata: {
              "username": email,
              "password": password,
            });

            log("response: ${response.data}");
            if (response.data["token"] == null) {
              var message = response.data["message"];
              emit(LoginOnFailed(message: message));
            } else {
              AuthModel model = AuthModel.fromJson(response.data);
              var data = response.data['user']['permission'];

              List<PermissionModel> permissionModel = (data as List? ?? [])
                  .map((e) => PermissionModel.fromJson(e))
                  .toList();

              await KocekApi.setPermission(
                  permission: jsonEncode(permissionModel));
              await KocekApi.keepToken(token: model.token);
              emit(LoginOnSucceed(model: model));
            }
          } catch (e) {
            var model = await KocekReportModel.onDefault(
                type: KocekAPIType.post,
                api: ["/login"],
                title: "Gagal Login",
                content: e.toString());
            await KocekApi.sendReport(model: model);
            emit(LoginOnError(model: model));
          }
        }
        break;
    }
  }
}
