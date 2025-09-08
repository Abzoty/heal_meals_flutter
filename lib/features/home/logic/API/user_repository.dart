import 'package:heal_meals/features/home/data/models/user_model.dart';
import '/../../../core/network/api_client.dart';
import '/../../../core/network/endpoints.dart';


class UserRepository {
  final ApiClient _apiClient = ApiClient();

  Future<User> getUser() async {
    final json = await _apiClient.get(Endpoints.user);
    return User.fromJson(json);
  }
}
