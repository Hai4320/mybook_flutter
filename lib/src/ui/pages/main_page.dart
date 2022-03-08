import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_event.dart';
import 'package:mybook_flutter/src/resources/responsitory/book_repo.dart';
import 'package:mybook_flutter/src/ui/pages/home_page.dart';
import 'package:mybook_flutter/src/ui/pages/seach_page.dart';
import 'package:mybook_flutter/src/ui/pages/user_page.dart';
import 'package:mybook_flutter/src/ui/widgets/stateful/drawer_nav.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/center_appbar.dart';

import '../../blocs/book_bloc/book_bloc.dart';
import '../themes/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int tabNumber = 3;
  double navHeight = 70;
  int navbarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
            child: CenterAppBar(title: "MyBooks")
        ),
        extendBodyBehindAppBar: true,
        drawer: const DrawerNavigation(),
        drawerEnableOpenDragGesture: true,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              //BoxShadow
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 0.0),
                blurRadius: 3.0,
                spreadRadius: 3.0,
              ), //BoxShadow
            ],
          ),
          child: Row(children: [
            _buildNavBarItems(0, Icons.home, "home"),
            _buildNavBarItems(1, Icons.search, "home"),
            _buildNavBarItems(2, Icons.person, "home")
          ]),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BookBloc(bookRepository: BookRepository())
                ..add(FetchBookEvent()),
            ),
          ],
          child: _renderPage(),
        ),
      ),
    );
  }

  _buildNavBarItems(int index, IconData icon, String name) {
    var size = MediaQuery.of(context).size;
    bool isActive = (navbarIndex == index);
    return GestureDetector(
      onTap: () {
        setState(() {
          navbarIndex = index;
        });
      },
      child: Container(
        height: navHeight,
        width: size.width / tabNumber,
        decoration: isActive
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 4, color: AppColors.primary),
                ),
                gradient: LinearGradient(colors: [
                  Colors.deepOrangeAccent.withOpacity(0.3),
                  Colors.deepOrangeAccent.withOpacity(0.015),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : const BoxDecoration(),
        child: Icon(
          icon,
          color: isActive ? AppColors.primary: Colors.blueGrey,
        ),
      ),
    );
  }
  _renderPage(){
    switch (navbarIndex){
      case 0: return HomePage();
      case 1: return const SearchPage();
      case 2: return const UserPage();
    }
  }
}
