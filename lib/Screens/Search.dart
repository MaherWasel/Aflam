import 'package:aflam/models/Movie.dart';
import 'package:aflam/models/SearchedMovie.dart';
import 'package:aflam/providers/SearchedMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends ConsumerStatefulWidget{
  const Search({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SearchState();
  }

}
class _SearchState extends ConsumerState<Search>{
  final _formKey = GlobalKey<FormState>();
  String _inputSearch="";
  void _search(){
    final isVaild = _formKey.currentState!.validate();
    if (!isVaild) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      ref.read(searchedMoviesProvider.notifier).search(_inputSearch);
    });
  }
  @override
  Widget build(BuildContext context) {
    final list=ref.watch(searchedMoviesProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(
          onPressed: _search, 
          icon: const Icon(Icons.search))],
        title: Form(
          key: _formKey,

          child: TextFormField(
            decoration:  InputDecoration(
              label: Text("Search",
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 26
              ),)
            ),
            validator: (value) {
              if (value==null|| value==""){
                return "please enter valid input";

              }
            },
            
            onSaved: (newValue) {
              _inputSearch=newValue!;
            },
          )),
        
      ),
      body: 
        ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    height: 250,
                    width: double.infinity,
                    child: Image.network(list[index].imageUrl,fit: BoxFit.fill,),
                  );
                })
            
          
    );
  }

}