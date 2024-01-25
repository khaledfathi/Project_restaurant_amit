import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/src/controllers/bag/bag_controller.dart';
import 'package:project_restaurant/src/views/main/bag/components/bag_product_box.dart';

class BagScreen extends StatefulWidget {
  //route
  static const String route = 'bag';
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  //screen controller
  final BagController _controller = BagController();
  //values
  List _bagData = [];
  double _overAllPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: FutureBuilder(
            future: _controller.getBagData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _overAllPrice = snapshot.data!['overAllPrice'];
                _bagData = snapshot.data!['cart'];
                return Column(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Column(
                        children: [
                          /***** Header Text *****/
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'My Bag',
                              style: TextStyle(fontSize: 34),
                            ),
                          ),
                          /***** -END- Header Text *****/

                          /***** Products on bag *****/
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  /***** Products List ******/
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: _bagData.length,
                                    itemBuilder: (context, index) {
                                      _overAllPrice += double.parse(
                                          _bagData[index]['price']);
                                      return BagProductBox(
                                          image: _bagData[index]['image'],
                                          productName: _bagData[index]
                                              ['productName'],
                                          restaurantName: _bagData[index]
                                              ['restaurantName'],
                                          quantity: _bagData[index]['quantity'],
                                          price: _bagData[index]['price'],
                                          onTapRemoveFromBag: () {});
                                    },
                                  ),
                                  /***** -END- Products List ******/

                                  /***** Total  ******/
                                  Container(
                                    height: 50,
                                    margin: const EdgeInsets.only(top: 20),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric( horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Total amount',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                _overAllPrice.toString(),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  /***** -END- Total  ******/

                                  /***** Checkout button******/
                                  CustomStanderButton(
                                      text: 'Check Out',
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20, top: 30),
                                      onPressed: () {
                                        setState(() {
                                          _controller.clearBag();
                                        });
                                      }),
                                  /***** -END- Checkout button******/
                                ],
                              ),
                            ),
                            /***** -END- Products on bag *****/
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                /***** Loading ******/
                return const CustomLoading();
                /***** -END- Loading ******/
              }
            }));
  }
}
