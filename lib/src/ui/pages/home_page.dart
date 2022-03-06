import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_state.dart';
import 'package:mybook_flutter/src/blocs/login_bloc/login_state.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/loadingui.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: size.height - 80),
            ));
          }
        },
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoadingState){
              return const LoadingUI();
            }
            else{
              return const Center(child: Text("Home"));
            }
            
          },
        ),
      ),
    );
  }
}
