import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:jacobsheritage/firestore/database_manager.dart';
import 'package:flutter/material.dart';

class ProdList extends StatefulWidget {
  String prodCatg;
  ProdList({super.key, required this.prodCatg});

  @override
  State<ProdList> createState() => _ProdListState();
}

class _ProdListState extends State<ProdList> {
  List prodList = [];

  Future prodsList() async {
    if (widget.prodCatg == "Laptops") {
      return await FirestoreDatabase().getLaptopsData();
    } else if (widget.prodCatg == "Hard Disk") {
      return await FirestoreDatabase().getHardDiskData();
    } else if (widget.prodCatg == "Printers") {
      return await FirestoreDatabase().getPrintersData();
    } else if (widget.prodCatg == "NVME") {
      return await FirestoreDatabase().getNVMEData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prodCatg),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height,
              color: const Color.fromARGB(255, 255, 0, 0),
              child: FutureBuilder(
                  future: prodsList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Some thing went Wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      prodList = snapshot.data as List;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: prodList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: const BorderRadius
                                                    .only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        prodList[index]
                                                            ['image']))),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.50,
                                                child: Text(
                                                  "Product Name: " +
                                                      prodList[index]
                                                          ['prodname'],
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.50,
                                                child: Text(
                                                  "Product Price: Rs." +
                                                      prodList[index]['price'],
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                child: Text(
                                                  "Specification: " +
                                                      prodList[index]['spec'],
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                )
                              ],
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
