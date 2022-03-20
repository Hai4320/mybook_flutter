import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  bool isValidName = true;
  bool isChangePassword = false;
  bool isValidNewPassword = true;
  File? imageFromFile = null;
  String imageUpload = "";
  bool isChangeAvatar = false;
  bool uploaded = true;
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  EditUserBloc()
      : super(UserEditingState()) {
    on<EditUserChangeImageEvent>(_onChangeImage);
    on<EditUserEnableChangePasswordEvent>(_onEnableChangePassword);
  }
  void _onChangeImage(event, Emitter<EditUserState> emit) async {
    emit(EditUserChangingImage());
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 100, maxHeight: 100);
    if (image != null) {
      var imageCroped = await _cropper.cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 99,
          maxWidth: 1000,
          maxHeight: 1000,
        );
      if (imageCroped!=null){
        uploaded = false;
        imageFromFile = imageCroped;
      }
    }
    emit(UserEditingState());
  }
  void _onEnableChangePassword(event, Emitter<EditUserState> emit) async {
    emit(UserCheckingState());
    isChangePassword = !isChangePassword;
    emit(UserEditingState());
  }
}
