import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meuvies/data/model/episode.dart';
import 'package:meuvies/util/extensions.dart';
import 'package:meuvies/util/values/colors.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/strings.dart';
import 'package:meuvies/util/values/styles.dart';

class EpisodeItem extends StatelessWidget {
  final Episode episode;

  const EpisodeItem({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.textMargin),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Material(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.buttonMargin),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              color: AppColors.mainGray,
              child: episode.image?.medium.isNotNullOrEmpty() == true ||
                      episode.image?.original.isNotNullOrEmpty() == true
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Container(),
                      imageUrl: episode.image!.medium
                          .orDefault(episode.image!.original),
                    )
                  : Container(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(
                AppDimensions.textDoubleMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppStrings.episode} ${episode.number}',
                    style: AppTextStyle.bodyNormal,
                  ),
                  Text(
                    episode.name,
                    style: AppTextStyle.button,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
