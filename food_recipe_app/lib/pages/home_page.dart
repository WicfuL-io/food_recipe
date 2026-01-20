import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api.dart';
import 'add_recipe_page.dart';
import 'edit_recipe_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Recipe>> recipes;

  void loadData() {
    recipes = ApiService.getRecipes();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Recipe")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRecipePage()),
          );
          setState(() => loadData());  // Perbaiki: Panggil loadData di dalam setState
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: recipes,
        builder: (c, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (s.hasError) {
            return Center(child: Text("Error: ${s.error}"));
          }
          if (!s.hasData || s.data!.isEmpty) {
            return const Center(child: Text("Belum ada resep"));
          }

          return ListView.builder(
            itemCount: s.data!.length,
            itemBuilder: (c, i) {
              final r = s.data![i];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    "http://localhost/food_recipe_api/upload/${r.image}",
                    width: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported),
                  ),
                  title: Text(r.title),
                  subtitle: Text(r.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditRecipePage(recipe: r),
                            ),
                          );
                          setState(() => loadData());  // Perbaiki: Panggil loadData di dalam setState
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await ApiService.deleteRecipe(r.id);
                          setState(() => loadData());  // Perbaiki: Panggil loadData di dalam setState
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}