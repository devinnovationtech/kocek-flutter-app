import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/utils/widget/custom_textfield.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import '../state/reset_cubit.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({Key? key}) : super(key: key);

  /// Shortcut for [ResetPage] with [Cubit].
  static Widget onBloc() =>
      BlocProvider(create: (_) => ResetCubit(), child: const ResetPage());

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    var my = KocekShortcut.of(context);
    var scroll = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => scroll.jumpTo(scroll.position.maxScrollExtent));
    var bottombar = buttonHeight * 5 + padding * 2.5;
    var query = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    var minimumHeight = query.size.height - (bottombar + query.viewPadding.top);
    var bottomSheet = Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: const AssetImage(KocekAsset.jpg_login_background),
                opacity: 0.15,
                colorFilter:
                    ColorFilter.mode(my.color.primary, BlendMode.lighten)),
            color: my.color.primary,
            borderRadius: BorderRadius.only(
                topLeft: circular(25), topRight: circular(25))),
        padding: insetAll(padding),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              height: buttonHeight,
              alignment: Alignment.center,
              child: Text("Reset Password",
                  style: my.text.labelMedium
                      ?.copyWith(color: my.color.background, fontSize: 14.0))),
          CustomTextField(
              hintText: "",
              topText: "Email",
              margin: insetOn(bottom: padding),
              topTextStyle: my.text.labelSmall
                  ?.copyWith(color: my.color.background, fontSize: 11.0),
              controller: email),
          BlocConsumer<ResetCubit, ResetStates>(listener: (_, state) {
            if (state is ResetOnError) {
              BugSheet.withModel(state.model,
                      pagePath: "src/authenticate/widget/reset_page.dart",
                      statePath: "src/authenticate/state/reset_cubit.dart")
                  .openWith(context);
            }
          }, builder: (_, state) {
            if (state is ResetOnGoing) {
              return CustomTextButton.loading();
            } else {
              return CustomTextButton(
                  splashColor: my.color.background,
                  highlightColor: transparent,
                  text: "Reset Password",
                  onTap: () => context
                      .read<ResetCubit>()
                      .go(context, email: email.text));
            }
          }),
          Container(
              padding: insetOn(top: padding * 0.5),
              height: buttonHeight,
              child: InkMaterial(
                  splashColor: transparent,
                  onTap: () => context.close(),
                  child: Text("Sudah Punya Akun? Login disini",
                      style: my.text.labelSmall?.copyWith(
                          color: my.color.background, fontSize: 11.0))))
        ]));

    return Scaffold(
        backgroundColor: my.color.background,
        body: SafeArea(
            child:
                CustomScrollView(controller: scroll, reverse: true, slivers: [
          SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              shadowColor: transparent,
              flexibleSpace: bottomSheet,
              toolbarHeight: bottombar,
              backgroundColor: transparent),
          SliverList(
              delegate: SliverChildListDelegate([
            ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: bottombar > query.size.height - 200
                        ? query.size.height
                        : minimumHeight),
                child: Container(
                    alignment: Alignment.center,
                    padding: insetAll(padding),
                    child: Image.asset("assets/Kocek Logo.png", width: 400)))
          ]))
        ])));
  }
}
