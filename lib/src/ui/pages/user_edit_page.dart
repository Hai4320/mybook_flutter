import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:mybook_flutter/src/blocs/edit_user_bloc/edit_user_bloc.dart';
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
    var authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => EditUserBloc(authBloc: authBloc),
      child: BlocListener<EditUserBloc, EditUserState>(
        listener: (context, state) {
          if (state is EditUserFailure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: size.height-80),
            ));
          }
          if (state is EditUserSuccess){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Update successfully !'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: size.height-80),
            ));
          }
        },
        child: BlocBuilder<EditUserBloc, EditUserState>(
          builder: (context, state) {
            var pageBloc = BlocProvider.of<EditUserBloc>(context);
            bool isChangePassword = pageBloc.isChangePassword;
            File? imageFile = pageBloc.imageFromFile;
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
                        child: imageFile == null
                            ? (user.avatarURL == ""
                                ? Image.asset(AppImages.img_avatar)
                                : Image.network(user.avatarURL))
                            : Image.file(imageFile),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: state is EditUserLoading
                        ? null 
                        :()=> pageBloc.add(EditUserChangeImageEvent()),
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
                      onPressed: (state is EditUserLoading||pageBloc.uploaded == true) 
                      ? null 
                      : () {pageBloc.add(EditUserUploadImageEvent());},
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
                    onChanged: (value) => pageBloc.add(
                        EditUserChangeNameEvent(value: _nameController.text)),
                    decoration: InputDecoration(
                      labelText: "User Name",
                      errorText:
                          !pageBloc.isValidName ? "Name is not empty!" : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CheckboxListTile(
                  value: isChangePassword,
                  onChanged: (value) =>
                      pageBloc.add(EditUserEnableChangePasswordEvent()),
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
                            onChanged: (value) => pageBloc.add(
                                EditUserChangeNewPasswordEvent(value: value)),
                            decoration: InputDecoration(
                              labelText: "New Password",
                              errorText: pageBloc.isValidNewPassword
                                  ? null
                                  : "Password too short",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ])
                    : Container(),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: (pageBloc.canSubmit() &&
                              state is! EditUserLoading)
                          ? () {
                              pageBloc.add(EditUserSummitEvent(
                                  name: _nameController.text,
                                  newPassword: _newPasswordController.text,
                                  oldPassword: _oldPasswordController.text));
                            }
                          : null,
                      child: Text("SUMMIT")),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
