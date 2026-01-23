import 'package:flutter/material.dart';
import 'package:food_recipe_app/widgets/web_image.dart';
import '../models/recipe.dart';
import '../services/api.dart';
import 'add_recipe_page.dart';
import 'edit_recipe_page.dart';
import 'recipe_detail_page.dart';

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

  // ================= POPUP DELETE =================
  Future<void> showDeletePopup(BuildContext context, Recipe recipe) async {
    final confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Konfirmasi Hapus"),
          content: Text(
            "Apakah kamu yakin ingin menghapus resep:\n\n${recipe.title} ?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await ApiService.deleteRecipe(recipe.id);
      setState(() => loadData());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Resep berhasil dihapus 🗑"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
  // ================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 126, 12),
      appBar: AppBar(
        title: const Text("🍽 Food Recipes"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRecipePage()),
          );
          setState(() => loadData());
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
            return const Center(child: Text("Belum ada resep 🍳"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: s.data!.length,
            itemBuilder: (c, i) {
              final r = s.data![i];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeDetailPage(recipe: r),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 231, 233, 224),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 234, 128, 14)
                            .withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGE
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                        child: WebImage(
                          "http://127.0.0.1/food_recipe_api/upload/${r.image}",
                          height: 180,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              r.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 2, 2, 2),
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.orange),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            EditRecipePage(recipe: r),
                                      ),
                                    );
                                    setState(() => loadData());
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    showDeletePopup(context, r);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )
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
