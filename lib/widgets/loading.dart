import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meuvies/util/extensions.dart';
import 'package:meuvies/util/values/colors.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/styles.dart';

class CircularLoading extends StatelessWidget {
  final double strokeWidth;
  final Color strokeColor;
  final String? message;

  const CircularLoading(
      {Key? key,
      this.strokeWidth = 4.0,
      this.strokeColor = AppColors.primary,
      this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator.adaptive(
            backgroundColor:
                Platform.isAndroid ? Colors.transparent : strokeColor,
            strokeWidth: strokeWidth,
          ),
          message != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.textDoubleMargin,
                    vertical: AppDimensions.textMargin,
                  ),
                  child: Text(
                    message.orEmpty(),
                    style: AppTextStyle.bodyNormal,
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
