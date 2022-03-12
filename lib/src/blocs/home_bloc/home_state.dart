
part of 'home_bloc.dart';

class HomeState extends Equatable{
  final int type;
  final int sort;

  const HomeState(this.type, this.sort);



  @override
  List<Object?> get props => [type, sort];

}