import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/features/authenticate/state/login_cubit.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();

  /// Shortcut for [VerificationPage] with [Cubit].
  static Widget onBloc() => MultiBlocProvider(
      providers: [BlocProvider(create: (_) => LoginCubit())],
      child: const VerificationPage());
}

class _VerificationPageState extends State<VerificationPage> {
  bool obscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    return Scaffold(
        backgroundColor: my.color.background,
        body: SafeArea(
            child: Padding(
          padding: insetAll(padding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/svg_kocek_logo.svg',
                  width: 90,
                  height: 27,
                  fit: BoxFit.contain,
                ),
                SvgPicture.asset(
                  'assets/images/svg_select_language.svg',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: Expanded(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/svg_verification_success.svg',
                      width: 117,
                      height: 117,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Verification Successful!",
                      style: my.kocekText.headline4Bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Now  let’s complete your profile now for better security and user experience.",
                      textAlign: TextAlign.center,
                      style: my.kocekText.paragraph2Regular.copyWith(
                        color: my.color.onBackground.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            BlocConsumer<LoginCubit, LoginStates>(listener: (_, state) async {
              if (state is LoginOnError) {
                BugSheet.withModel(state.model,
                        pagePath: "src/authenticate/widget/login_page.dart",
                        statePath: "src/authenticate/state/login_cubit.dart")
                    .openWith(context);
              } else if (state is LoginOnFailed) {
                context.alert(label: state.message);
              } else if (state is LoginOnSucceed) {
                log('message');
              }
            }, builder: (_, state) {
              if (state is LoginOnGoing) {
                return CustomTextButton.loading();
              } else {
                return CustomTextButton(
                    splashColor: my.kocekColor.primary700.withOpacity(0.2),
                    color: my.kocekColor.primary500,
                    textStyle: my.kocekText.paragraph1SemiBold.copyWith(
                      color: my.color.background,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/svg_icon_arrow_right.svg",
                      width: 16,
                      color: Colors.white,
                    ),
                    highlightColor: transparent,
                    text: "Complete Your Profile",
                    onTap: () => context.toNamed(route: KocekRoute.profileName.path)
                );
              }
            }),
          ]),
        )));
  }
}
