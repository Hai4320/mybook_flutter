
part of 'home_bloc.dart';

class HomeState extends Equatable{
  int type;
  int sort;

  HomeState(this.type, this.sort);



  @override
  List<Object?> get props => [type, sort];

}