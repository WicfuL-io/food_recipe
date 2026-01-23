import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api.dart';
import 'package:food_recipe_app/widgets/web_image.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 123, 13),
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: ListView(
        children: [
          WebImage("http://127.0.0.1/food_recipe_api/upload/${recipe.image}",height: 300,),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  recipe.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 6, 4, 4),
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  "🧂 Bahan-bahan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(recipe.ingredients),

                const SizedBox(height: 24),
                const Text(
                  "👨‍🍳 Langkah Memasak",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(recipe.steps),
              ],
            ),
          )
        ],
      ),
    );
  }
}
