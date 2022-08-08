import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:meuvies/bloc/shows_bloc.dart';
import 'package:meuvies/data/model/episode.dart';
import 'package:meuvies/data/model/show.dart';
import 'package:meuvies/util/extensions.dart';
import 'package:meuvies/util/values/colors.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/strings.dart';
import 'package:meuvies/util/values/styles.dart';
import 'package:meuvies/views/episode_detail_screen.dart';
import 'package:meuvies/widgets/episode_item.dart';
import 'package:meuvies/widgets/error_widget.dart';
import 'package:meuvies/widgets/loading.dart';

class ShowDetailScreen extends StatefulWidget {
  final Show show;

  const ShowDetailScreen({Key? key, required this.show}) : super(key: key);

  @override
  State<ShowDetailScreen> createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ShowsBloc>(context).add(GetShowDetails(widget.show.id));
    BlocProvider.of<ShowsBloc>(context).add(GetShowFavouriteStatus(widget.show.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildHeader(),
            _buildShowDetails(),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildHeader() {
    return SliverAppBar(
      backgroundColor: AppColors.primaryDark,
      expandedHeight: AppDimensions.bigMargin * 15,
      collapsedHeight: kToolbarHeight,
      pinned: true,
      foregroundColor: Colors.white,
      actions: [
        BlocBuilder<ShowsBloc, ShowsState>(
          buildWhen: (_, currState) => currState is ShowFavouriteStatusLoaded,
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                BlocProvider.of<ShowsBloc>(context).add(
                    state is ShowFavouriteStatusLoaded && state.isFavourite
                        ? RemoveShowFromFavourites(widget.show.id)
                        : AddShowToFavourites(widget.show));
              },
              icon: Icon(state is ShowFavouriteStatusLoaded && state.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: widget.show.image?.medium.isNotNullOrEmpty() == true ||
                      widget.show.image?.original.isNotNullOrEmpty() == true
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Container(),
                      imageUrl: widget.show.image!.original
                          .orDefault(widget.show.image!.medium),
                    )
                  : Container(),
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
          ],
        ),
        title: Text(
          widget.show.name,
          style: AppTextStyle.title,
        ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }

  SliverList _buildShowDetails() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.textMargin,
            horizontal: AppDimensions.textDoubleMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Html(
                data: widget.show.summary.orEmpty(),
              ),
              _buildShowtime(),
              _buildGenre(),
              _buildEpisodes(),
            ],
          ),
        ),
        childCount: 1,
      ),
    );
  }

  Widget _buildShowtime() {
    return widget.show.schedule != null &&
            (widget.show.schedule!.time.isNotNullOrEmpty() ||
                widget.show.schedule!.days.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(
              left: AppDimensions.textMargin,
              right: AppDimensions.textMargin,
              bottom: AppDimensions.textMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.showtime,
                  style: AppTextStyle.title,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: AppDimensions.textMargin,
                  children: [
                    Visibility(
                      visible: widget.show.schedule!.time.isNotNullOrEmpty(),
                      child: Chip(
                        label: Text(
                          widget.show.schedule!.time,
                          style: AppTextStyle.button,
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                    ...widget.show.schedule!.days
                        .map(
                          (item) => Chip(
                            label: Text(
                              item,
                              style: AppTextStyle.button,
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildGenre() {
    return widget.show.genres?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.only(
              left: AppDimensions.textMargin,
              right: AppDimensions.textMargin,
              bottom: AppDimensions.textMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.genre,
                  style: AppTextStyle.title,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: AppDimensions.textMargin,
                  children: widget.show.genres!
                      .map(
                        (item) => Chip(
                          label: Text(
                            item,
                            style: AppTextStyle.button,
                          ),
                          backgroundColor: AppColors.accent,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildEpisodes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.textMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.episodes,
            style: AppTextStyle.title,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.textDoubleMargin),
            child: BlocBuilder<ShowsBloc, ShowsState>(
              buildWhen: (prevState, currState) {
                return currState is ShowsLoading ||
                    currState is ShowDetailsLoaded ||
                    currState is ShowError;
              },
              builder: (context, state) {
                if (state is ShowDetailsLoaded) {
                  final episodes = state.show.episodes;
                  if (episodes == null || episodes.isEmpty) {
                    return const Center(
                      child: Text(
                        AppStrings.noEpisodes,
                        style: AppTextStyle.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final episodesGroupMap =
                      groupBy(episodes, (Episode item) => item.season);

                  return Column(
                    children: episodesGroupMap.entries
                        .map((entry) => _buildEpisodesList(entry))
                        .toList(),
                  );
                }

                if (state is ShowError) {
                  return ErrorDisplayWidget(
                    onRetry: () {
                      BlocProvider.of<ShowsBloc>(context).add(
                        GetShowDetails(widget.show.id),
                      );
                    },
                    message: state.message,
                  );
                }

                return const CircularLoading();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodesList(MapEntry<int, List<Episode>> entry) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.all(AppDimensions.textMargin),
        child: Text(
          '${AppStrings.season} ${entry.key}',
          style: AppTextStyle.title2,
          textAlign: TextAlign.center,
        ),
      ),
      children: entry.value
          .map(
            (episode) => InkWell(
              child: EpisodeItem(episode: episode),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  elevation: AppDimensions.textMargin,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.textDoubleMargin),
                      topRight: Radius.circular(AppDimensions.textDoubleMargin),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  builder: (BuildContext buildContext) {
                    return Wrap(
                      children: [
                        EpisodeDetailScreen(
                          episode: episode,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
          .toList(),
    );
  }
}
