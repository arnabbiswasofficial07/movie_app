import 'package:hive/hive.dart';
import 'package:movie_app/model/moviedetail.dart';

class Boxes {
  static Box<Moviedetail> getMoviedetails() =>
      Hive.box<Moviedetail>('moviedetails');
}
