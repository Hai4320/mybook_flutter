// ignore_for_file: must_be_immutable

part of 'user_bloc.dart';

class UserState extends Equatable {
  UserModel user;
  int tab;
  UserState({required this.user,required this.tab});
  
  @override
  List<Object> get props => [];
}

