import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Cuisine extends Equatable {
  final String id;
  final String name;

  const Cuisine({
    required this.id,
    required this.name,
  });

  factory Cuisine.fromJson(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return Cuisine(
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
