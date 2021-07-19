import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listtotal/bloc/bloc.dart';
import 'package:listtotal/listview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListblocBloc>(
            create: (BuildContext context) => ListblocBloc()),
      ],
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}
