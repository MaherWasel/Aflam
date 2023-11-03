
import 'package:aflam/Screens/AboutUs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomeDrawer extends StatelessWidget{
   const HomeDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      width: 220,
      child: Column(
        children: [
          DrawerHeader(
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(
                FirebaseAuth.instance.currentUser!.uid
              ).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState==ConnectionState.waiting){
                  return const SizedBox(
                    width: double.infinity,
                    child: CircularProgressIndicator());

                }
                else {
                  final imageUrl=snapshot.data!["imageUrl"];
                  return SizedBox(
                    width: double.infinity,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: Image.network(imageUrl,fit: BoxFit.fitHeight,).image),
                  );
                }
              },)
              ),
          const SizedBox(
            height: 6,
          ),
           ListTile(
            title: const Text("Profile"),
            onTap: (){
              
            },
          ),
          const SizedBox(
            height: 6,
          ),
           ListTile(
            title: const Text("About Us"),
            onTap: (){
              Navigator.push(context, 
              PageTransition(
                duration: const Duration(milliseconds: 520),
                type: PageTransitionType.leftToRight,
                child: const AboutUs()));
            },
          ),
          ListTile(
            title: const Text("Sign Out"),
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
          )
        ]),
    );
  }
}