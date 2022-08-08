import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:meuvies/data/model/episode.dart';
import 'package:meuvies/util/extensions.dart';
import 'package:meuvies/util/values/colors.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/strings.dart';
import 'package:meuvies/util/values/styles.dart';

class EpisodeDetailScreen extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailScreen({Key? key, required this.episode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.lightBlack,
      child: Column(
        children: [
          episode.image?.medium.isNotNullOrEmpty() == true ||
                  episode.image?.original.isNotNullOrEmpty() == true
              ? CachedNetworkImage(
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Container(),
                  imageUrl:
                      episode.image!.original.orDefault(episode.image!.medium),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.textDoubleMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Wrap(
                  spacing: AppDimensions.textMargin,
                  children: [
                    Chip(
                      label: Text(
                        '${AppStrings.season} ${episode.season}',
                        style: AppTextStyle.button,
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                    Chip(
                      label: Text(
                        '${AppStrings.episode} ${episode.number}',
                        style: AppTextStyle.button,
                      ),
                      backgroundColor: AppColors.accent,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.textMargin),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.textMargin),
                  child: Text(
                    episode.name,
                    style: AppTextStyle.header,
                  ),
                ),
                Html(
                  data: episode.summary.orEmpty(),
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
