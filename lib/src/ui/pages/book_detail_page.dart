import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_bloc.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/models/book_model.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/transparent_appbar.dart';
import 'package:phlox_animations/phlox_animations.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  final BookModel book;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    var book = widget.book;
    var size = MediaQuery.of(context).size;
    var bookBloc = BlocProvider.of<BookBloc>(context, listen: true);
    List<Map<String, String>> data = [
      {
        "name": "Type",
        "value": book.type,
      },
      {
        "name": "Status",
        "value": book.status,
      },
      {
        "name": "Company",
        "value": book.company,
      },
      {
        "name": "Publishing",
        "value": book.publishingCompany,
      },
      
    ];
    _handleLikeBook() {
      if (book.isLiked == true) {
        book.isLiked = false;
        book.like--;
      } else {
        book.like++;
        book.isLiked = true;
      }
      setState(() {});
    }
    _handleSaveBook(){
      book.isSaved = !book.isSaved;
      setState(() {});
    }
    return Scaffold(
        appBar: TransparentAppBar("Book", Colors.white),
        extendBodyBehindAppBar: true,
        body: Container(
            color: AppColors.secondary,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 2,
                  right: 2,
                  child: PhloxAnimations(
                    duration: const Duration(milliseconds: 800),
                    fromOpacity: 0,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 120, left: 4, right: 4),
                      height: size.height - 150,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: ListView(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 20,
                          ),
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                book.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: RichText(
                                  text: TextSpan(
                                      text: "By: ",
                                      style:
                                          TextStyle(color: AppColors.black33),
                                      children: [
                                    TextSpan(
                                        text: book.author,
                                        style: TextStyle(
                                            color: AppColors.blue,
                                            fontStyle: FontStyle.italic)),
                                  ])),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        book.view.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      Icon(Icons.visibility,
                                          color: AppColors.blue, size: 15),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                TextButton(
                                  onPressed: _handleLikeBook,
                                  child: Row(children: [
                                    Text(
                                      book.like.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.like,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Icon(
                                        book.isLiked == true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.like,
                                        size: 15),
                                  ]),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: size.width*0.7,
                                  child: ElevatedButton.icon(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.primary
                                    ),
                                    icon: const Icon(Icons.auto_stories), 
                                    label: const Text("Read PDF"),
                                    

                                  ),
                                  
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: size.width*0.7,
                                  child: ElevatedButton.icon(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.primary
                                    ),
                                    icon: const Icon(Icons.headphones), 
                                    label: const Text("Listen Audio"),
                                    

                                  ),
                                  
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: size.width*0.7,
                                  child: ElevatedButton.icon(
                                    onPressed: _handleSaveBook,
                                    icon: Icon(book.isSaved?Icons.bookmark: Icons.bookmark_border), 
                                    label: Text(book.isSaved? "Saved": "Save Now!"),
                                    

                                  ),
                                  
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.all(8),
                              child: Text("  "+book.description),
                            ),
                            DataTable(
                                columns: const [
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text(""))
                                ],
                                rows: List.generate(
                                    data.length,
                                    (index) => DataRow(cells: [
                                          DataCell(Text(
                                            data[index]["name"].toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17),
                                          )),
                                          DataCell(Text(
                                              data[index]["value"].toString())),
                                        ]))),
                            
                          ]),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  child: Container(
                    color: Colors.transparent,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PhloxAnimations(
                          duration: const Duration(milliseconds: 500),
                          fromY: size.height * 0.5,
                          fromOpacity: 0,
                          child: Container(
                              alignment: Alignment.center,
                              width: 190 * 1.2,
                              height: 130 * 1.2,
                              child: book.imageUrl == ""
                                  ? Image.asset(AppImages.img_default,
                                      fit: BoxFit.cover)
                                  : Image.network(book.imageUrl,
                                      fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
