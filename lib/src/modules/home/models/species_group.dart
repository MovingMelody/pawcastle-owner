import 'dart:convert';

class SpeciesGroup {
  final String type;
  final List<Species> species;

  SpeciesGroup({required this.type, required this.species});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'species': species.map((x) => x.toMap()).toList(),
    };
  }

  factory SpeciesGroup.fromMap(Map<String, dynamic> map) {
    return SpeciesGroup(
      type: map['type'],
      species:
          List<Species>.from(map['species']?.map((x) => Species.fromMap(x))),
    );
  }
}

class Species {
  final String name;
  final String image;

  Species({required this.name, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory Species.fromMap(Map<String, dynamic> map) {
    return Species(
      name: map['name'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Species.fromJson(String source) =>
      Species.fromMap(json.decode(source));

  @override
  String toString() => 'Species(name: $name, image: $image)';
}
