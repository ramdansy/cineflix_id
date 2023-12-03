import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../misc/extensions/build_context_extension.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/bottom_nav_bar_item.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) => setState(() {
              selectedPage = value;
            }),
            children: const [
              Center(
                child: Text('Movies Page'),
              ),
              Center(
                child: Text('Ticket Page'),
              ),
              Center(
                child: Text('Profile Page'),
              ),
            ],
          ),
          BottomNavBar(
            items: [
              BottomNavBarItem(
                  index: 0,
                  isSelected: selectedPage == 0,
                  title: 'Home',
                  image: 'assets/images/movie.png',
                  selectedImage: 'assets/images/movie-selected.png'),
              BottomNavBarItem(
                  index: 1,
                  isSelected: selectedPage == 1,
                  title: 'Ticket',
                  image: 'assets/images/ticket.png',
                  selectedImage: 'assets/images/ticket-selected.png'),
              BottomNavBarItem(
                  index: 2,
                  isSelected: selectedPage == 2,
                  title: 'Profile',
                  image: 'assets/images/profile.png',
                  selectedImage: 'assets/images/profile-selected.png')
            ],
            onTap: (index) {
              selectedPage = index;

              pageController.animateToPage(selectedPage,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
            selectedIndex: 0,
          )
        ],
      ),
    );
  }
}
