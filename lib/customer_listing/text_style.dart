import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(
    fontFamily: 'Poppins'
  );
  static final smallTextStyle = commonTextStyle.copyWith(
    color: const Color(0xff6573d0),
    fontSize: 9.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xff6573d0),
    fontSize: 14.0,
      fontWeight: FontWeight.w400
  );
  static final titleTextStyle = baseTextStyle.copyWith(
      color: const Color(0xff6573d0),
    fontSize: 16.0,
    fontWeight: FontWeight.w600
  );
  static final headerTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400
  );

  static final titleTextStyleBlack = baseTextStyle.copyWith(
      color:  Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w600
  );

  static final titleTextStyleOrange = baseTextStyle.copyWith(
      color:  Colors.deepOrange,
      fontSize: 16.0,
      fontWeight: FontWeight.w600
  );

  static final smallTextStyleOrange = commonTextStyle.copyWith(
    color:  Colors.deepOrange,
    fontSize: 9.0,
  );
}