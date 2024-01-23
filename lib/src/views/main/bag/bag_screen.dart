import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/controllers/bag/bag_controller.dart';

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
  //cart data
  late List<Map> _bagData;

  @override
  Widget build(BuildContext context) {
    _bagData = _controller.getBagData();
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text('My Bag', style: TextStyle(fontSize: 34),),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _bagData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                margin: const EdgeInsets.all(10),
                                color: Colors.amber,
                                child: Center(
                                  child: Text(
                                      'Product ID : ${_bagData[index]['productId']}\n Quantity : ${_bagData[index]['quantity']}'),
                                ),
                              );
                            },
                          ),
                          Container(
                            color: Colors.blue,
                            height: 50,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text('Total Amount'),
                          ),
                          CustomStanderButton(
                            text: 'Check Out',
                            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                            onPressed: (){
                              setState(() {
                                _controller.clearBag();
                              });
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // CustomStanderButton(
            //   margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            //   text: 'Check Out',
            //   onPressed: () {},
            // )
          ],
        ));
  }
}
