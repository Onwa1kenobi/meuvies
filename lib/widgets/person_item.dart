import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meuvies/data/model/person.dart';
import 'package:meuvies/data/model/show.dart';
import 'package:meuvies/util/extensions.dart';
import 'package:meuvies/util/values/colors.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/styles.dart';

class PersonItem extends StatelessWidget {
  final Person person;

  const PersonItem({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 100 / 150,
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.buttonMargin),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        color: AppColors.mainGray,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: person.image?.medium.isNotNullOrEmpty() == true ||
                  person.image?.original.isNotNullOrEmpty() == true
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const AspectRatio(
                        aspectRatio: 100 / 150,
                      ),
                      errorWidget: (context, url, error) =>
                          const AspectRatio(
                        aspectRatio: 100 / 150,
                      ),
                      imageUrl: person.image!.medium
                          .orDefault(person.image!.original),
                    )
                  : const AspectRatio(
                      aspectRatio: 100 / 150,
                    ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black45, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: AppDimensions.textQuarterMargin,
              left: AppDimensions.textHalfMargin,
              right: AppDimensions.textHalfMargin,
              child: Padding(
                padding:
                    const EdgeInsets.all(AppDimensions.textHalfMargin),
                child: Text(
                  person.name,
                  style: AppTextStyle.title,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
