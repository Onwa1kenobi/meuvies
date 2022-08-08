import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meuvies/data/model/show.dart';
import 'package:meuvies/data/shows_repository.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/routes.dart';
import 'package:meuvies/util/values/strings.dart';
import 'package:meuvies/util/values/styles.dart';
import 'package:meuvies/widgets/show_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PagingController<int, Show> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    // BlocProvider.of<ShowsBloc>(context).add(GetUserProfiles());
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  final ShowsRepository repository = ShowsRepositoryImpl();

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await repository.getShows(pageKey);
      final isLastPage = newItems.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.meuvies,
          style: AppTextStyle.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.searchShows);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.searchPeople);
            },
            icon: const Icon(
              Icons.people,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.favourites);
            },
            icon: const Icon(
              Icons.favorite_rounded,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.textDoubleMargin,
          0,
          AppDimensions.textDoubleMargin,
          AppDimensions.textDoubleMargin,
        ),
        child: PagedGridView<int, Show>(
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 100 / 150,
            crossAxisSpacing: AppDimensions.textDoubleMargin,
            mainAxisSpacing: AppDimensions.textDoubleMargin,
            crossAxisCount: 2,
          ),
          builderDelegate: PagedChildBuilderDelegate<Show>(
            itemBuilder: (context, show, index) => InkWell(
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
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
