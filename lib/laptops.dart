import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jacobsheritage/firestore/database_manager.dart';
import 'package:jacobsheritage/showprod.dart';

class OnlyLaptops extends StatefulWidget {
  String prodcategory;
  OnlyLaptops({super.key, required this.prodcategory});

  @override
  State<OnlyLaptops> createState() => _OnlyLaptopsState();
}

class _OnlyLaptopsState extends State<OnlyLaptops> {
  List dataList = [];

  late Future prodListData;

  Future getProd() async {
    if (widget.prodcategory == 'Laptops') {
      dataList = await FirestoreDatabase().getLaptopsData();
    } else if (widget.prodcategory == 'Printers') {
      dataList = await FirestoreDatabase().getPrintersData();
    } else if (widget.prodcategory == "Hard Drive") {
      dataList = await FirestoreDatabase().getHardDiskData();
    } else if (widget.prodcategory == "NVME") {
      dataList = await FirestoreDatabase().getNVMEData();
    }

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
        ),
        body: FutureBuilder(
          future: getProd(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Some thing Error....!");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              dataList = snapshot.data as List;

              return Container(
                alignment: Alignment.center,
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: CachedNetworkImageProvider(
                                        dataList[index]['image']))),
                          ),
                        ),
                        Expanded(
                            child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 15),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                "Product Name : " + dataList[index]['prodname'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    "Product Specification : " +
                                        dataList[index]['spec'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13))),
                            SizedBox(height: 8),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    "Product Price : Rs." +
                                        dataList[index]['price'] +
                                        "/-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17))),
                            SizedBox(height: 8),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.amber),
                                onPressed: () {
                                  shareData(dataList[index]['spec']);
                                },
                                child: Center(
                                    child:
                                        const Text("Place Order (or) Enquiry")),
                              ),
                            )
                          ],
                        )),
                        // Container(
                        //   child: Text(dataList[index]['prodname']),
                        // ),
                      ],
                    );
                  },
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
