import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api.dart';

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

  Future pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => image = picked);
    }
  }

  Future save() async {
    if (image == null) return;

    setState(() => loading = true);

    await ApiService.addRecipe(
      title.text,
      desc.text,
      ing.text,
      steps.text,
      image!,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Resep")),
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
            label: const Text("Pilih Gambar"),
          ),

          if (image != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.network(
                image!.path, // Web & Mobile aman
                height: 160,
                fit: BoxFit.cover,
              ),
            ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: loading ? null : save,
            child: loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Simpan Resep"),
          ),
        ],
      ),
    );
  }
}
