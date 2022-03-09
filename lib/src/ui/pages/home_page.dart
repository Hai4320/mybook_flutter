import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_bloc.dart';
import 'package:mybook_flutter/src/models/book_model.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/book_item.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/loadingui.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/page_title.dart';

import '../../blocs/home_bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _tabName = [
    "All",
    "NOVEL",
    "SELF HELP",
    "CHILDREN'S BOOK",
    "WORK STYLE",
    "SCIENCE",
    "OTHERS"
  ];
  late TabController _tabController;
  int typeindex = 0;
  int sortIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: _tabName.length, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<BookBloc, BookState>(
        listener: (context, state) {
          if (state is BookFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            var homeState = BlocProvider.of<HomeBloc>(context, listen: true);
            typeindex = homeState.type;
            sortIndex = homeState.sort;
            if (state is BookLoadingState) {
              return const LoadingUI();
            } else {
              BookData bookData = (state is BookSuccessState)
                  ? state.books
                  : BlocProvider.of<BookBloc>(context).bookRepository.books;
              var bookList =
                  bookData.findByTypeAndSort(_tabController.index, sortIndex);
              return Container(
                  width: size.width,
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PageTitle(
                              title: "Home Page", color: AppColors.black33),
                          IconButton(
                              onPressed: () => _showSelectSortDialog(homeState),
                              icon: const Icon(Icons.filter_list))
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: double.maxFinite,
                          child: TabBar(
                            controller: _tabController,
                            labelColor: AppColors.primary,
                            unselectedLabelColor: Colors.black,
                            isScrollable: true,
                            indicatorColor: AppColors.primary,
                            onTap: (value) =>
                                homeState.add(HomeChangeTypeEvent(value)),
                            tabs: List.generate(_tabName.length,
                                (index) => Tab(text: _tabName[index])),
                          )),
                      Expanded(
                          child: ListView.separated(
                        itemCount: bookList.length,
                        itemBuilder: (BuildContext context, int index) {
                          BookModel item = bookList[index];
                          return BuildBookItem(book: item);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ))
                    ],
                  ));
            }
          },
        ),
      ),
    );
  }

  _showSelectSortDialog(HomeBloc homeState) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sort type"),
          content: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.separated(
              itemCount: typeSort.length,
              itemBuilder: (BuildContext context, int index) => RadioListTile(
                  title: Text(typeSort[index]),
                  value: index,
                  groupValue: sortIndex,
                  onChanged: (value) {
                    Navigator.pop(context);
                    homeState.add(HomeChangeSortEvent(index));
                  }),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        );
      });
}
