import 'package:aflam/Screens/DetailedMovie.dart';
import 'package:aflam/providers/SearchedMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SearchState();
  }
}

class _SearchState extends ConsumerState<Search> {
  final _formKey = GlobalKey<FormState>();
  String _inputSearch = "";
  void _search() {
    final isVaild = _formKey.currentState!.validate();
    if (!isVaild) {
      return;
    }
    _formKey.currentState!.save();
    setState(()  {
       var input=_inputSearch.split(" ");
       String text="";
       for (int i=0;i<input.length;i++){
          text+=input[i];
       }
       ref.read(searchedMoviesProvider.notifier).search(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(searchedMoviesProvider);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: _search, icon: const Icon(Icons.search))
          ],
        
        ),
        body:Column(
              children: [
                Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.deepPurpleAccent
                  )
                ),
                child: TextFormField(
                  style: GoogleFonts.lato(
                      color: Colors.deepPurpleAccent, fontSize: 24),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    label: Container(
                      transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                      child: Text(
                        "Search",
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "please enter valid input";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _inputSearch = newValue!;
                  },
                ),
              )),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          height: 400,
                          
                          width: 300,
                          child: InkWell(
                            onTap: () {
                                Navigator.push(context, 
                                  MaterialPageRoute(builder: (context) => DetailedMovieScreen(movie: list[index]),));
                            },
                            child: Image.network(
                              list[index].imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ));
  }
}
