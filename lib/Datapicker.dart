import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'data.dart';

class MovieList extends StatefulWidget {
  final List<Data> movies;
  final VoidCallback loadMore;

  MovieList({required this.movies, required this.loadMore});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return Container(
                margin: EdgeInsets.all(8.w),
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Image.network('https://image.tmdb.org/t/p/w500${movie.path}'),
                    SizedBox(height: 8.h),
                    Text(
                      'Release Date: ${movie.releaseDate}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Adult: ${movie.adult ? "Yes" : "No"}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      movie.overview,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: widget.loadMore,
          child: Text('Load More', style: TextStyle(fontSize: 16.sp)),
        ),
      ],
    );
  }
}
