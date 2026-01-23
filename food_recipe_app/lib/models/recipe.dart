class Recipe {
  final String id;
  final String title;
  final String description;
  final String ingredients;
  final String steps;
  final String image;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      image: json['image'],
    );
  }
}