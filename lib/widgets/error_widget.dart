import 'package:flutter/material.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/strings.dart';
import 'package:meuvies/util/values/styles.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;

  const ErrorDisplayWidget(
      {Key? key, required this.onRetry, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.textDoubleMargin,
          vertical: AppDimensions.textMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              AppStrings.errorOccurred,
              style: AppTextStyle.title,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.textMargin,
              ),
              child: Text(
                message,
                style: AppTextStyle.bodyNormal,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text(
                AppStrings.retry,
                style: AppTextStyle.button,
              ),
            )
          ],
        ),
      ),
    );
  }
}
