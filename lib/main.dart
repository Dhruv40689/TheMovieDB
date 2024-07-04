import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'data.dart';
import 'Datapicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(900, 1100),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          home: HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService dataService = DataService();
  List<Data> movies = [];
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    setState(() {
      isLoading = true;
    });
    List<Data> newMovies = await dataService.fetchData(currentPage);
    setState(() {
      movies.addAll(newMovies);
      currentPage++;
      isLoading = false;
    });
  }

  void _loadMoreMovies() {
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies', style: TextStyle(fontSize: 24.sp)),
      ),
      body: isLoading && movies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : MovieList(movies: movies, loadMore: _loadMoreMovies),
    );
  }
}
