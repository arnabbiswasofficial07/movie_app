import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/model/moviedetail.dart';
import 'package:movie_app/boxes.dart';
import 'package:movie_app/widget/moviedetails_dialog.dart';

class MoviedetailPage extends StatefulWidget {
  @override
  _MoviedetailPageState createState() => _MoviedetailPageState();
}

class _MoviedetailPageState extends State<MoviedetailPage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Movie App'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Moviedetail>>(
          valueListenable: Boxes.getMoviedetails().listenable(),
          builder: (context, box, _) {
            final moviedetails = box.values.toList().cast<Moviedetail>();

            return buildContent(moviedetails);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => MoviedetailDialog(
              onClickedDone: addMoviedetail,
            ),
          ),
        ),
      );

  Widget buildContent(List<Moviedetail> moviedetails) {
    if (moviedetails.isEmpty) {
      return Center(
        child: Text(
          'No movies added yet',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Text(
            'Movie List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.red[400],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: moviedetails.length,
              itemBuilder: (BuildContext context, int index) {
                final moviedetail = moviedetails[index];

                return buildMoviedetail(context, moviedetail);
              },
            ),
            // child: ListWheelScrollView(
            //   children: ,),
          )
        ],
      );
    }
  }

  Widget buildMoviedetail(
    BuildContext context,
    Moviedetail moviedetail,
  ) {
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        title: Text(
          moviedetail.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          moviedetail.director,
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, moviedetail),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Moviedetail moviedetail) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MoviedetailDialog(
                  moviedetail: moviedetail,
                  onClickedDone: (name, director) =>
                      editMoviedetail(moviedetail, name, director),
                ),
              )),
            ),
          ),
          Expanded(
            child: TextButton.icon(
                onPressed: () => deleteMoviedetail(moviedetail),
                icon: Icon(Icons.delete),
                label: Text('Delete')),
          )
        ],
      );

  Future addMoviedetail(String name, String director) async {
    final moviedetail = Moviedetail()
      ..name = name
      ..director = director;

    final box = Boxes.getMoviedetails();
    box.add(moviedetail);
  }

  void editMoviedetail(Moviedetail moviedetail, String name, String director) {
    moviedetail.name = name;
    moviedetail.director = director;

    moviedetail.save();
  }

  void deleteMoviedetail(Moviedetail moviedetail) {
    moviedetail.delete();
  }
}
