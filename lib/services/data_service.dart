import 'package:recepies_app/models/recipe.dart';
import 'package:recepies_app/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipes() async {
    final response = await _httpService.get('/recipes');

    if (response?.statusCode == 200 && response?.data != null) {
      print(response!.data);
    }
  }
}
