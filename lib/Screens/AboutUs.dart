import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget{
  const AboutUs({super.key});
  Future<void> _launchUrl(String url)async {
    final uri=Uri.tryParse(url);
    if (!await launchUrl(
      uri!,mode: LaunchMode.externalApplication)){
        throw "can not launch";
      }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Who Are We ?",
        style: GoogleFonts.lato(
          fontSize: 32,
          color: Colors.white
        ),)
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
            SizedBox(
              width: 200,
              child:  Text("The app was developed by two undergraduate kfupm students who wanted to create an application that could be found useful by others. ",
              overflow: TextOverflow.clip,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 18
              ),),
            ), SizedBox(
              width: 140,
              child: Image.asset("assets/images/kfupm.gif",))
          ],),
          SizedBox(height: 80,),

          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
            
            SizedBox(
              width: 180,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Maher Al-ShakeSaleh : Software engineering student at kfupm',
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16
                  ),),
                  
                  GestureDetector(
                    onTap:(){
                      _launchUrl("https://www.linkedin.com/in/maher-al-shakesaleh-23880223a");
                    }, 
                    
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: 80,
                      height: 70,
                      child: Image.asset("assets/images/linkedin.png")))
                ],
              ),
            ),
              SizedBox(
              width: 180,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Abdullah Al-Majed: Computer Science student at kfupm',
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16
                  ),),
                  
                  GestureDetector(
                    onTap: (){
                      _launchUrl("https://www.linkedin.com/in/abdullah-almajed-4170b1259");
                    }, 
                    
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: 80,
                      height: 70,
                      child: Image.asset("assets/images/linkedin.png")))
                ],
              ),
            ),
          ],),
          

          
        ],
      ),
    );
  }

}