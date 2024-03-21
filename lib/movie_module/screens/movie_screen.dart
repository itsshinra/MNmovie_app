import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../servies/movie_service.dart';
import 'movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MN Cinema'),
      ),
      body: _builBody(),
    );
  }

  Widget _builBody() {
    return Center(
      child: FutureBuilder<MovieModel>(
        future: MovieService.getAPI(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error Movie Reading : ${snapshot.error.toString()}");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildGridView(snapshot.data);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildGridView(MovieModel? movieModel) {
    if (movieModel == null) {
      return SizedBox();
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1/2,
      ),
      itemCount: movieModel.results.length,
      itemBuilder: (context, index) {
        return _buildItem(movieModel.results[index]);
      },
    );
  }

  Widget _buildItem(Result item){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailPage(item),),);
      },
      child: Card(
        child: ListTile(
          title: Text("${item.titleOrName}"),
          subtitle: Image.network(item.posterPath),
        ),
      ),
    );
  }
}
