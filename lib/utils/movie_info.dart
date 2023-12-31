import 'dart:collection';

import 'package:night_solver/utils/size_utils.dart';

class MovieInfo {
  final String movies_url = "https://image.tmdb.org/t/p/w500/";
  late String title;
  late String urlImage;
  late double rating;
  late String synopsis;
  late String id;
  late List<dynamic> genres;
  late bool canDelete;
  MovieInfo(dynamic movie) {
    // TODO CHECK null values
    this.title = movie["title"] == null || movie["title"] == "" ? "No title found": movie["title"];
    this.urlImage = movie["poster_path"] == null ? "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg" : movies_url + movie["poster_path"];
    this.rating = movie["vote_average"] == null ? 0 : CustomRound(movie["vote_average"]/2);
    this.synopsis = movie["overview"] == null || movie["overview"] == "" ? "No synopsis" : movie["overview"];
    this.genres = movie["genres"] == null ? [const {'id': -1, 'name': ""}] : movie["genres"];
    this.canDelete = movie['can_delete'] == true;
    this.id = movie["id"] == null ? "-1" : movie["id"].toString();
  }
}