import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

import 'package:hollybrary/screens/favorite_screen/favorite_screen.dart';
import 'package:hollybrary/screens/movie_info_screen/movie_Info_screen.dart';
import 'package:hollybrary/screens/search_screen/search_screen.dart';
import 'package:hollybrary/utils/app_animation.dart';
import 'package:hollybrary/widgets/bottom_tab_bar.dart';
import 'package:hollybrary/screens/cast_info_screen/cast_info_screen.dart';
import 'package:hollybrary/screens/home_screen/home_screen.dart';
import 'package:hollybrary/screens/season_info_screen/season_details_screen.dart';
import 'package:hollybrary/screens/tvshow_info_screen/tvshow_info_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    handleUniLinks();
    super.initState();
  }

  void handleUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        var link = initialLink;
        var id = link.split("-")[0];
        var type = link.split("-")[1];
        if (type == "movie") {
          pushNewScreen(
            context,
            MovieDetailsScreen(
              id: id,
              backdrop: '',
            ),
          );
        } else if (type == "tv") {
          pushNewScreen(
            context,
            SerieDetailScreen(id: id, backdrop: ''),
          );
        } else if (type == 'cast') {
          pushNewScreen(
            context,
            CastScreen(
              id: id,
              backdrop: '',
            ),
          );
        } else if (type == 'season') {
          var snum = link.split("-")[2];
          pushNewScreen(
            context,
            SeasonDetailScreen(
              id: id,
              backdrop: '',
              snum: snum,
            ),
          );
        }
      }
      // ignore: empty_catches
    } on Exception {}
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    buildCurrentPage(int i) {
      switch (i) {
        case 0:
          return const HomeScreen();
        case 1:
          return const SearchPage();
        case 2:
          return const FavoriteScreen();
        default:
          return Container();
      }
    }

    return Scaffold(
      body: buildCurrentPage(currentIndex),
      bottomNavigationBar: CustomCupertinoTabBar(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade800,
            width: .4,
          ),
        ),
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        inactiveColor: Colors.grey,
        activeColor: Theme.of(context).primaryColor,
        currentIndex: currentIndex,
        iconSize: 26.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            activeIcon: Icon(
              CupertinoIcons.house_fill,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            activeIcon: Icon(
              CupertinoIcons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Favorites',
            activeIcon: Icon(
              CupertinoIcons.heart_solid,
            ),
          ),
        ],
      ),
    );
  }
}
