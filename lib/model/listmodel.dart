import 'package:equatable/equatable.dart';

class ListModel extends Equatable {
  final String imageUrl;
  final String title;
  final int harga;

  final bool isFavorite;

  const ListModel(this.imageUrl, this.title, this.harga, this.isFavorite);
  @override
  List<Object?> get props => [];
}
