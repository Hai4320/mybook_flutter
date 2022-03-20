import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/bloc/edit_user_bloc.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/models/user_model.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/transparent_appbar.dart';

class UserEditPage extends StatefulWidget {
  final UserModel user;
  const UserEditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final _nameController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    return BlocProvider(
      create: (context) => EditUserBloc(),
      child: BlocListener<EditUserBloc, EditUserState>(
        listener: (context, state) {
        },
        child: BlocBuilder<EditUserBloc, EditUserState>(
          builder: (context, state) {
            var pageBloc =BlocProvider.of<EditUserBloc>(context);
            bool isChangePassword = pageBloc.isChangePassword;
            File? imageFile  = pageBloc.imageFromFile;
            return Scaffold(
              appBar: TransparentAppBar("Edit User", AppColors.primary),
              body: ListView(children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black54),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: imageFile == null ? (user.avatarURL == ""
                            ? Image.asset(
                                AppImages.img_avatar,
                              )
                            : Image.network(user.avatarURL))
                            : Image.file(imageFile),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => pageBloc.add(EditUserChangeImageEvent()),
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      child: Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: const Text("CHANGE")),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: pageBloc.uploaded == true ? null : () {},
                      child: Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: const Text("UPLOAD")),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "User Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CheckboxListTile(
                  value: isChangePassword,
                  onChanged: (value) => pageBloc.add(EditUserEnableChangePasswordEvent()),
                  title: const Text("Change Password"),
                ),
                isChangePassword
                    ? Column(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _oldPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Current Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _newPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "New Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ])
                    : Container(),
                Container(
                  margin: const EdgeInsets.all(20),
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("SUMMIT")),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
