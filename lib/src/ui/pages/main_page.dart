import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_event.dart';
import 'package:mybook_flutter/src/resources/responsitory/book_repo.dart';
import 'package:mybook_flutter/src/ui/pages/home_page.dart';

import '../../blocs/book_bloc/book_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookBloc(bookRepository: BookRepository())..add(FetchBookEvent()),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
