import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/env/widget/pin_field/kocek_pin_code_fields.dart';
import 'package:kocek_app/features/authenticate/state/login_cubit.dart';
import 'package:kocek_app/features/authenticate/widget/verification_page.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool obscure = true;
  TextEditingController pinCodeController = TextEditingController();
  ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => scroll.jumpTo(scroll.position.maxScrollExtent));
  }

  @override
  void dispose() {
    pinCodeController.dispose();
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
              "We just sent you SMS",
              style: my.kocekText.headline4Bold,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "To log in, enter the OTP code we sent to \n +6281229094887",
              style: my.kocekText.paragraph2Regular.copyWith(
                color: my.color.onBackground.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            KocekPinField(
              autoDisposeControllers: false,
              appContext: context,
              length: 5,
              textStyle: my.kocekText.paragraph1Bold,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              enableActiveFill: false,
              autoFocus: true,
              enablePinAutofill: false,
              errorTextSpace: 16,
              showCursor: true,
              cursorColor: my.color.primary,
              obscureText: false,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                fieldHeight: 58,
                fieldWidth: 58,
                borderWidth: 1,
                borderRadius: BorderRadius.circular(12),
                shape: PinCodeFieldShape.box,
                activeColor: Color(0xFFECEFF5),
                inactiveColor: Color(0xFFECEFF5),
                selectedColor: my.color.primary,
                activeFillColor: Color(0xFFECEFF5),
                inactiveFillColor: Color(0xFFECEFF5),
                selectedFillColor: my.color.primary,
              ),
              controller: pinCodeController,
              onChanged: (_) {},
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Haven't received the code yet? \n Resend in 59 seconds.",
                textAlign: TextAlign.center,
                style: my.kocekText.paragraph2Regular.copyWith(
                  color: my.color.onBackground.withOpacity(0.5),
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
                    highlightColor: transparent,
                    text: "Next",
                    onTap: () => context.to(child: VerificationPage.onBloc()));
              }
            }),
          ]),
        )));
  }
}
