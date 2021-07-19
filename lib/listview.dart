import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listtotal/bloc/bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('App Resep'), actions: <Widget>[]),
      body: BlocBuilder<ListblocBloc, ListblocState>(
        builder: (context, state) {
          if (state is ListblocInitial) {
            context.read<ListblocBloc>().add(ListFetch());
            return CircularProgressIndicator();
          } else if (state is ListblocLoaded) {
            return ListView.builder(
              itemCount: state.listModel.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          //Text("test ?" + state.total),
                          Container(
                            height: 50.0,
                            width: 50.0,
                            child:
                                Image.network(state.listModel[index].imageUrl),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(state.listModel[index].title),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Rp. " +
                                      state.listModel[index].harga.toString(),
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart,
                            size: 15.0,
                            color: state.listModel[index].isFavorite
                                ? Colors.red
                                : Colors.grey),
                        onPressed: () {
                          !state.listModel[index].isFavorite
                              ? BlocProvider.of<ListblocBloc>(context)
                                  .add(ListAdd(state.listModel[index]))
                              : BlocProvider.of<ListblocBloc>(context)
                                  .add(ListDelete(state.listModel[index]));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: BlocBuilder<ListblocBloc, ListblocState>(
        builder: (context, state) {
          if (state is ListblocInitial) {
            context.read<ListblocBloc>().add(ListFetch());
            return CircularProgressIndicator();
          } else if (state is ListblocLoaded) {
            int sum = 0;
            sum = state.addlistModel.fold(0, (a, b) => a + b.harga);
            print("Sum : $sum");
            if (state.addlistModel.length != 0) {
              return Container(
                width: 320.0,
                height: 150,
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  color: Colors.lightBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 20.0,
                              // width: 20.0,
                              child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ListblocBloc>(context)
                                        .add(ListDeleteAll());
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    size: 20.0,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Text(state.addlistModel.length.toString()),
                      SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Rp." + sum.toString(),
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
