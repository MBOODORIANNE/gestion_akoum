class Categorie {
  String? docId; // ID du document Firestore
  String nomCategorie;

  Categorie({this.docId, required this.nomCategorie});

  // Convert a Categorie into a Map. The keys must correspond to the names of the
  // columns in the Firestore database.
  Map<String, dynamic> toMap() {
    return {
      'nomCategorie': nomCategorie,
    };
  }

  // A method to retrieve a Categorie from a Map.
  factory Categorie.fromMap(Map<String, dynamic> map, String docId) {
    return Categorie(
      docId: docId,
      nomCategorie: map['nomCategorie'],
    );
  }
}
