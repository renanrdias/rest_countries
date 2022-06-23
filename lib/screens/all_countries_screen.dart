// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:rest_countries_projects/screens/country_details.dart';
import 'dart:convert' show utf8;

import '../components/country_item.dart';
import '../kConstants.dart';
import '../services/countries_data.dart';

class AllCountriesScreen extends StatefulWidget {
  const AllCountriesScreen({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  State<AllCountriesScreen> createState() => _AllCountriesScreenState();
}

class _AllCountriesScreenState extends State<AllCountriesScreen> {
  late List<dynamic> _data;
  late List<dynamic> _filteredResult;
  String _selectedRegion = 'All Regions';

  bool _isDarkMode = true;

  @override
  void initState() {
    _data = [...widget.data];
    _filteredResult = [...widget.data];
    super.initState();
  }

  Future<void> _fetchCountriesByRegionData(String region) async {
    final CountriesData _countriesDataHelper = CountriesData();
    var countriesData;

    if (region == 'All Regions') {
      countriesData = await _countriesDataHelper.getAllCountriesData();
    } else {
      countriesData =
          await _countriesDataHelper.getCountriesDataByRegion(region);
    }
    setState(() {
      _data = countriesData;
      _filteredResult = countriesData;
    });
  }

  static String _utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  void _filterByName(String name) {
    setState(() {
      // _filteredResult = [..._data];
      _filteredResult = _data
          .where((e) => e['name']['common']
              .toLowerCase()
              .trim()
              .contains(name.toLowerCase().trim()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isDarkMode ? kScaffoldBackgroundColor : const Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: _isDarkMode ? kAppBarBackgroundColor : Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Where in the World?',
              style: _isDarkMode
                  ? kAppBarLeading
                  : kAppBarLeading.copyWith(color: Colors.black),
            ),
            InkWell(
              onTap: () => setState(() {
                _isDarkMode = !_isDarkMode;
              }),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeroIcon(
                    HeroIcons.moon,
                    solid: _isDarkMode,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Dark Mode',
                    style: _isDarkMode
                        ? kAppBarThemeMode
                        : kAppBarThemeMode.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Card(
                  color: _isDarkMode ? const Color(0xff2b3743) : Colors.white,
                  elevation: 5,
                  child: TextFormField(
                    onChanged: (value) => _filterByName(value),
                    style: _isDarkMode
                        ? kCountryInfoItem
                        : kCountryInfoItem.copyWith(color: Colors.black),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: HeroIcon(
                          HeroIcons.search,
                          color: _isDarkMode
                              ? Colors.white
                              : const Color(0xffadadad),
                          size: 25,
                        ),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(maxHeight: 50, maxWidth: 100),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      filled: true,
                      fillColor:
                          _isDarkMode ? const Color(0xff2b3743) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search for a country...',
                      hintStyle: _isDarkMode
                          ? kCountryInfoItem
                          : kCountryInfoItem.copyWith(
                              color: const Color(0xffc2c2c2),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 250,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(left: 15.0, top: 30),
              decoration: BoxDecoration(
                  color: _isDarkMode ? const Color(0xff2b3743) : Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6,
                    )
                  ]),
              child: DropdownButton(
                value: _selectedRegion,
                underline: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                  ),
                ),
                isExpanded: true,
                borderRadius: BorderRadius.circular(12.0),
                dropdownColor:
                    _isDarkMode ? const Color(0xff2b3743) : Colors.white,
                hint: Text(
                  'Filter by Region',
                  style: _isDarkMode
                      ? kCountryInfoItem
                      : kCountryInfoItem.copyWith(color: Colors.black),
                ),
                icon: HeroIcon(
                  HeroIcons.chevronDown,
                  color: _isDarkMode ? const Color(0xfffeffff) : Colors.black,
                  size: 15,
                ),
                items: <String>[
                  'All Regions',
                  'Africa',
                  'America',
                  'Asia',
                  'Europe',
                  'Oceania'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: _isDarkMode
                          ? kCountryInfoItem
                          : kCountryInfoItem.copyWith(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  _fetchCountriesByRegionData(value!);
                  setState(() {
                    _selectedRegion = value;
                  });
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredResult.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CountryDetails(isDarkMode: _isDarkMode),
                      settings:
                          RouteSettings(arguments: _filteredResult[index]!),
                    ),
                  ),
                  child: CountryItem(
                    darkMode: _isDarkMode,
                    countryOfficialName: _filteredResult[index]['name']
                            ['common'] ??
                        'Not Available',
                    countryPopulation:
                        _filteredResult[index]['population'] ?? 0,
                    countryRegion:
                        _filteredResult[index]['region'] ?? 'Not Available',
                    countryCapital: _filteredResult[index]['capital'] == null
                        ? 'Not Available'
                        : _utf8convert(
                            _filteredResult[index]['capital'][0] as String),
                    flagImageUrl: _filteredResult[index]['flags']['png'] ??
                        'Not Available',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
