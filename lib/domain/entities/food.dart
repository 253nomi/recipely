import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String id;
  final String name;
  final String categoryId;
  final String cuisineId;
  final String chef;

  const Food({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.cuisineId,
    required this.chef,
  });

  factory Food.fromJson(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return Food(
      id: document.id,
      name: data['name'],
      categoryId: data['categoryId'],
      cuisineId: data['cuisineId'],
      chef: data['chef'],
    );
  }

  factory Food.empty() {
    return const Food(
      id: '',
      name: '',
      categoryId: '',
      cuisineId: '',
      chef: '',
    );
  }

  @override
  List<Object?> get props => [id, name, categoryId, cuisineId, chef];
}
