import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../models/recipe.dart';

class ApiService {
  static const baseUrl = "http://localhost/food_recipe_api";

  // READ
  static Future<List<Recipe>> getRecipes() async {
    final res = await http.get(Uri.parse("$baseUrl/recipes/read.php"));
    final data = jsonDecode(res.body);
    return (data as List).map((e) => Recipe.fromJson(e)).toList();
  }

  // CREATE (WEB SAFE)
  static Future<void> addRecipe(
    String title,
    String desc,
    String ing,
    String steps,
    XFile image,
  ) async {
    var req = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/recipes/create.php"),
    );

    req.fields.addAll({
      "title": title,
      "description": desc,
      "ingredients": ing,
      "steps": steps,
    });

    req.files.add(
      http.MultipartFile.fromBytes(
        "image",
        await image.readAsBytes(),
        filename: image.name,
      ),
    );

    await req.send();
  }

  // UPDATE
  static Future<void> updateRecipe(
    String id,
    String title,
    String desc,
    String ing,
    String steps,
    XFile? image,
  ) async {
    var req = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/recipes/update.php"),
    );

    req.fields.addAll({
      "id": id,
      "title": title,
      "description": desc,
      "ingredients": ing,
      "steps": steps,
    });

    if (image != null) {
      req.files.add(
        http.MultipartFile.fromBytes(
          "image",
          await image.readAsBytes(),
          filename: image.name,
        ),
      );
    }

    await req.send();
  }

  // DELETE
  static Future<void> deleteRecipe(String id) async {
    await http.post(
      Uri.parse("$baseUrl/recipes/delete.php"),
      body: {"id": id},
    );
  }
}
