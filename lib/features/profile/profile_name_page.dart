import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/features/authenticate/state/login_cubit.dart';
import 'package:kocek_app/features/authenticate/widget/verification_page.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/utils/widget/custom_textfield.dart';

class ProfileNamePage extends StatefulWidget {
  const ProfileNamePage({Key? key}) : super(key: key);

  @override
  State<ProfileNamePage> createState() => _ProfileNamePageState();
}

class _ProfileNamePageState extends State<ProfileNamePage> {
  bool obscure = true;
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
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
                    Text(
                      "Step 1 From 3",
                      style: my.kocekText.paragraph2Regular.copyWith(
                        color: my.kocekColor.neutral500
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.28,
                      height: 8,
                      decoration: BoxDecoration(
                        color: my.kocekColor.primary500,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.28,
                      height: 8,
                      decoration: BoxDecoration(
                        color: my.kocekColor.surface900,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.28,
                      height: 8,
                      decoration: BoxDecoration(
                        color: my.kocekColor.surface900,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Write your full name",
                  style: my.kocekText.subheading2Bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "so it's easy to recognize when doing transfers",
                  style: my.kocekText.paragraph2Regular.copyWith(
                    color: my.kocekColor.neutral500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    hintText: "Nama Kamu",
                    height: 55,
                    inputType: TextInputType.name,
                    margin: insetOn(bottom: padding),
                    controller: name),
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
                        onTap: () {
                          if (name.text.isEmpty) {
                            context.alert(label: "Nama tidak boleh kosong",color: my.color.error);
                          } else {
                            context.to(child: VerificationPage.onBloc());
                          }
                        }
                    );
                  }
                }),
              ]),
            )));
  }
}
