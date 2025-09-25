import 'package:flutter/cupertino.dart';

const Color kPrimaryBlue = Color(0xFF1976FF);
const Color kSoftBackground = Color(0xFFF7F8FB);

final CupertinoThemeData appCupertinoTheme = CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: kPrimaryBlue,
  primaryContrastingColor: CupertinoColors.white,
  barBackgroundColor: CupertinoColors.systemGrey6,
  scaffoldBackgroundColor: kSoftBackground,
  textTheme: const CupertinoTextThemeData(
    textStyle: TextStyle(
      fontSize: 16,
      color: CupertinoColors.black,
    ),
    navLargeTitleTextStyle: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: CupertinoColors.black,
    ),
  ),
);

BoxDecoration frostedCard([double radius = 20]) => BoxDecoration(
  color: CupertinoColors.white,
  borderRadius: BorderRadius.circular(radius),
  boxShadow: const [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    )
  ],
);

Widget primaryButton(String text, {VoidCallback? onPressed}) {
  return Container(
    height: 56,
    decoration: BoxDecoration(
      color: kPrimaryBlue,
      borderRadius: BorderRadius.circular(28),
      boxShadow: const [BoxShadow(color: Color(0x331976FF), blurRadius: 20, offset: Offset(0, 8))],
    ),
    child: CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      borderRadius: BorderRadius.circular(28),
      color: kPrimaryBlue,
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: CupertinoColors.white)),
    ),
  );
}