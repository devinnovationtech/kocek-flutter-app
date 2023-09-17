import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';

class OnBoardContentWidget extends StatelessWidget {
  const OnBoardContentWidget({
    Key? key,
    required this.heading,
    required this.content,
    required this.image,
  }) : super(key: key);

  final String heading, content, image;

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);
    return Column(
      children: [
        SvgPicture.asset(
          image,
          width: 274,
          height: 300,
          fit: BoxFit.fitHeight,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          heading,
          style: my.kocekText.subheading1Bold,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: my.kocekText.paragraph2Regular.copyWith(
              color: my.color.onBackground.withOpacity(0.5),
            ),
          ),
        )
      ],
    );
  }
}
