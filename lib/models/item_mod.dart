

class Company {
  final String name;
  final String image;
  final String description;

  Company({
    required this.name,
    required this.image,
    required this.description,
  });

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      name : json['name'] as String,
      image : json['image'] as String,
      description : json['description'] as String
    );
  }
}
