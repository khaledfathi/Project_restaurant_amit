import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_no_internet.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';
import 'package:project_restaurant/core/states/bag/changes/bag_cubit.dart';
import 'package:project_restaurant/core/states/internet_checker/internet/internet_cubit.dart';
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
        title: const Text('My Bag'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocProvider(
        create: (context) => BagCubit(),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BlocConsumer<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected) {
                    return BlocConsumer<BagCubit, BagState>(
                        builder: (context, state) {
                          return FutureBuilder(
                              future: _controller.getBagData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  _overAllPrice = snapshot.data!['overAllPrice'];
                                  _bagData = snapshot.data!['cart'];
                                  if (_bagData.isNotEmpty) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            children: [
                                              /***** Products on bag *****/
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      /***** Products List ******/
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: _bagData.length,
                                                        itemBuilder: (context, index) {
                                                          return BagProductBox(
                                                            image: _bagData[index] ['image'],
                                                            productName: _bagData[ index] ['productName'],
                                                            restaurantName: _bagData[index][ 'restaurantName'],
                                                            quantity: _bagData[ index] ['quantity'],
                                                            price: _bagData[ index] ['totalPrice'],
                                                            onTapRemoveFromBag: () async {
                                                              _bagData.removeAt( index);
                                                              await BagCubit.get( context) .removeFromCard( index) .then( (overAllPrice) {
                                                                _overAllPrice = overAllPrice;
                                                              });
                                                            },
                                                            onQuanityChange: (quantity) async {
                                                              double totalPrice = double.parse(_bagData[ index] [ 'price']) * quantity;
                                                              _bagData[index][ 'totalPrice'] = totalPrice .toStringAsFixed( 2);
                                                              await BagCubit.get( context) .changeQuantity(
                                                                productIndex: index,
                                                                quantity: quantity .toInt(),
                                                              ) .then( (overAllPrice) {
                                                                _overAllPrice = overAllPrice;
                                                              });
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      /***** -END- Products List ******/

                                                      /***** Total  ******/
                                                      Container(
                                                        height: 50,
                                                        margin: const EdgeInsets .only(top: 20),
                                                        width: double.infinity,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                            padding: const EdgeInsets .symmetric( horizontal: 20),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment .spaceBetween,
                                                              children: [
                                                                const Text( 'Total amount', style: TextStyle( fontSize: 14),),
                                                                FittedBox(
                                                                  child: Text( '${_overAllPrice.toStringAsFixed(2)}\$',
                                                                    style: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold),
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                      ),
                                                      /***** -END- Total  ******/

                                                      /***** Checkout button******/
                                                      CustomStanderButton(
                                                          text: 'Check Out',
                                                          margin: const EdgeInsets .only( left: 20, right: 20, top: 30),
                                                          onPressed: () {
                                                            print(Auth.currentUser!.id);
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
                                    return const Center(
                                      child: Text('Bag is Empty'),
                                    );
                                  }
                                } else {
                                  /***** Loading ******/
                                  return const CustomLoading();
                                  /***** -END- Loading ******/
                                }
                              });
                        },
                        listener: (context, state) {});
                  } else {
                    return const CustomNoInternet();
                  }
                },
                listener: (context, state) {})),
      ),
    );
  }
}
