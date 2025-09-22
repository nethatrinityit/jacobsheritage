import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadProd extends StatefulWidget {
  const UploadProd({super.key});

  @override
  State<UploadProd> createState() => _UploadProdState();
}

class _UploadProdState extends State<UploadProd> {
  final TextEditingController _prodName = TextEditingController();
  final TextEditingController _prodPrice = TextEditingController();
  final TextEditingController _prodSpec = TextEditingController();
  final TextEditingController _prodDefect = TextEditingController();
  //final ImagePicker _picker = ImagePicker();
  late Uint8List imageData;
  String? imgUrl;
  final _storage = FirebaseStorage.instance.ref();

  List<String> listCat = [
    'Laptops',
    'Printer',
    'Hard Drive',
    'CPU',
    'GPU',
    'Monitor',
    'PC',
    'NVME'
  ];

  Future<String?> selectPicture(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(
      source: source,
    );
    //String? mimeType = mime(Path.basename(source.fileName));

    //final String? extension = extensionFromMime(mimeType);
    String path = image!.path;
    Uint8List imageData = await XFile(path).readAsBytes();
    _storage
        .child('${'/${_prodName.text}'}.jpg')
        .putData(
          imageData,
          SettableMetadata(contentType: 'image/jpeg'),
        )
        .then((taskSnapshot) {
      if (taskSnapshot.state == TaskState.success) {
        _storage
            .child('${'/${_prodName.text}'}.jpg')
            .getDownloadURL()
            .then((url) {
          imgUrl = url;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Photot Uploaded Successfully...")));
      }
    });
    return image.path;
  }

  String? selCatVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text(
            "Upload Datas",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(25),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // Product Name
                TextFormField(
                  //enabled: false,
                  // onChanged: (val) {
                  //   _prodName.text = val;
                  // },
                  controller: _prodName,
                  decoration: const InputDecoration(
                      labelText: 'Product Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                // Product Category
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                      hintText: "Select the Category",
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(),
                    ),
                    items: listCat.map<DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem(value: val, child: Text(val));
                    }).toList(),
                    onChanged: (String? newVal) {
                      selCatVal = newVal;
                      //print(ssecval);
                    }),
                const SizedBox(height: 10),
                // Product Price
                TextFormField(
                  // onChanged: (val) {
                  //   _prodPrice.text = val;
                  // },
                  controller: _prodPrice,
                  decoration: const InputDecoration(
                      labelText: 'Product Price', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                // Product spec
                TextFormField(
                  onChanged: (val) {
                    _prodSpec.text = val;
                  },
                  controller: _prodSpec,
                  decoration: const InputDecoration(
                      labelText: 'Product Specification',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                // Product Defects
                TextFormField(
                  onChanged: (val) {
                    _prodDefect.text = val;
                  },
                  controller: _prodDefect,
                  decoration: const InputDecoration(
                      labelText: 'Product Defects',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                      onPressed: () {
                        //if Upload is Success
                        selectPicture(ImageSource.gallery);
                      },
                      child: const Text("Upload A Picture")),
                  const SizedBox(
                    width: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('prodcuts').add({
                          'category': selCatVal,
                          'image': imgUrl,
                          'price': _prodPrice.text,
                          'prodname': _prodName.text,
                          'spec': _prodSpec.text,
                          'proddef': _prodDefect.text,
                          'udate': DateTime.now()
                        }).then((value) => print(value));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Uploaded...")));
                      },
                      child: const Text("Save"))
                ]),
              ],
            ),
          ),
        ));
  }
}
