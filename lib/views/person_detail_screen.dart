import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meuvies/bloc/shows_bloc.dart';
import 'package:meuvies/data/model/person.dart';
import 'package:meuvies/util/extensions.dart';
import 'package:meuvies/util/values/colors.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/routes.dart';
import 'package:meuvies/util/values/strings.dart';
import 'package:meuvies/util/values/styles.dart';
import 'package:meuvies/widgets/error_widget.dart';
import 'package:meuvies/widgets/loading.dart';
import 'package:meuvies/widgets/show_item.dart';

class PersonDetailScreen extends StatefulWidget {
  final Person person;

  const PersonDetailScreen({Key? key, required this.person}) : super(key: key);

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ShowsBloc>(context).add(GetPersonShows(widget.person.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          toolbarHeight: MediaQuery.of(context).size.height / 3,
          leading: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_sharp),
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(AppDimensions.textDoubleMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    widget.person.name,
                    style: AppTextStyle.header,
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: AppDimensions.textDoubleMargin),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 100 / 150,
                    child: Material(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppDimensions.buttonMargin),
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      color: AppColors.mainGray,
                      child: widget.person.image?.medium.isNotNullOrEmpty() ==
                                  true ||
                              widget.person.image?.original
                                      .isNotNullOrEmpty() ==
                                  true
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const AspectRatio(
                                aspectRatio: 100 / 150,
                              ),
                              errorWidget: (context, url, error) =>
                                  const AspectRatio(
                                aspectRatio: 100 / 150,
                              ),
                              imageUrl: widget.person.image!.medium
                                  .orDefault(widget.person.image!.original),
                            )
                          : const AspectRatio(
                              aspectRatio: 100 / 150,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<ShowsBloc, ShowsState>(
          buildWhen: (prevState, currState) {
            if (currState is ShowsLoading && (prevState is! PeopleLoaded || prevState is! PersonShowsLoaded || prevState is! ShowsLoading)) {
              return false;
            }
            return currState is ShowsLoading ||
                currState is PersonShowsLoaded ||
                currState is ShowError;
          },
          builder: (context, state) {
            if (state is ShowError) {
              return Center(
                child: ErrorDisplayWidget(
                  onRetry: () {
                    BlocProvider.of<ShowsBloc>(context).add(
                      GetPersonShows(widget.person.id),
                    );
                  },
                  message: state.message,
                ),
              );
            } else if (state is PersonShowsLoaded) {
              if (state.shows.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.textDoubleMargin),
                    child: Text(AppStrings.noShowsListed),
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 100 / 150,
                  crossAxisSpacing: AppDimensions.textDoubleMargin,
                  mainAxisSpacing: AppDimensions.textDoubleMargin,
                  crossAxisCount: 3,
                ),
                padding: const EdgeInsets.all(AppDimensions.buttonMargin),
                itemBuilder: (ctx, index) {
                  final show = state.shows[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.showDetails,
                        arguments: show,
                      );
                    },
                    child: ShowItem(
                      show: show,
                    ),
                  );
                },
                itemCount: state.shows.length,
              );
            }
            return const CircularLoading();
          },
        ),
      ),
    );
  }
}
