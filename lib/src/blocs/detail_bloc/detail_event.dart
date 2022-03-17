part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}
class DetailLikeEvent extends DetailEvent{}
class DetailOpenEvent extends DetailEvent{}

class DetailSaveEvent extends DetailEvent{}