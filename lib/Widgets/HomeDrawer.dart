import 'dart:io';

import 'package:aflam/Screens/AboutUs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomeDrawer extends StatefulWidget{
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}


class _HomeDrawerState extends State<HomeDrawer> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  var _imageIsOptained = false;
  File? _optainedImage;
@override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async{
    final userData = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
    
    if(userData.data()!['imageUrl'] != null){
       setState(() {
      _imageIsOptained = true;
    });
    }
   

    _optainedImage = userData.data()!["imageUrl"];
  }

  
  
  @override
  Widget build(BuildContext context) {
    
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
            child: CircleAvatar(
              radius: 90,
              backgroundImage: FileImage(_optainedImage!),)
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
                duration: Duration(milliseconds: 650),
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