import 'package:flutter/material.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';

class HomeRestaurantBoxBuilder extends StatelessWidget {
  const HomeRestaurantBoxBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.amber,
            child: Column(
              children: [
                /***** Restaurant Image *****/
                Container(
                  color: Colors.redAccent,
                  height: 180,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.network(
                        Auth.currentUser!.image!,
                        fit: BoxFit.cover,
                        height: 170,
                      ),
                      Positioned(
                          bottom: -3,
                          right: -10,
                          child: InkWell(
                              onTap: () {},
                              child: const CircleAvatar(
                                  child: Icon(Icons.favorite_border)))),
                    ],
                  ),
                ),
                /***** -END- Restaurant Image *****/

                /***** Restaurant Rate Starts*****/
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      ..._listOfStars(),
                      const Text(
                        '(10)',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                /***** -END- Restaurant Rate Starts*****/

                /***** Restaurant Name*****/
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: FittedBox(
                    child: Text(
                      'restautant name',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                )
                /***** -END- Restaurant Name*****/
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _listOfStars( {int count = 5}) {
    List<Widget> stars = [];
    for (var i = 0; i < count; i++) {
      stars.add(const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 14,
      ));     
    }
    return stars;
  }
}
