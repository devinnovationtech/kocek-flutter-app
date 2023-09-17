import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/features/authenticate/state/auth_cubit.dart';
import 'package:kocek_app/features/authenticate/widget/login_page.dart';
import 'package:kocek_app/utils/animation/bouncing_animation.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BlocListener<AuthCubit, AuthStates>(
                listener: (_, state) {
                  if (state is AuthOnLogin) {
                    context.removeToNamed(route: KocekRoute.onboarding.path);
                  } else if (state is AuthOnDashboard) {
                    log("AuthOnDashboard");
                    // context.to(child: DashboardPage.onBloc());
                  } else if (state is AuthOnDashboardWithNotification) {
                    // context.to(child: DashboardPage.onBloc());
                    log("AuthOnDashboardWithNotification");
                    context.alert(label: state.message);
                  }
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        width: 75,
                                        height: 75,
                                        padding: inset(padding * 0.75,
                                            padding * 0.75, padding * 0.75, 0),
                                        child: BouncingAnimation(
                                            duration: duration,
                                            range: 0.2,
                                            child: SvgPicture.asset(
                                                "assets/images/svg_kocek_icon.svg",
                                                color: Colors.black
                                                    .withOpacity(0.75)))),
                                    const Text("\nSedang Memuat\n")
                                  ])))
                    ]))));
  }
}
