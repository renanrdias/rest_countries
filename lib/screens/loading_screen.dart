import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/all_countries_screen.dart';
import '../kConstants.dart';
import '../services/countries_data.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final CountriesData _countries = CountriesData();

  Future<void> _fetchCountriesData() async {
    var countriesData = await _countries.getAllCountriesData();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => AllCountriesScreen(data: countriesData),
      ),
    );
  }

  @override
  void initState() {
    _fetchCountriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
          return const DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xffced8e2),
            ),
          );
        },
      ),
    );
  }
}
