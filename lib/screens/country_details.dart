import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

import '../kConstants.dart';

class CountryDetails extends StatefulWidget {
  const CountryDetails({Key? key, required this.isDarkMode}) : super(key: key);

  final bool isDarkMode;

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  late bool _isDarkMode;

  @override
  void initState() {
    _isDarkMode = widget.isDarkMode;
    super.initState();
  }

  static String _utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  Widget _infoBuilder(
      String infoTitle, Map selectedInfo, String selectedInfoKey, int? index) {
    return Row(
      children: [
        Text(
          infoTitle,
          style: _isDarkMode
              ? kCountryInfoItem
              : kCountryInfoItem.copyWith(
                  color: Colors.black,
                ),
        ),
        Text(
          index != null
              ? _utf8convert(selectedInfo[selectedInfoKey][index])
              : selectedInfoKey == 'population'
                  ? NumberFormat("#,##0", "en_US")
                      .format(selectedInfo[selectedInfoKey])
                  : _utf8convert(selectedInfo[selectedInfoKey].toString()),
          style: _isDarkMode
              ? kCountryInfoValue
              : kCountryInfoValue.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ModalRoute.of(context)!.settings.arguments as Map;
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
              'Where in the world',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              InkWell(
                onTap: () => Navigator.pop(context, _isDarkMode),
                child: Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 5,
                  color: _isDarkMode ? kCardBackgroundColor : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeroIcon(
                          HeroIcons.arrowLeft,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Back',
                          style: _isDarkMode
                              ? kCountryInfoValue
                              : kCountryInfoValue.copyWith(
                                  color: Colors.black,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Image.network(
                selectedCountry['flags']['png'],
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 50),
              Text(
                selectedCountry['name']['common'],
                style: _isDarkMode
                    ? kCountryNameStyle
                    : kCountryNameStyle.copyWith(
                        color: Colors.black,
                      ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Native Name: ',
                    style: _isDarkMode
                        ? kCountryInfoItem
                        : kCountryInfoItem.copyWith(
                            color: Colors.black,
                          ),
                  ),
                  Text(
                    _utf8convert(selectedCountry['name']['nativeName']
                            [selectedCountry['languages'].keys.toList().last]
                        ['common']),
                    style: _isDarkMode
                        ? kCountryInfoValue
                        : kCountryInfoValue.copyWith(color: Colors.black),
                  )
                ],
              ),
              _infoBuilder('Population: ', selectedCountry, 'population', null),
              _infoBuilder('Region: ', selectedCountry, 'region', null),
              _infoBuilder('Sub Region: ', selectedCountry, 'subregion', null),
              _infoBuilder('Capital: ', selectedCountry, 'capital', 0),
              const SizedBox(height: 50),
              _infoBuilder('Top Level Domain: ', selectedCountry, 'tld', 0),
              Row(
                children: [
                  Text(
                    'Currencies: ',
                    style: _isDarkMode
                        ? kCountryInfoItem
                        : kCountryInfoItem.copyWith(
                            color: Colors.black,
                          ),
                  ),
                  Text(
                    selectedCountry['currencies']
                            [selectedCountry['currencies'].keys.toList()[0]]
                        ['name'],
                    style: _isDarkMode
                        ? kCountryInfoValue
                        : kCountryInfoValue.copyWith(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Languages: ',
                    style: _isDarkMode
                        ? kCountryInfoItem
                        : kCountryInfoItem.copyWith(
                            color: Colors.black,
                          ),
                  ),
                  Text(
                    '${selectedCountry['languages'].keys.map((e) => selectedCountry['languages'][e]).toList().join(', ')}',
                    style: _isDarkMode
                        ? kCountryInfoValue
                        : kCountryInfoValue.copyWith(color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Text(
                'Border Countries:',
                style: _isDarkMode
                    ? kCountryInfoItem.copyWith(
                        fontSize: kCountryInfoItem.fontSize! * 1.1)
                    : kCountryInfoItem.copyWith(
                        fontSize: kCountryInfoItem.fontSize! * 1.1,
                        color: Colors.black),
              ),
              if (selectedCountry['borders'] != null)
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemExtent: 70,
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedCountry['borders'].length ?? 0,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(
                            left: 0, right: 8, top: 10, bottom: 10),
                        color:
                            _isDarkMode ? kCardBackgroundColor : Colors.white,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 8),
                          child: Text(
                            selectedCountry['borders'][index],
                            style: _isDarkMode
                                ? kCountryInfoValue
                                : kCountryInfoValue.copyWith(
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

              // Row(
              //   children: [
              //     ...selectedCountry['borders'].map((e) {
              //       return Card(
              //         margin: const EdgeInsets.symmetric(
              //             horizontal: 0, vertical: 10),
              //         color: _isDarkMode ? kCardBackgroundColor : Colors.white,
              //         elevation: 5,
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 14.0, vertical: 8),
              //           child: Text(
              //             e,
              //             style: _isDarkMode
              //                 ? kCountryInfoValue
              //                 : kCountryInfoValue.copyWith(
              //                     color: Colors.black,
              //                   ),
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //   ],
              // ),