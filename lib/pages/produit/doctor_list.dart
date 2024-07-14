import 'package:flutter/material.dart';
// doctors_list.dart

class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final String distance;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distance,
    required this.imageUrl,
  });
}

class DoctorsList extends StatefulWidget {
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  final List<Doctor> doctors = [
    Doctor(
      name: 'ananas',
      specialty: 'Categorie',
      rating: 4.7,
      distance: '800m away',
      imageUrl: 'assets/doctor1.jpg',
    ),
    Doctor(
      name: 'cacao',
      specialty: '',
      rating: 4.7,
      distance: '800m away',
      imageUrl: 'assets/doctor2.jpg',
    ),
    Doctor(
      name: 'plantain',
      specialty: '',
      rating: 4.7,
      distance: '800m away',
      imageUrl: 'assets/doctor3.jpg',
    ),
    Doctor(
      name: '',
      specialty: '',
      rating: 4.7,
      distance: '800m away',
      imageUrl: 'assets/doctor4.jpg',
    ),
    Doctor(
      name: '',
      specialty: '',
      rating: 4.7,
      distance: '800m away',
      imageUrl: 'assets/doctor5.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des produit'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: doctors[index]);
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(doctor.imageUrl),
        ),
        title: Text(doctor.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor.specialty),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, size: 16, color: Colors.amber),
                SizedBox(width: 4),
                Text('${doctor.rating}'),
                SizedBox(width: 16),
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(doctor.distance),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
