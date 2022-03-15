import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_bloc.dart';
import 'package:mybook_flutter/src/blocs/user_bloc/user_bloc.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/ui/pages/notification_page.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/book_card.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/page_title.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var userState = BlocProvider.of<UserBloc>(context, listen: true);
    var authState = BlocProvider.of<AuthBloc>(context, listen: true);
    var bookData = BlocProvider.of<BookBloc>(context, listen: true).bookRepository.books;
    var user = userState.user;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
        }
      },
      child: Container(
        color: AppColors.secondary,
        child: Column(children: [
          Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 80),
              alignment: Alignment.center,
              child: const PageTitle(title: "User Page", color: Colors.white)),
          Expanded(
            child: Container(
              width: size.width,
              margin: const EdgeInsets.only(left: 4, right: 4, top: 10),
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black54),
                                  shape: BoxShape.circle),
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: user.avatarURL == ""
                                        ? Image.asset(
                                            AppImages.img_avatar,
                                          )
                                        : Image.network(user.avatarURL),
                                  )),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Text(
                                user.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                user.email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ])),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("LOG OUT?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            authState.add(LoggedOut());
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                          },
                          icon: Icon(Icons.logout_rounded,
                              color: AppColors.primary, size: 30),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const NotificationPage()));},
                              child: const Icon(Icons.notifications)),
                          const SizedBox(width: 16),
                          ElevatedButton(
                              onPressed: () {},
                              child: Container(
                                  alignment: Alignment.center,
                                  width: size.width - 150,
                                  child: const Text(
                                    "Edit User",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                        ]),
                    const Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTabIcon(
                          icon: Icons.bookmark,
                          color: AppColors.blue,
                          width: 100,
                          index: 0,
                          bloc: userState,
                        ),
                        _buildTabIcon(
                          icon: Icons.favorite,
                          color: AppColors.like,
                          width: 100,
                          index: 1,
                          bloc: userState,
                        ),
                      ],
                    ),
                    Builder(
                      builder: (context) {
                        var listItem = userState.tab == 0 
                        ? bookData.savedBooks()
                        : bookData.likedBooks();

                        return Container(
                          constraints: BoxConstraints(
                            minHeight: size.height*0.5
                          ),
                          decoration: BoxDecoration(
                            color:  userState.tab == 0?  AppColors.blue.withOpacity(0.5): AppColors.like.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          
                          child: ListView.builder(
                            itemCount: listItem.length,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            physics: const ClampingScrollPhysics(), 
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var item = listItem[index];
                              return BookCard(item: item);
                            }),
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  _buildTabIcon(
      {required Color color,
      required IconData icon,
      required UserBloc bloc,
      required int index,
      required double width}) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: RawMaterialButton(
            onPressed: () {
              bloc.add(UserChangeTabEvent(tab: index));
              setState((){}); 
              },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bloc.tab==index ? color : Colors.white,
                  border: Border.all(width: 1, color: color)),
              width: width,
              height: 30,
              child: Icon(icon, color: bloc.tab==index ? Colors.white : color, size: 20),
            ),
          ),
    );
  }
}
