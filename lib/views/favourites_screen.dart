import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meuvies/bloc/shows_bloc.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/routes.dart';
import 'package:meuvies/util/values/strings.dart';
import 'package:meuvies/util/values/styles.dart';
import 'package:meuvies/widgets/show_item.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    BlocProvider.of<ShowsBloc>(context).add(const GetFavouriteShows());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.favourites,
            style: AppTextStyle.title,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<ShowsBloc, ShowsState>(
          builder: (context, state) {
            final shows = BlocProvider.of<ShowsBloc>(context).favouriteShows;
            if (shows.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.textDoubleMargin),
                  child: Text(AppStrings.noFavouriteShows),
                ),
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 100 / 150,
                crossAxisSpacing: AppDimensions.textDoubleMargin,
                mainAxisSpacing: AppDimensions.textDoubleMargin,
                crossAxisCount: 2,
              ),
              padding: const EdgeInsets.all(AppDimensions.textDoubleMargin),
              itemBuilder: (ctx, index) {
                final show = shows[index];
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
              itemCount: shows.length,
            );
          },
        ),
      ),
    );
  }
}
