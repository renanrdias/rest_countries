import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Card Dimentions = 530 x 678
// Flag Dimentions = 530 x 322
// Magin between Flag and Country Name 60px
// Magin between Country Name and Country Info 50px
// Country's info height = 120

// width = x/750
//height = y/6610

const kScaffoldBackgroundColor = Color(0xff212c36);

const kCardBackgroundColor = Color(0xff2b3743);

final kCountryNameStyle = GoogleFonts.nunitoSans(
  fontSize: 24,
  fontWeight: FontWeight.w800,
  color: const Color(0xfffffffc),
);

final kCountryInfoItem = GoogleFonts.nunitoSans(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: const Color(0xfffeffff),
);

final kCountryInfoValue = GoogleFonts.nunitoSans(
  color: const Color(0xffced8e2),
  fontSize: 18,
  fontWeight: FontWeight.w300,
);

final kAppBarLeading = GoogleFonts.nunitoSans(
  fontSize: 15,
  color: const Color(0xfffeffff),
  fontWeight: FontWeight.w800,
);
final kAppBarThemeMode = GoogleFonts.nunitoSans(
  fontSize: 15,
  color: const Color(0xfffeffff),
  fontWeight: FontWeight.w600,
);

const kAppBarBackgroundColor = Color(0xff2b3743);
