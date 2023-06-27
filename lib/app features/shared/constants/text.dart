import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppText {
  //Android text constants
  static const titleTextForAndroid = "What would you like to do today?";
  static const titleTextFontSizeForAndroid = 20.0;

  static final cardTextStyle =
  GoogleFonts.roboto(fontSize: 20, color: Colors.white);

  static final taskListHeadingTextStyle = GoogleFonts.poppins(
      fontSize: 24, color: AppColors.darkAndroid, fontWeight: FontWeight.w600);

  static final taskListTileHeadingTextStyle = GoogleFonts.roboto(
      fontSize: 18,
      // fontFamily:,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF3E3C3F));

  //iOS text constants
  static const titleTextForIOS = "Sample App";
  static const titleTextFontSizeForIOS = 22.0;

  static final homHeadingTextStyle = GoogleFonts.poppins(
      fontSize: 32, color: AppColors.primaryIOS, fontWeight: FontWeight.w600);
  static final tasksHeadingTextStyle = GoogleFonts.poppins(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryIOS
  );
  static final tasksSubHeadingTextStyle = GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.greyScale5
  );

  static final tasksTileHeadingTextStyle = GoogleFonts.poppins(
      fontSize: 20,
      color: AppColors.greyScale2
  );

  static final tasksTileSubHeadingTextStyle = GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.greyScale5
  );
}
