part of 'listbloc_bloc.dart';

abstract class ListblocEvent extends Equatable {
  const ListblocEvent();

  @override
  List<Object> get props => [];
}

class ListAdd extends ListblocEvent {
  final ListModel listmodel;

  const ListAdd(this.listmodel);
  @override
  List<Object> get props => [listmodel];
}

class ListDelete extends ListblocEvent {
  final ListModel listmodel;

  const ListDelete(this.listmodel);
  @override
  List<Object> get props => [listmodel];
}

class ListFetch extends ListblocEvent {
  @override
  List<Object> get props => [];
}

class ListDeleteAll extends ListblocEvent {}
