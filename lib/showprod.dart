import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jacobsheritage/appwrite_constants.dart';
import 'package:share_plus/share_plus.dart';

class ShowProd extends StatefulWidget {
  final String prodname;
  final String prodspec;
  List prodimg = [];
  final String prodprice;
  final String prodmrp;

  ShowProd(
      {Key? key,
      required this.prodname,
      required this.prodspec,
      required this.prodimg,
      required this.prodprice,
      required this.prodmrp})
      : super(key: key);

  @override
  State<ShowProd> createState() => _ShowProdState();
}

shareData(String data) async {
  await SharePlus.instance.share(ShareParams(
    text: data,
    downloadFallbackEnabled: false,
  ));

  // html.window.navigator.share({
  //   data: 'web.dev',
  // }).catchError((error) => print('Error sharing : $error'));
}

class _ShowProdState extends State<ShowProd> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      //Mobile Layout
      return SafeArea(
        child: Center(
          child: Card(
            color: const Color.fromARGB(255, 231, 226, 227),
            clipBehavior: Clip.hardEdge,
            shadowColor: Colors.black26,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.amber,
                    child: const Center(
                      child: Text(
                        "Goto Home",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.7,
                    // width: MediaQuery.of(context).size.width * 0.7,
                    // decoration: BoxDecoration(
                    //     border: Border.all(width: 1),
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(10.0)),
                    //     image: DecorationImage(
                    //         fit: BoxFit.fitWidth,
                    //         image: CachedNetworkImageProvider(widget.prodimg))),
                    child: CarouselSlider(
                      options: CarouselOptions(),
                      items: widget.prodimg
                          .map((item) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "${AppWriteConstants.endPoint}/storage/buckets/${AppWriteConstants.prodBucketId}/files/${item.toString()}/view?project=${AppWriteConstants.projectId}"))),
                                //child: Center(child: Text(item.toString())),
                              ))
                          .toList(),
                    ),
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
                        "Product Name : " + widget.prodname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                            "Product Specification : " + widget.prodspec,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13))),
                    SizedBox(height: 8),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                            "Product Price : Rs." + widget.prodprice + "/-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17))),
                    SizedBox(height: 8),
                    TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.amber),
                      onPressed: () {
                        shareData(widget.prodspec);
                      },
                      child:
                          Center(child: const Text("Place Order (or) Enquiry")),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      );
    } else if (screenWidth > 600) {
      // Desktop
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.7,
                    // width: MediaQuery.of(context).size.width * 0.7,
                    // decoration: BoxDecoration(
                    //     border: Border.all(width: 1),
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(10.0)),
                    //     image: DecorationImage(
                    //         fit: BoxFit.fitWidth,
                    //         image: CachedNetworkImageProvider(widget.prodimg))),
                    child: CarouselSlider(
                      options: CarouselOptions(),
                      items: widget.prodimg
                          .map((item) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "${AppWriteConstants.endPoint}/storage/buckets/${AppWriteConstants.prodBucketId}/files/${item.toString()}/view?project=${AppWriteConstants.projectId}"))),
                                //child: Center(child: Text(item.toString())),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        "Product Name : " + widget.prodname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                            "Product Specification : " + widget.prodspec,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15))),
                    SizedBox(height: 5),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text("Selling Price : Rs. " + widget.prodprice,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15))),
                    SizedBox(height: 5),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text("MRP : Rs. " + widget.prodmrp,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15))),
                    TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.amber),
                      onPressed: () {
                        shareData(widget.prodspec);
                      },
                      child: const Text("Place Order (or) Enquiry"),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Column(children: [Text("data")]);
    }
  }
}
