import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';

class ShopScreen extends StatefulWidget {
  //route
  static const String route = 'shop';

  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Stream _internetConnection;

  @override
  void initState() {
    _internetConnection = Globals.connection.onStatusChange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: StreamBuilder(
            stream: _internetConnection,
            builder: (context, snapshot) {
              debugPrint('ShopScreen : internet stream status = ${snapshot.connectionState}');
              if (snapshot.connectionState == ConnectionState.active) {
                //show restaurants categories
              } else {
                //show loading 
              }
              return Text('Test');
            })
        //   SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.all(10),
        //     child: Column(
        //       children: [
        //        Row(
        //         children: [
        //           Expanded(child: Text('Category Name ')),
        //           Expanded(child: Text('Category Image ')),
        //         ],
        //        )
        //       ],
        //     ),
        //   ),
        // )

        );
  }
}
