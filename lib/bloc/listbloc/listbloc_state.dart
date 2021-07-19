part of 'listbloc_bloc.dart';

abstract class ListblocState extends Equatable {
  const ListblocState();
}

class ListblocInitial extends ListblocState {
  @override
  List<Object> get props => [];
}

class ListblocLoaded extends ListblocState {
  final List<ListModel> listModel;
  final List<ListModel> addlistModel;

  ListblocLoaded(this.listModel, this.addlistModel);
  @override
  List<Object> get props => [listModel, addlistModel];
}
