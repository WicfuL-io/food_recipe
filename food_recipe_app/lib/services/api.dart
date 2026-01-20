import 'dart:convert';
import 'dart:io';  // Untuk File
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';  // Pastikan diimpor
import '../models/recipe.dart';

class ApiService {
  static const String baseUrl = 'http://localhost/food_recipe_api';  // Ganti ke 'http://10.0.2.2' jika emulator Android

  static Future<List<Recipe>> getRecipes() async {
    final response = await http.get(Uri.parse('$baseUrl/recipes/read.php'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Recipe.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  static Future<void> addRecipe(String title, String desc, String ing, String steps, XFile image) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/recipes/create.php'));
    request.fields['title'] = title;
    request.fields['description'] = desc;
    request.fields['ingredients'] = ing;
    request.fields['steps'] = steps;
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to add recipe');
    }
  }

  static Future<void> updateRecipe(String id, String title, String desc, String ing, String steps, XFile? image) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/recipes/update.php'));
    request.fields['id'] = id;
    request.fields['title'] = title;
    request.fields['description'] = desc;
    request.fields['ingredients'] = ing;
    request.fields['steps'] = steps;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to update recipe');
    }
  }

  static Future<void> deleteRecipe(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/delete.php'),
      body: {'id': id},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipe');
    }
  }
}