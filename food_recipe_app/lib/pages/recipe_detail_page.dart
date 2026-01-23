import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/web_image.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Detail Resep",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ================= IMAGE =================
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: WebImage(
              "http://127.0.0.1/food_recipe_api/upload/${recipe.image}",
              height: 240,
            ),
          ),

          const SizedBox(height: 20),

          // ================= TITLE =================
          Text(
            recipe.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 8),

          // ================= DESC =================
          Text(
            recipe.description,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.grey[700],
            ),
          ),

          const SizedBox(height: 24),

          // ================= BAHAN =================
          _section(
            icon: "🧂",
            title: "Bahan",
            content: recipe.ingredients,
          ),

          const SizedBox(height: 20),

          // ================= LANGKAH =================
          _section(
            icon: "👨‍🍳",
            title: "Cara Membuat",
            content: recipe.steps,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ================= SECTION =================
  Widget _section({
    required String icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
