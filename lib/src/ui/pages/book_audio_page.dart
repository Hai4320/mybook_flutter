import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/models/book_model.dart';
import 'package:mybook_flutter/src/ui/pages/audio_player_page.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/transparent_appbar.dart';

class BookAudioPage extends StatefulWidget {
  BookAudioPage({Key? key, required this.book}) : super(key: key);
  BookModel book;

  @override
  State<BookAudioPage> createState() => _BookAudioPageState();
}

class _BookAudioPageState extends State<BookAudioPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var book = widget.book;
    return Scaffold(
      appBar: TransparentAppBar("Audio", Colors.white),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColors.primary,
          AppColors.secondary,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Container(
            width: size.width * 0.9,
            height: size.height * 0.8,
            margin: EdgeInsets.only(top: size.height * 0.1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "List Audio",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  child: book.audio.isEmpty
                      ? const Center(
                          child: Text("Audio is coming soon!",
                              style: TextStyle(color: Colors.blue)),
                        )
                      : ListView(
                          padding: EdgeInsets.zero,
                          children:
                              List.generate(widget.book.audio.length, (index) {
                            var path = book.audio[index].toString();
                            var name = path.substring(13, path.length - 4);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                AudioPlayerPage(
                                                    name: name,
                                                    path: path,
                                                    author: book.author,
                                                    imageUrl: book.imageUrl)));
                                  },
                                  label: Text(name),
                                  icon: const Icon(Icons.play_circle)),
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
