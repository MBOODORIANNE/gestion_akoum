import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  //create
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("employee")
        .doc(id)
        .set(employeeInfoMap);
  }
  //read

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("employee").snapshots();
  }
  //update

  Future updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("employee")
        .doc(id)
        .update(updateInfo);
  }

  //delete
  Future deleteEmployeeDetails(
    String id,
  ) async {
    return await FirebaseFirestore.instance.collection("employee").doc(id);
  }
  }


