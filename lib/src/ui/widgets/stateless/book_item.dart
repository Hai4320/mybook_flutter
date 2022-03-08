import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/models/book_model.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';

class BuildBookItem extends StatefulWidget {
  const BuildBookItem({Key? key, required this.book}) : super(key: key);
  final BookModel book;

  @override
  State<BuildBookItem> createState() => _BuildBookItemState();
}

class _BuildBookItemState extends State<BuildBookItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.book.loadImageUrl(),
        builder: (context, snapshot) {
          return Container(
            height: 200,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2.0, 4.0),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  ),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                      height: 190,
                      width: 130,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: widget.book.image == ""
                          ? Image.asset(AppImages.img_default)
                          : (widget.book.imageUrl == "")
                              ? const Center(child: CircularProgressIndicator())
                              : Image.network(widget.book.imageUrl, fit: BoxFit.cover)),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Text(
                              widget.book.title, 
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis
                              ),
                              ),
                          ),
                          SizedBox(
                            height: 25,
                            child: RichText(
                              text: TextSpan(
                                text: "By: ",
                                style: TextStyle(
                                  color: AppColors.black33
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.book.author,
                                    style: TextStyle(
                                      color: AppColors.blue,
                                      fontStyle: FontStyle.italic
                                    )
                                    ),
                                ]
                              )
                            )
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.book.view.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blue,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Icon(
                                  Icons.visibility, 
                                  color: AppColors.blue, 
                                  size: 15
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  widget.book.like.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.like,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Icon(
                                  Icons.favorite, 
                                  color: AppColors.like, 
                                  size: 15
                                ),
                                
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(5)

                                ),
                                child: Center(child: Text(
                                  widget.book.status==""? "Unknown": widget.book.status,
                                  
                                ))
                              ),

                            ],
                          )

                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary  ,
                              shape: const CircleBorder(),
                              minimumSize: const Size.square(40),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            )),
                        const SizedBox(height: 20),
                        OutlinedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  width: 2.0, color: AppColors.primary),
                              shape: const CircleBorder(),
                              minimumSize: const Size.square(40),
                            ),
                            child: Icon(
                              Icons.headphones,
                              color: AppColors.primary,
                            ))
                      ],
                    ))
              ],
            ),
          );
        });
  }
}
