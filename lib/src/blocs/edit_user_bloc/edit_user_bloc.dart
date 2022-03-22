import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybook_flutter/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:mybook_flutter/src/constants/firebase_data.dart';
import 'package:mybook_flutter/src/constants/validator.dart';
import 'package:http/http.dart' as http;
import 'package:mybook_flutter/src/models/user_model.dart';
import 'package:mybook_flutter/src/resources/service/api.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  AuthBloc authBloc;
  bool isValidName = true;
  bool isChangePassword = false;
  bool isValidNewPassword = true;
  String newPassword = "";
  File? imageFromFile;
  String imageUpload = "";
  bool isChangeAvatar = false;
  bool uploaded = true;
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  EditUserBloc({required this.authBloc}) : super(UserEditingState()) {
    on<EditUserChangeImageEvent>(_onChangeImage);
    on<EditUserEnableChangePasswordEvent>(_onEnableChangePassword);
    on<EditUserChangeNameEvent>(_onChangeName);
    on<EditUserChangeNewPasswordEvent>(_onChangeNewPassword);
    on<EditUserSummitEvent>(_onSummitEdit);
    on<EditUserUploadImageEvent>(_onUploadImage);
  }
  bool canSubmit() => (isValidName && isValidNewPassword);
  void _onChangeImage(event, Emitter<EditUserState> emit) async {
    emit(EditUserChangingImage());
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 100000, maxHeight: 100000,);
    if (image != null) {
      var imageCroped = await _cropper.cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        maxWidth: 100000,
        maxHeight: 100000,
      );
      if (imageCroped != null) {
        uploaded = false;
        imageFromFile = imageCroped;
      }
    }
    emit(UserEditingState());
  }
  void _onUploadImage(event, Emitter<EditUserState> emit) async {
    emit(EditUserLoading());
    var userID =  await authBloc.userRepository.getUserID();
    var uri = await FirebaseData.upLoadImage(imageFromFile!, userID);
    if (uri!=""){
      uploaded = true;
      isChangeAvatar = true;
      imageUpload = uri;
      emit(UserEditingState());
    } else {
      emit(EditUserFailure(message: "Upload failed"));
    }    
  }
  void _onEnableChangePassword(event, Emitter<EditUserState> emit) async {
    emit(UserCheckingState());
    isChangePassword = !isChangePassword;
    if (isChangePassword) {
      isValidNewPassword = Validation.isValidPassword(newPassword);
    } else {
      isValidNewPassword = true;
    }
    emit(UserEditingState());
  }

  void _onChangeName(event, Emitter<EditUserState> emit) async {
    emit(UserCheckingState());
    isValidName = Validation.isValidName(event.value);
    emit(UserEditingState());
  }

  void _onChangeNewPassword(event, Emitter<EditUserState> emit) async {
    emit(UserCheckingState());
    isValidNewPassword = Validation.isValidPassword(event.value);
    newPassword = event.value;
    emit(UserEditingState());
  }

  void _onSummitEdit(event, Emitter<EditUserState> emit) async {
    emit(EditUserLoading());
    try {
      var userID = await authBloc.userRepository.getUserID();
      var res = await http.post(Uri.parse(AppApis.updateUser_API),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          
          body: jsonEncode({
            "id": userID,
            "name": event.name,
            "avatar": imageUpload,
            "password": event.oldPassword,
            "new_password": event.newPassword,
            "change_password": isChangePassword,
            "change_avatar": isChangeAvatar,
          }));
      var body = jsonDecode(res.body);
      print(body);
      if(res.statusCode ==200){
        UserModel edited = UserModel.fromJSON(body["data"]);
        await edited.getAvatarUrl();
        authBloc.add(ReloadUser(edited));
        emit(EditUserSuccess());
      } else{
        emit(EditUserFailure(message: body["message"]));
      }
      
    } catch (error) {
      emit(EditUserFailure(message: "Can't update now"));
    }
  }
}
