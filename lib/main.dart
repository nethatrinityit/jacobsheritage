import 'package:jacobsheritage/behavior.dart';
import 'package:appwrite/models.dart' as models;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jacobsheritage/Appwrite_Provider.dart/AppwriteProvider.dart';
import 'package:jacobsheritage/Prodlist.dart';
import 'package:jacobsheritage/appwrite_constants.dart';
import 'package:jacobsheritage/behavior.dart';
import 'package:jacobsheritage/firestore/database_manager.dart';
import 'package:jacobsheritage/laptops.dart';
import 'package:jacobsheritage/showprod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDnR5H7bHAgetPkMTeKnX8_9vCD-hyoSvs",
          authDomain: "jacobsheritage.firebaseapp.com",
          projectId: "jacobsheritage",
          storageBucket: "jacobsheritage.firebasestorage.app",
          messagingSenderId: "615257906163",
          appId: "1:615257906163:web:27379812f0d19c65e15086",
          measurementId: "G-89FFR2G269"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Jacobs Heritage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'JACOBS HERITAGE V1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List dataList = [];
  List dataHDList = [];
  List dataPrinterList = [];
  List dataNvmeList = [];
  List<int> listItem = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
            const Text(
              "Reliable Tech, Smarter Price",
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            )
          ],
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const UploadProd(),
        //             ));
        //       },
        //       icon: const Icon(
        //         Icons.add,
        //         color: Colors.white,
        //       ))
        // ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                itemCount: AvatarJSON.prodcat.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 20,
                  );
                },
                itemBuilder: (_, i) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnlyLaptops(
                                    prodcategory: AvatarJSON.prodcat[i]
                                            ['avaName']
                                        .toString())));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 243, 239, 224),
                              radius: 25,
                              child: ClipOval(
                                  child: Image.asset(
                                AvatarJSON.prodcat[i]['avaIcon'].toString(),
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              )),
                            ),
                          ),
                          Container(
                            height: 35,
                            child: Text(
                              AvatarJSON.prodcat[i]['avaName'].toString(),
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('All Items')),
                    const Spacer(),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => ProdList(
                    //                   prodCatg: "All Items",
                    //                 )));
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.all(15),
                    //     child: const Text('Show All'),
                    //   ),
                    // ),
                  ],
                ),
                //All Products
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        height: 230,
                        child: FutureBuilder<models.DocumentList>(
                          future: Appwriteprovider().fetchAllProd(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something Went Wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              //dataList = snapshot.data as List;

                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.documents.length,
                                  itemBuilder: (context, index) {
                                    dataList = snapshot
                                        .data!.documents[index].data['ProdImg'];
                                    //print(dataList[index]);
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        child: Card(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          clipBehavior: Clip.hardEdge,
                                          shadowColor: Colors.black26,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(SnackBar(
                                                  //         content: Text(
                                                  //             dataList[index]
                                                  //                 ['prodname']));
                                                  dataList = snapshot
                                                      .data!
                                                      .documents[index]
                                                      .data['ProdImg'];
                                                  print(dataList[index]);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  ShowProd(
                                                                    prodname: snapshot
                                                                        .data!
                                                                        .documents[
                                                                            index]
                                                                        .data['prodTitle'],
                                                                    prodspec: snapshot
                                                                        .data!
                                                                        .documents[
                                                                            index]
                                                                        .data['ProdDesc'],
                                                                    prodimg:
                                                                        dataList,
                                                                    prodprice: snapshot
                                                                        .data!
                                                                        .documents[
                                                                            index]
                                                                        .data[
                                                                            'ProdSelPrice']
                                                                        .toString(),
                                                                    prodmrp: snapshot
                                                                        .data!
                                                                        .documents[
                                                                            index]
                                                                        .data[
                                                                            'ProdMrp']
                                                                        .toString(),
                                                                  )));
                                                },
                                                child: Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      // border: Border.all(
                                                      //     width: 1),
                                                      //color: Colors.red,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(1)),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(
                                                              "${AppWriteConstants.endPoint}/storage/buckets/${AppWriteConstants.prodBucketId}/files/${dataList[1]}/view?project=${AppWriteConstants.projectId}"))),
                                                ),
                                              ),
                                              Text(
                                                snapshot.data!.documents[index]
                                                    .data['prodTitle'],
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Rs." +
                                                    snapshot
                                                        .data!
                                                        .documents[index]
                                                        .data['ProdSelPrice']
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ));
                                  });
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        )),
                  ],
                ),

                //Hard Disk
                /*Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('Hard Disk')),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProdList(
                                      prodCatg: "Cleaning Items",
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('Show All'),
                      ),
                    ),
                  ],
                ),*/
                /*Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        height: 230,
                        child: FutureBuilder<models.DocumentList>(
                          //future: FirestoreDatabase().getHardDiskData(),
                          future: Appwriteprovider().fetchAllProd(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something Went Wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              //dataHDList = snapshot.data as List;

                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  //itemCount: dataHDList.length,
                                  itemCount: snapshot.data!.documents.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        child: Card(
                                          color: const Color.fromARGB(
                                              255, 231, 226, 227),
                                          clipBehavior: Clip.hardEdge,
                                          shadowColor: Colors.black26,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder:
                                                  //             (context) =>
                                                  //                 ShowProd(
                                                  //                   prodname: dataHDList[
                                                  //                           index]
                                                  //                       [
                                                  //                       'prodname'],
                                                  //                   prodspec: dataHDList[
                                                  //                           index]
                                                  //                       [
                                                  //                       'spec'],
                                                  //                   prodimg: dataHDList[
                                                  //                           index]
                                                  //                       [
                                                  //                       'image'],
                                                  //                   prodprice: dataHDList[
                                                  //                           index]
                                                  //                       [
                                                  //                       'price'],
                                                  //                 )));
                                                },
                                                child: Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      // border: Border.all(
                                                      //     width: 1),
                                                      //color: Colors.red,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(1)),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              CachedNetworkImageProvider(
                                                                  dataHDList[
                                                                          index]
                                                                      [
                                                                      'image']))),
                                                ),
                                              ),
                                              Text(
                                                //dataHDList[index]['prodname'],
                                                snapshot.data!.documents[index]
                                                    .data['prodname'],
                                                style: const TextStyle(
                                                    fontSize: 11),
                                              )
                                            ],
                                          ),
                                        ));
                                  });
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        )),
                  ],
                ),*/

                //Printer
                /*Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('Printers')),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProdList(
                                      prodCatg: "Printers",
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('Show All'),
                      ),
                    ),
                  ],
                ),*/
                /*Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        height: 230,
                        child: FutureBuilder(
                          future: FirestoreDatabase().getPrintersData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something Went Wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              dataPrinterList = snapshot.data as List;

                              return dataPrinterList.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: dataPrinterList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.01),
                                            child: Card(
                                              color: const Color.fromARGB(
                                                  255, 231, 226, 227),
                                              clipBehavior: Clip.hardEdge,
                                              shadowColor: Colors.black26,
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ShowProd(
                                                                        prodname:
                                                                            dataPrinterList[index]['prodname'],
                                                                        prodspec:
                                                                            dataPrinterList[index]['spec'],
                                                                        prodimg:
                                                                            dataPrinterList[index]['image'],
                                                                        prodprice:
                                                                            dataPrinterList[index]['price'],
                                                                      )));
                                                    },
                                                    child: Container(
                                                      height: 150,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                          // border: Border.all(
                                                          //     width: 1),
                                                          //color: Colors.red,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0)),
                                                          image: DecorationImage(
                                                              image: CachedNetworkImageProvider(
                                                                  dataPrinterList[
                                                                          index]
                                                                      [
                                                                      'image']))),
                                                    ),
                                                  ),
                                                  Text(
                                                    dataPrinterList[index]
                                                        ['prodname'],
                                                    style: const TextStyle(
                                                        fontSize: 11),
                                                  )
                                                ],
                                              ),
                                            ));
                                      })
                                  : Container(
                                      child: const Center(
                                          child: Text("No Printers in Stock")),
                                    );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        )),
                  ],
                ),*/

                //NVME
                /*Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('NVME')),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProdList(
                                      prodCatg: "NVME",
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text('Show All'),
                      ),
                    ),
                  ],
                ),*/
                /*Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        height: 220,
                        child: FutureBuilder(
                          future: FirestoreDatabase().getNVMEData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something Went Wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              dataNvmeList = snapshot.data as List;

                              return dataNvmeList.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: dataNvmeList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.01),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 150,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1),
                                                        //color: Colors.red,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        image: DecorationImage(
                                                            image: CachedNetworkImageProvider(
                                                                dataNvmeList[
                                                                        index][
                                                                    'image']))),
                                                  ),
                                                ),
                                                Text(
                                                  dataNvmeList[index]
                                                      ['prodname'],
                                                  style: const TextStyle(
                                                      fontSize: 11),
                                                )
                                              ],
                                            ));
                                      })
                                  : Container(
                                      child: const Center(
                                          child: Text("No NVME's in Stock")),
                                    );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        )),
                  ],
                ),*/
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: const Center(
                child: Text(
              "For Contact : 8754927146",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
          )
        ],
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class AvatarJSON {
  static const prodcat = [
    {"id": 0, "avaIcon": "assets/icons/toys.png", "avaName": "Toys"},
    {
      "id": 1,
      "avaIcon": "assets/icons/cleaning.png",
      "avaName": "Cleaning \n Items"
    },
    {
      "id": 2,
      "avaIcon": "assets/icons/kitchen.png",
      "avaName": "Storage and \n Organizers"
    },
    {
      "id": 3,
      "avaIcon": "assets/icons/shopping-cart.png",
      "avaName": "Household items"
    },
    {"id": 4, "avaIcon": "assets/icons/giftbox.png", "avaName": "Gifts"},
    //{"id": 5, "avaIcon": "assets/icons/kitchen.png", "avaName": "kitchen"},
    // {"id": 6, "avaIcon": "assets/icons/graphic-card.png", "avaName": "GPU"},
    // {
    //   "id": 7,
    //   "avaIcon": "assets/icons/motherboard.png",
    //   "avaName": "Motherboard"
    // },
    // {"id": 8, "avaIcon": "assets/icons/nvme.png", "avaName": "NVME"},
  ];
}
