import 'package:flutter/material.dart';
import 'package:meuvies/util/values/colors.dart';

import 'dimensions.dart';

class AppTextStyle {
  static const header = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.heading,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const title = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.title,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const title2 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.description,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const bodyNormal = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.description,
    fontWeight: FontWeight.normal,
    color: AppColors.lightGray,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.medium,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static const bodySmall = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.small,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static const overline = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.tiny,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static const button = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.medium,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
