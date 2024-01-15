import 'package:flutter/material.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';

class ProfileDetailsBlock extends StatefulWidget {
  const ProfileDetailsBlock({super.key});

  @override
  State<ProfileDetailsBlock> createState() => _ProfileDetailsBlockState();
}

class _ProfileDetailsBlockState extends State<ProfileDetailsBlock> {
  //values 

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /***** User Image *****/
          Expanded(
              flex: 2,
              child: Center(
                  child: Container(
                      width: 64,
                      height: 64,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Image.network(Auth.currentUser!.image!, 
                        loadingBuilder: (context, child, loadingProgress) {//loading b4 display image
                          if (loadingProgress == null ) {
                            return child ;
                          }
                          return const CircularProgressIndicator(); 
                        }
                      )
                      ),
                      ),
                      ),
          /***** -END- User Image *****/

          Expanded(
              flex: 7,
              child: SizedBox(
                height: 64,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /***** User Name *****/
                    Text(
                      Auth.currentUser!.name!,
                      style: const TextStyle(fontSize: 18),
                    ),
                    /***** -END- User Name *****/

                    /***** User Email *****/
                    Text(
                      Auth.currentUser!.email!,
                      style: const TextStyle(color: Color.fromRGBO(155, 155, 155, 1)),
                    ),
                    /***** -END- User Email *****/
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
