import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget{
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      width: 220,
      child: Column(
        children: [
          DrawerHeader(
            
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.25),
                  Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.5),
                  Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.75)

                ])
            ),
            child: const SizedBox(
              width: double.infinity,
              height: 150,
              child: Icon(Icons.person_2_rounded,size: 100,))),
          const SizedBox(
            height: 6,
          ),
           ListTile(
            title: Text("Profile"),
            onTap: (){},
          ),
          const SizedBox(
            height: 6,
          ),
           ListTile(
            title: Text("About Us"),
            onTap: (){},
          )
        ]),
    );
  }

}