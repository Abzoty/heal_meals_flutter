import 'package:heal_meals/core/API/api_client.dart';
import 'package:heal_meals/core/API/endpoints.dart';

class UserRepository {
  final ApiClient _apiClient = ApiClient();

  Future<bool> signin(String email, String password) async {
    final response = await _apiClient.post(Endpoints.signIn, {
      "email": email,
      "password": password,
    });

    if (response["success"]) {
      return true;
    } else {
      throw Exception(response["message"]);
    }
  }

  Future<bool> signup(
    String name,
    String email,
    String password,
    String role,
    String gender,
    String dob,
    String address,
    String healthId,
    String phone,
  ) async {
    final response = await _apiClient.post(Endpoints.signUp, {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "gender": gender,
      "dob": dob,
      "address": address,
      "healthId": healthId,
      "phone": phone,
    });

    if (response["success"]) {
      return true;
    } else {
      throw Exception(response["message"]);
    }
  }
}
