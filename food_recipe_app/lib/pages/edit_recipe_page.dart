import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/recipe.dart';
import '../services/api.dart';
import '../widgets/web_image.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;

  const EditRecipePage({
    super.key,
    required this.recipe,
  });

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

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    ing.dispose();
    steps.dispose();
    super.dispose();
  }

  // ================= PICK IMAGE =================
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => image = picked);
    }
  }

  // ================= UPDATE =================
  Future<void> update() async {
    setState(() => loading = true);

    try {
      await ApiService.updateRecipe(
        widget.recipe.id,
        title.text,
        desc.text,
        ing.text,
        steps.text,
        image,
      );

      if (!mounted) return;

      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Resep berhasil diperbarui ✅"),
        ),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  // ================= IMAGE PREVIEW =================
  Widget _buildImagePreview() {
    // Jika user pilih gambar baru
    if (image != null) {
      return WebImage(
        image!.path,
        height: 180,
      );
    }

    // Gambar lama dari server
    return WebImage(
      "${ApiService.baseUrl}/upload/${widget.recipe.image}",
      height: 180,
    );
  }
  // =================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Resep"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(
              labelText: "Judul",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: desc,
            decoration: const InputDecoration(
              labelText: "Deskripsi",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: ing,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Bahan",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: steps,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Langkah",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: pickImage,
            icon: const Icon(Icons.image),
            label: const Text("Ganti Gambar"),
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildImagePreview(),
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: loading ? null : update,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text("Update Resep"),
          ),
        ],
      ),
    );
  }
}
