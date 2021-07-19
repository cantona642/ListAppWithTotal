import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listtotal/model/listmodel.dart';

part 'listbloc_event.dart';
part 'listbloc_state.dart';

class ListblocBloc extends Bloc<ListblocEvent, ListblocState> {
  ListblocBloc() : super(ListblocInitial());

  @override
  Stream<ListblocState> mapEventToState(
    ListblocEvent event,
  ) async* {
    if (event is ListFetch) {
      List<ListModel> listmodel = [];
      listmodel.add(ListModel(
          'https://image.shutterstock.com/image-vector/sample-stamp-grunge-texture-vector-260nw-1389188336.jpg',
          'Mie Goreng',
          12000,
          false));
      listmodel.add(ListModel(
          'https://image.shutterstock.com/image-vector/sample-stamp-grunge-texture-vector-260nw-1389188336.jpg',
          'Mie Goreng 2',
          15000,
          false));
      listmodel.add(ListModel(
          'https://image.shutterstock.com/image-vector/sample-stamp-grunge-texture-vector-260nw-1389188336.jpg',
          'Mie Goreng 3',
          20000,
          false));
      yield ListblocLoaded(listmodel, []);
    } else if (event is ListAdd) {
      List<ListModel> listmodel = [];
      List<ListModel> addlistmodel = [];
      if (state is ListblocLoaded) {
        listmodel.addAll((state as ListblocLoaded).listModel);
        addlistmodel.addAll((state as ListblocLoaded).addlistModel);
      }
      for (var i = 0; i < listmodel.length; i++) {
        if (listmodel[i].title == event.listmodel.title) {
          listmodel[i] = ListModel(event.listmodel.imageUrl,
              event.listmodel.title, event.listmodel.harga, true);

          break;
        }
      }
      addlistmodel.add(event.listmodel);

      yield ListblocLoaded(listmodel, addlistmodel);
    } else if (event is ListDelete) {
      List<ListModel> listmodel = [];
      List<ListModel> addlistmodel = [];
      if (state is ListblocLoaded) {
        listmodel.addAll((state as ListblocLoaded).listModel);
        addlistmodel.addAll((state as ListblocLoaded).addlistModel);
      }
      for (var i = 0; i < listmodel.length; i++) {
        if (listmodel[i].title == event.listmodel.title) {
          listmodel[i] = ListModel(event.listmodel.imageUrl,
              event.listmodel.title, event.listmodel.harga, false);
          break;
        }
      }

      for (var i = 0; i < addlistmodel.length; i++) {
        if (addlistmodel[i].title == event.listmodel.title) {
          addlistmodel.remove(addlistmodel[i]);

          break;
        }
      }
      yield ListblocLoaded(listmodel, addlistmodel);
    } else if (event is ListDeleteAll) {
      List<ListModel> listmodel = [];
      List<ListModel> addlistmodel = [];
      if (state is ListblocLoaded) {
        listmodel.addAll((state as ListblocLoaded).listModel);
        addlistmodel.remove((state as ListblocLoaded).addlistModel);
      }
      for (var i = 0; i < listmodel.length; i++) {
        listmodel[i] = ListModel(listmodel[i].imageUrl, listmodel[i].title,
            listmodel[i].harga, false);
      }
      yield ListblocLoaded(listmodel, addlistmodel);
    }
  }
}
