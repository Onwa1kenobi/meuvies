import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meuvies/bloc/shows_bloc.dart';
import 'package:meuvies/data/model/person.dart';
import 'package:meuvies/data/model/show.dart';
import 'package:meuvies/data/shows_repository.dart';
import 'package:meuvies/util/values/colors.dart';
import 'package:meuvies/util/values/routes.dart';
import 'package:meuvies/util/values/styles.dart';
import 'package:meuvies/views/favourites_screen.dart';
import 'package:meuvies/views/home_screen.dart';
import 'package:meuvies/views/person_detail_screen.dart';
import 'package:meuvies/views/search_people_screen.dart';
import 'package:meuvies/views/search_shows_screen.dart';
import 'package:meuvies/views/show_detail_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(ShowsRepository.LOCAL_STORAGE_BOX);
  final ShowsRepository showsRepository = ShowsRepositoryImpl();
  runApp(
    BlocProvider(
      create: (context) => ShowsBloc(showsRepository),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: AppColors.primaryDark,
        primaryColorDark: AppColors.primaryDark,
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyText1: AppTextStyle.bodyNormal,
          bodyText2: AppTextStyle.bodyNormal,
          button: AppTextStyle.button,
          caption: AppTextStyle.overline,
          overline: AppTextStyle.overline,
          subtitle1: AppTextStyle.title,
          subtitle2: AppTextStyle.bodySmall,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.accent,
        ),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.landing,
      routes: {
        AppRoutes.landing: (context) {
          return const HomeScreen();
        },
        AppRoutes.home: (context) {
          return const HomeScreen();
        },
        AppRoutes.searchShows: (context) {
          return const SearchScreen();
        },
        AppRoutes.favourites: (context) {
          return const FavouritesScreen();
        },
        AppRoutes.showDetails: (context) {
          final Show show = ModalRoute.of(context)?.settings.arguments as Show;
          return ShowDetailScreen(show: show);
        },
        AppRoutes.searchPeople: (context) {
          return const SearchPeopleScreen();
        },
        AppRoutes.personDetails: (context) {
          final Person person = ModalRoute.of(context)?.settings.arguments as Person;
          return PersonDetailScreen(person: person);
        },
      },
    );
  }
}
