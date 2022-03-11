import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/models/book_model.dart';

class BookCard extends StatelessWidget {
  BookCard({Key? key, required this.item}) : super(key: key);
  BookModel item;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: item.loadImageUrl(),
        builder: (context, image) {
          return Card(
            child: ListTile(
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
