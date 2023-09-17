import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/features/authenticate/widget/login_page.dart';
import 'package:kocek_app/features/onboarding/widget/onboard_content_widget.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/env/widget/page_view/kocek_page_view.dart';

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoard> boardList = [
  OnBoard(
    image: "assets/images/svg_boarding_one.svg",
    title: "Hello There, Welcome to Kocek!",
    description:
        "Get a sophisticated pocket wallet with Kocek! Enjoy a variety of services in just one application.",
  ),
  OnBoard(
    image: "assets/images/svg_boarding_two.svg",
    title: "All is sorted and divided!",
    description:
        "Wallets become more organized, make yours now with pocket features!",
  ),
  OnBoard(
    image: "assets/images/svg_boarding_three.svg",
    title: "Everything is guaranteed safe!",
    description:
        "High-security system and money-back guarantee (conditions apply). Register Now!",
  ),
];

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    return Scaffold(
      backgroundColor: my.color.background,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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
            const SizedBox(
              height: 50,
            ),
            KocekPageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              itemCount: boardList.length,
              controller: _pageController,
              itemBuilder: (context, index) => OnBoardContentWidget(
                heading: boardList[index].title,
                content: boardList[index].description,
                image: boardList[index].image,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    boardList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomTextButton(
              splashColor: my.kocekColor.primary700.withOpacity(0.2),
              color: my.kocekColor.primary500,
              textStyle: my.kocekText.paragraph1SemiBold.copyWith(
                color: my.color.background,
              ),
              icon: _pageIndex < boardList.length - 1
                  ? null
                  : SvgPicture.asset(
                      "assets/images/svg_icon_arrow_right.svg",
                      width: 16,
                      color: Colors.white,
                    ),
              highlightColor: transparent,
              text: _pageIndex < boardList.length - 1
                  ? "Next"
                  : "Login and Register",
              onTap: () => _pageIndex < boardList.length - 1 ? _pageController.animateToPage(
                _pageIndex < boardList.length ? _pageIndex + 1 : 0,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeIn,
              ) : context.toNamed(route: KocekRoute.loginOrRegister.path),
            ),
          ],
        ),
      )),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 10,
      height: 10,
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        color: isActive ? my.kocekColor.primary500 : my.kocekColor.surface900,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
