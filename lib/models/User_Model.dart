import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Utilisateur {
  String nom;
  String prenom;
  String nomUtilisateur;
  String numeroTelephone;
  String motDePasse;

  Utilisateur({
    required this.nom,
    required this.prenom,
    required this.nomUtilisateur,
    required this.numeroTelephone,
    required this.motDePasse,
  });
}




Future<User?> inscrireUtilisateur(Utilisateur utilisateur) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Utilisez l'adresse e-mail fictive basée sur le nom d'utilisateur pour créer l'utilisateur Firebase
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: '${utilisateur.nomUtilisateur}@example.com',
      password: utilisateur.motDePasse,
    );

    User? user = userCredential.user;

    // Sauvegarder d'autres informations utilisateur dans Firestore
    await firestore.collection('utilisateurs').doc(user!.uid).set({
      'nom': utilisateur.nom,
      'prenom': utilisateur.prenom,
      'nomUtilisateur': utilisateur.nomUtilisateur,
      'numeroTelephone': utilisateur.numeroTelephone,
    });

    return user;
  } catch (e) {
    print("Erreur d'inscription: $e");
    return null;
  }
}


Future<User?> connecterUtilisateur(String nomUtilisateur, String motDePasse) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    // Utilisez l'adresse e-mail fictive basée sur le nom d'utilisateur pour se connecter
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: '${nomUtilisateur}@example.com',
      password: motDePasse,
    );

    User? user = userCredential.user;
    return user;
  } catch (e) {
    print("Erreur de connexion: $e");
    return null;
  }
}


Future<Map<String, dynamic>?> getUserData() async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(currentUser.uid)
        .get();
    return userDoc.data() as Map<String, dynamic>?;
  }
  return null;
}
