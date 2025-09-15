import 'package:heal_meals/features/home/data/models/user_model.dart';
import '../../../../core/API/api_client.dart';
import '../../../../core/API/endpoints.dart';

class UserRepository {
  final ApiClient _apiClient = ApiClient();

  Future<User> getUser(String id) async {
    final json = await _apiClient.get('${Endpoints.getUser}$id');
    return User.fromJson(json);
  }
}
