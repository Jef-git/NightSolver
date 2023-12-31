import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:night_solver/screens/preference_page.dart';
import 'movie_list.dart';
import 'recommendation_movie_list.dart';
import 'salons.dart';
import 'friends_screen.dart';

class NavBar extends StatelessWidget{
  final user = FirebaseAuth.instance.currentUser!;
  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(user.displayName != null ? user.displayName as String : 'no username'),
              accountEmail: Text(user.email as String)
          ),
          /*
          //TODO: change recomandation into my recomandation
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Recommendations'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RecommendationMovieList())),
          ),

           */
          ListTile(
            leading: Icon(Icons.face),
            title: Text('Friends'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Friends())),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Rooms'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Salons())),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('My Movies'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieList())),
          ),
          /*
          //TODO: add setting page
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),

           */

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => {
              FirebaseAuth.instance.signOut(),
              Navigator.of(context).pop()
              },
          ),
        ],
      ),
    );
  }
}