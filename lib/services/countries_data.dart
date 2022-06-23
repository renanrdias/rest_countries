import './networking.dart';

const String url = 'https://restcountries.com/v3.1/all';
const String urlByRegion = 'https://restcountries.com/v3.1/region/';
// const String urlByCountryName = 'https://restcountries.com/v3.1/name/';

class CountriesData {
  Future<dynamic> getAllCountriesData() async {
    NetworkingHelper networkingHelper = NetworkingHelper(url: url);

    var allCountriesData = await networkingHelper.getData();

    return allCountriesData;
  }

  Future<dynamic> getCountriesDataByRegion(String region) async {
    NetworkingHelper networkingHelper =
        NetworkingHelper(url: urlByRegion + region);

    var regionCountriesData = await networkingHelper.getData();

    return regionCountriesData;
  }
}
