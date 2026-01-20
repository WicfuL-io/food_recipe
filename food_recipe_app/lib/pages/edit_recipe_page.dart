import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';  // Tambahkan ini untuk File
import '../models/recipe.dart';
import '../services/api.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;
  const EditRecipePage({super.key, required this.recipe});

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  late TextEditingController title;
  late TextEditingController desc;
  late TextEditingController ing;
  late TextEditingController steps;

  XFile? image;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.recipe.title);
    desc = TextEditingController(text: widget.recipe.description);
    ing = TextEditingController(text: widget.recipe.ingredients);
    steps = TextEditingController(text: widget.recipe.steps);
  }

  Future pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => image = picked);
    }
  }

  Future update() async {
    setState(() => loading = true);

    await ApiService.updateRecipe(
      widget.recipe.id,
      title.text,
      desc.text,
      ing.text,
      steps.text,
      image,
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Resep")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(controller: title, decoration: const InputDecoration(labelText: "Judul")),
          TextField(controller: desc, decoration: const InputDecoration(labelText: "Deskripsi")),
          TextField(controller: ing, decoration: const InputDecoration(labelText: "Bahan")),
          TextField(controller: steps, decoration: const InputDecoration(labelText: "Langkah")),
          const SizedBox(height: 10),

          ElevatedButton.icon(
            onPressed: pickImage,
            icon: const Icon(Icons.image),
            label: const Text("Ganti Gambar"),
          ),

          const SizedBox(height: 10),

          image != null
              ? Image.file(File(image!.path), height: 160)  // Perbaiki: Preview gambar baru
              : Image.network(  // Tampilkan gambar lama jika tidak ada gambar baru
                  "http://localhost/food_recipe_api/upload/${widget.recipe.image}",
                  height: 160,
                  errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported),
                ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: loading ? null : update,
            child: loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Update"),
          ),
        ],
      ),
    );
  }
}