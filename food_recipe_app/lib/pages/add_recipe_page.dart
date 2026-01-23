import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api.dart';
import '../widgets/web_image.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final title = TextEditingController();
  final desc = TextEditingController();
  final ing = TextEditingController();
  final steps = TextEditingController();

  XFile? image;
  bool loading = false;

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

  // ================= SAVE =================
  Future<void> save() async {
    if (title.text.isEmpty ||
        desc.text.isEmpty ||
        ing.text.isEmpty ||
        steps.text.isEmpty ||
        image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lengkapi semua data & gambar ❗"),
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      await ApiService.addRecipe(
        title.text,
        desc.text,
        ing.text,
        steps.text,
        image!,
      );

      if (!mounted) return;

      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Resep berhasil ditambahkan ✅")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan: $e")),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  // ================= IMAGE PREVIEW =================
  Widget _buildImagePreview() {
    if (image == null) return const SizedBox();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: WebImage(
        image!.path,
        height: 180,
      ),
    );
  }
  // =================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Resep"),
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
            label: const Text("Pilih Gambar"),
          ),

          const SizedBox(height: 12),

          _buildImagePreview(),

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: loading ? null : save,
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
                : const Text("Simpan Resep"),
          ),
        ],
      ),
    );
  }
}
