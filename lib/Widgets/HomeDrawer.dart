
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
      child: Column(children: [
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(
                FirebaseAuth.instance.currentUser!.uid
              ).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState==ConnectionState.waiting){
                  return SizedBox(
                    width: double.infinity,
                    child: CircularProgressIndicator());
                }
                else {
                  final info=snapshot.data;
                return CircleAvatar(
                  radius: 100,
                  backgroundImage: Image.network(info!["imageUrl"]).image);
              }}
            )
              ),
          const SizedBox(
            height: 6,
          ),
           ListTile(
            title: Text("Profile"),
            onTap: (){
              
            },
          ),
          const SizedBox(
            height: 6,
          ),
           ListTile(
            title: Text("About Us"),
            onTap: (){
              Navigator.push(context, 
              PageTransition(
                duration: Duration(milliseconds: 520),
                type: PageTransitionType.leftToRight,
                child: AboutUs()));
            },
          ),
          ListTile(
            title: Text("Sign Out"),
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
          )
        ]),
    );
  }
}
