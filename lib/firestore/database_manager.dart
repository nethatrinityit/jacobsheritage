import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDatabase {
  List products = [];
  List harddisks = [];
  List printers = [];
  List nvmes = [];
  List<String> prodCat = [];

  final Query<Map<String, dynamic>> colRef = FirebaseFirestore.instance
      .collection('prodcuts')
      .where('category', isEqualTo: "Laptops")
      .orderBy('udate', descending: true);

  final Query<Map<String, dynamic>> colRef1 = FirebaseFirestore.instance
      .collection('prodcuts')
      .where('category', isEqualTo: "Hard Drive");

  final Query<Map<String, dynamic>> colRef2 = FirebaseFirestore.instance
      .collection('prodcuts')
      .where('category', isEqualTo: "Printer");

  final Query<Map<String, dynamic>> colRef3 = FirebaseFirestore.instance
      .collection('prodcuts')
      .where('category', isEqualTo: "NVME");

  final Query<Map<String, dynamic>> colProdCatRef =
      FirebaseFirestore.instance.collection('prodcat');

  Future getLaptopsData() async {
    try {
      await colRef.get().then((onValue) {
        for (var result in onValue.docs) {
          products.add(result.data());
        }
      });

      return products;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future getHardDiskData() async {
    try {
      await colRef1.get().then((onValue) {
        for (var result in onValue.docs) {
          harddisks.add(result.data());
        }
      });

      return harddisks;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future getPrintersData() async {
    try {
      await colRef2.get().then((onValue) {
        for (var result in onValue.docs) {
          printers.add(result.data());
        }
      });
      return printers;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future getNVMEData() async {
    try {
      await colRef3.get().then((onValue) {
        for (var result in onValue.docs) {
          nvmes.add(result.data());
        }
      });
      return nvmes;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
