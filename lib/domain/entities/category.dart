import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return Category(
      id: document.id,
      name: data['name'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
