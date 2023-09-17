import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/features/authenticate/state/login_cubit.dart';
import 'package:kocek_app/features/authenticate/widget/otp_page.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/utils/widget/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscure = true;
  TextEditingController phoneNumber = TextEditingController();
  ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => scroll.jumpTo(scroll.position.maxScrollExtent));
  }

  @override
  void dispose() {
    phoneNumber.dispose();
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.close(),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: SvgPicture.asset(
                          "assets/images/svg_icon_arrow_right.svg",
                          width: 16,
                          color: my.kocekColor.neutral900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SvgPicture.asset(
                      'assets/images/svg_kocek_logo.svg',
                      width: 90,
                      height: 27,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/images/svg_select_language.svg',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Login or Register",
              style: my.kocekText.headline4Bold,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Just with your mobile phone number.",
              style: my.kocekText.paragraph2Regular.copyWith(
                color: my.color.onBackground.withOpacity(0.5),
              ),
            ),
            CustomTextField(
                hintText: "+62 811 2222 3333",
                topText: "Number Phone",
                height: 55,
                inputType: TextInputType.phone,
                margin: insetOn(bottom: padding),
                topTextStyle: my.text.labelSmall
                    ?.copyWith(color: my.color.background, fontSize: 11.0),
                controller: phoneNumber),
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
                    highlightColor: transparent,
                    text: "Next",
                    onTap: () => context.toNamed(route: KocekRoute.otp.path));
              }
            }),
          ]),
        )));
  }
}
