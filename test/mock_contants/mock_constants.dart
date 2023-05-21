import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';

const MOCK_CREDENTIALS = LoginWithFirebaseParams(email: 'abc@gmail.com', password: '12345678');
const String MOCK_IP = '172.168.1.1';
const String NO_IP_ADDRESS_FOUND = 'no ip address found';

const List<Food> MOCK_FOOD_DETAILS = [
  Food(id: '1', categoryId: 'qurwes', cuisineId: 'sbjsksa', chef: 'Nooman', name: 'Italian Food'),
  Food(id: '2', categoryId: 'qurhdie', cuisineId: 'sbdhjskssa', chef: 'Kamran', name: 'Chicken Food')
];

const List<Category> MOCK_CATEGORY_DETAILS = [Category(id: 'qurwes', name: 'Dinner'), Category(id: 'qurhdie', name: 'Lunch')];

const List<Cuisine> MOCK_CUISINE_DETAILS = [Cuisine(id: 'sbjsksa', name: 'Italian'), Cuisine(id: 'sbdhjskssa', name: 'English')];
