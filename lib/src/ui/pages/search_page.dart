import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_bloc.dart';
import 'package:mybook_flutter/src/blocs/search_bloc/search_bloc.dart';
import 'package:mybook_flutter/src/models/book_model.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/book_card.dart';
import 'package:phlox_animations/phlox_animations.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/page_title.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    BookData bookData =
        BlocProvider.of<BookBloc>(context, listen: true).bookRepository.books;
    var searchState = BlocProvider.of<SearchBloc>(context, listen: true);
    var searchQuery = searchState.query;
    List<BookModel> bookListSearched = bookData.searchBooks(searchQuery);
    bool moveup = searchState.moveup;
    return Container(
        color: AppColors.secondary,
        child: Stack(
          children: [
            !moveup
                ? Positioned(
                    top: size.height*0.3,
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: const PageTitle(color: Colors.white, title: "Seach Page"),
                  ))
                : Positioned(
                    bottom: 20,
                    child: PhloxAnimations(
                      duration: const Duration(milliseconds: 500),
                      fromOpacity: 0,
                      toOpacity: 1,
                      child: Container(
                          width: size.width * 0.95,
                          height: size.height - 300,
                          margin: EdgeInsets.only(
                              left: size.width * 0.025,
                              right: size.height * 0.025),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: searchQuery == ""
                              ? const Center(child: Text("No result"))
                              : ListView.builder(
                                  itemCount: bookListSearched.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    BookModel item = bookListSearched[index];
                                    return BookCard(item: item);
                                  })),
                    ),
                  ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: moveup ? 100 : size.height * 0.4,
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: SizedBox(
                    width: size.width * 0.95,
                    child: TextField(
                        onTap: () {
                          if (moveup == false) {
                            searchState.add(const SearchMoveUpEvent(true));
                          }
                        },
                        onChanged: (value) {
                          searchState.add(SearchChangeQueryEvent(value));
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white.withOpacity(0.9),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ), // OutlineInputBorder
                            hintText: "Search here",
                            prefixIcon: const Icon(Icons.search)))),
              ),
            ),
          ],
        ));
  }
}
