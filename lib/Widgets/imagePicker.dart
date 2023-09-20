import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;
  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child:_pickedImageFile ==null? Stack(
                          alignment: Alignment.center,
                          children:[  
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              margin: const EdgeInsets.all(10),
                              child:  const Icon( Icons.person_2_rounded,size: 150,), ),
                            
                          Container(          
                            decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child:  Text("pick a picture",style: GoogleFonts.quicksand(color: Colors.white,),),
                            )),
                          ], 
                        ): CircleAvatar(
                          
            radius:100,
             backgroundColor: Colors.grey,
                 foregroundImage:
                       FileImage(_pickedImageFile!,) 
    ));
                    
  }
}