import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:night_solver/screens/NavBar.dart';

import 'movie_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text("search");
  String searchValue = "";
  List movies = [Image.asset('poster/avenger.jpg'),
                  Image.asset('poster/blackpanter.jpg'),
                  Image.asset('poster/riddle.jpg'),
                  Image.asset('poster/spiderman.jpg'),
                  Image.asset('poster/Titanic.jpg'),
                  Image.asset('poster/wood.jpg')
  ];
  final controller = ScrollController();
  void signOut(){
    FirebaseAuth.instance.signOut();
  }
  
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if(controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  void navigateToMovieList() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieList()));
  }

  @override
  void dispose() {
    controller.dispose();
  }

  Future fetch() async {
    setState(() {
      movies.addAll([Image.asset('poster/shrek.jpg'), Image.asset('poster/shrek2.jpg'), Image.asset('poster/shrek3.jpg'), Image.asset('poster/shrek4.jpg')]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Center(
            child: customSearchBar,
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 28,
                      ),
                      title: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Type in movie name...',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (
                                (value) => setState(() => searchValue = value)
                        ),
                      ),
                    );                } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('Search a movie');
                  }
                });
              },
              icon: customIcon,
            ),
            IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
          ],
        ),
        body: ListView.builder(
        controller: controller,
        //padding: const EdgeInsets.all(8),
        itemCount: movies.length + 1,
        itemBuilder: (context, index) {
          if (index < movies.length) {
            final movie = movies[index];

            return movie;
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator())
            );
          }
        },
      )
    );
  }
}