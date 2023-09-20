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
  bool loading = false;
  String _inputSearch = "";
  void _search() {
    final isVaild = _formKey.currentState!.validate();
    if (!isVaild) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      loading = true;
      ref.read(searchedMoviesProvider.notifier).search(_inputSearch);
      loading = false;
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
          title: Form(
              key: _formKey,
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
              )),
        ),
        body: loading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      list[index].imageUrl,
                      fit: BoxFit.fill,
                    ),
                  );
                }));
  }
}
