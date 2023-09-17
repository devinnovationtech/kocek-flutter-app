import 'package:flutter/material.dart';
import 'package:kocek_app/env/themes/text/kocek_text_theme.dart';

class KocekTypography {
  static KocekTextTheme createTextTheme(String fontFamily, Color color) {
    return KocekTextTheme(
      display1regular: TextStyle(
        debugLabel: 'appTextTheme display1regular',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 56,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display1medium: TextStyle(
        debugLabel: 'appTextTheme display1medium',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 56,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display1semibold: TextStyle(
        debugLabel: 'appTextTheme display1semibold',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 56,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display1bold: TextStyle(
        debugLabel: 'appTextTheme display1bold',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 56,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display1extrabold: TextStyle(
        debugLabel: 'appTextTheme display1extrabold',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 56,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display2regular: TextStyle(
        debugLabel: 'appTextTheme display2regular',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 48,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display2medium: TextStyle(
        debugLabel: 'appTextTheme display2medium',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 48,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display2semibold: TextStyle(
        debugLabel: 'appTextTheme display2semibold',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 48,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display2bold: TextStyle(
        debugLabel: 'appTextTheme display2bold',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 48,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      display2extrabold: TextStyle(
        debugLabel: 'appTextTheme display2extrabold',
        color: color,
        // Replace 'color' with your desired color
        fontSize: 48,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      headline1Regular: TextStyle(
        debugLabel: 'Headline 1 Regular',
        fontSize: 40,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline1Medium: TextStyle(
        debugLabel: 'Headline 1 Medium',
        fontSize: 40,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline1SemiBold: TextStyle(
        debugLabel: 'Headline 1 SemiBold',
        fontSize: 40,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline1Bold: TextStyle(
        debugLabel: 'Headline 1 Bold',
        fontSize: 40,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline1ExtraBold: TextStyle(
        debugLabel: 'Headline 1 ExtraBold',
        fontSize: 40,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline2Regular: TextStyle(
        debugLabel: 'Headline 2 Regular',
        fontSize: 32,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline2Medium: TextStyle(
        debugLabel: 'Headline 2 Medium',
        fontSize: 32,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline2SemiBold: TextStyle(
        debugLabel: 'Headline 2 SemiBold',
        fontSize: 32,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline2Bold: TextStyle(
        debugLabel: 'Headline 2 Bold',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline2ExtraBold: TextStyle(
        debugLabel: 'Headline 2 ExtraBold',
        fontSize: 32,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline3Regular: TextStyle(
        debugLabel: 'Headline 3 Regular',
        fontSize: 28,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline3Medium: TextStyle(
        debugLabel: 'Headline 3 Medium',
        fontSize: 28,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline3SemiBold: TextStyle(
        debugLabel: 'Headline 3 SemiBold',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline3Bold: TextStyle(
        debugLabel: 'Headline 3 Bold',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline3ExtraBold: TextStyle(
        debugLabel: 'Headline 3 ExtraBold',
        fontSize: 28,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline4Regular: TextStyle(
        debugLabel: 'Headline 4 Regular',
        fontSize: 24,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline4Medium: TextStyle(
        debugLabel: 'Headline 4 Medium',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline4SemiBold: TextStyle(
        debugLabel: 'Headline 4 SemiBold',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline4Bold: TextStyle(
        debugLabel: 'Headline 4 Bold',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      headline4ExtraBold: TextStyle(
        debugLabel: 'Headline 4 ExtraBold',
        fontSize: 24,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading1Regular: TextStyle(
        debugLabel: 'Subheading 1 Regular',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading1Medium: TextStyle(
        debugLabel: 'Subheading 1 Medium',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading1SemiBold: TextStyle(
        debugLabel: 'Subheading 1 SemiBold',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading1Bold: TextStyle(
        debugLabel: 'Subheading 1 Bold',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading1ExtraBold: TextStyle(
        debugLabel: 'Subheading 1 ExtraBold',
        fontSize: 20,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading2Regular: TextStyle(
        debugLabel: 'Subheading 2 Regular',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading2Medium: TextStyle(
        debugLabel: 'Subheading 2 Medium',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading2SemiBold: TextStyle(
        debugLabel: 'Subheading 2 SemiBold',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading2Bold: TextStyle(
        debugLabel: 'Subheading 2 Bold',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      subheading2ExtraBold: TextStyle(
        debugLabel: 'Subheading 2 ExtraBold',
        fontSize: 18,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph1Regular: TextStyle(
        debugLabel: 'Paragraph 1 Regular',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph1Medium: TextStyle(
        debugLabel: 'Paragraph 1 Medium',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph1SemiBold: TextStyle(
        debugLabel: 'Paragraph 1 SemiBold',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph1Bold: TextStyle(
        debugLabel: 'Paragraph 1 Bold',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph1ExtraBold: TextStyle(
        debugLabel: 'Paragraph 1 ExtraBold',
        fontSize: 16,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph2Regular: TextStyle(
        debugLabel: 'Paragraph 2 Regular',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph2Medium: TextStyle(
        debugLabel: 'Paragraph 2 Medium',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph2SemiBold: TextStyle(
        debugLabel: 'Paragraph 2 SemiBold',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph2Bold: TextStyle(
        debugLabel: 'Paragraph 2 Bold',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      paragraph2ExtraBold: TextStyle(
        debugLabel: 'Paragraph 2 ExtraBold',
        fontSize: 14,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label1Regular: TextStyle(
        debugLabel: 'Label 1 Regular',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label1Medium: TextStyle(
        debugLabel: 'Label 1 Medium',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label1SemiBold: TextStyle(
        debugLabel: 'Label 1 SemiBold',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label1Bold: TextStyle(
        debugLabel: 'Label 1 Bold',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label1ExtraBold: TextStyle(
        debugLabel: 'Label 1 ExtraBold',
        fontSize: 12,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label2Regular: TextStyle(
        debugLabel: 'Label 2 Regular',
        fontSize: 10,
        fontWeight: FontWeight.w400,
        // Regular
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label2Medium: TextStyle(
        debugLabel: 'Label 2 Medium',
        fontSize: 10,
        fontWeight: FontWeight.w500,
        // Medium
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label2SemiBold: TextStyle(
        debugLabel: 'Label 2 SemiBold',
        fontSize: 10,
        fontWeight: FontWeight.w600,
        // SemiBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label2Bold: TextStyle(
        debugLabel: 'Label 2 Bold',
        fontSize: 10,
        fontWeight: FontWeight.w700,
        // Bold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
      label2ExtraBold: TextStyle(
        debugLabel: 'Label 2 ExtraBold',
        fontSize: 10,
        fontWeight: FontWeight.w800,
        // ExtraBold
        fontFamily: fontFamily,
        height: 1.4,
        // 140% line height
        letterSpacing: 0,
        // You specified 0 for letterSpacing in the JSON data
        decoration: TextDecoration.none, // None for text decoration
      ),
    );
  }
}
