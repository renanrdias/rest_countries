import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../kConstants.dart';

class CountryItem extends StatelessWidget {
  const CountryItem({
    Key? key,
    required this.countryOfficialName,
    required this.countryPopulation,
    required this.countryRegion,
    required this.countryCapital,
    required this.flagImageUrl,
    required this.darkMode,
  }) : super(key: key);

  final String countryOfficialName;
  final int countryPopulation;
  final String countryRegion;
  final String countryCapital;
  final String flagImageUrl;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          borderOnForeground: false,
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color: darkMode ? kCardBackgroundColor : Colors.white,
              border: Border.all(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    flagImageUrl,
                    width: double.infinity,
                    height: 224,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        countryOfficialName,
                        style: darkMode
                            ? kCountryNameStyle
                            : kCountryNameStyle.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Population: ',
                            style: darkMode
                                ? kCountryInfoItem
                                : kCountryInfoItem.copyWith(
                                    color: Colors.black),
                          ),
                          Text(
                            NumberFormat("#,##0", "en_US")
                                .format(countryPopulation),
                            style: darkMode
                                ? kCountryInfoValue
                                : kCountryInfoValue.copyWith(
                                    color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Region: ',
                            style: darkMode
                                ? kCountryInfoItem
                                : kCountryInfoItem.copyWith(
                                    color: Colors.black),
                          ),
                          Text(
                            countryRegion,
                            style: darkMode
                                ? kCountryInfoValue
                                : kCountryInfoValue.copyWith(
                                    color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Capital: ',
                            style: darkMode
                                ? kCountryInfoItem
                                : kCountryInfoItem.copyWith(
                                    color: Colors.black),
                          ),
                          Text(
                            countryCapital,
                            style: darkMode
                                ? kCountryInfoValue
                                : kCountryInfoValue.copyWith(
                                    color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
