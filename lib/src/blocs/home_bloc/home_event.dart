part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class HomeChangeTypeEvent extends HomeEvent{
  final int type;
  HomeChangeTypeEvent(this.type);
  @override
  List<Object?> get props => [type];
}
class HomeChangeSortEvent extends HomeEvent{
  final int sort;
  HomeChangeSortEvent(this.sort);
  @override
  List<Object?> get props => [sort];

}