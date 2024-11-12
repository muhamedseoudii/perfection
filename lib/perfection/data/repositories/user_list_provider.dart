import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data_sources/dio/dio_helper.dart';
import '../data_sources/dio/end_points.dart';
import '../models/user_list_model.dart';

class ApiService {
  // Fetch a list of users with pagination
  static Future<List<User>> fetchUsers(int page) async {
    // final response = await DioHelper.getData(
    //   url: EndPoints.getUserList(page: page),
    // );
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List).map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
  // Fetch user details by ID
  static Future<User> fetchUserDetails(int userId) async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['data']);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
