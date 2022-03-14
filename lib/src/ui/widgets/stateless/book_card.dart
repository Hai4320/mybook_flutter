import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/models/book_model.dart';
import 'package:mybook_flutter/src/ui/pages/book_detail_page.dart';

class BookCard extends StatelessWidget {
  BookCard({Key? key, required this.item}) : super(key: key);
  BookModel item;

  @override
  Widget build(BuildContext context) {
    _handleOpenBook(BookModel book) async{
      const transitionDuration = Duration(milliseconds: 500);
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: transitionDuration,
          reverseTransitionDuration: transitionDuration,
          pageBuilder: (_, animation, ___) {
            return FadeTransition(
              opacity: animation,
              child: BookDetailPage(book: book),
            );
          },
        ),
      );
    }
    return FutureBuilder(
        future: item.loadImageUrl(),
        builder: (context, image) {
          return Card(
            child: ListTile(
              onTap: ()=>_handleOpenBook(item),
              title: Text(item.title),
              subtitle: Text(item.author),
              leading: item.imageUrl == ""
                  ? Image.asset(AppImages.img_default)
                  : Image.network(item.imageUrl),
            ),
          );
        });
  }
}
