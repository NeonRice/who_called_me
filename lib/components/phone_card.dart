// Phone number card class
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:intl/intl.dart';

class PhoneCard extends StatelessWidget {
  PhoneCard(
      {Key? key,
      required this.number,
      this.onPressed,
      this.lastUpdate,
      this.icon = Icons.call})
      : super(key: key);

  final String number;
  final void Function(String)? onPressed;
  final DateTime? lastUpdate;
  final IconData icon;
  final DateFormat format = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              icon,
              size: 40,
            ), //Icon goes here
            title: Text(
              number,
              style: const TextStyle(fontSize: 25, height: 2),
            ),
            subtitle: Text(CountryWithPhoneCode.getCountryDataByPhone(number)
                    ?.countryName ??
                "Unknown country"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Text(
                'Last updated at: ',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(lastUpdate == null ? "-" : format.format(lastUpdate!),
                  style: const TextStyle(fontStyle: FontStyle.italic)),
              TextButton.icon(
                  onPressed: () {
                    if (onPressed != null) {
                      onPressed!(number);
                    }
                  },
                  icon: const Icon(
                    Icons.refresh_outlined,
                    size: 24,
                  ),
                  label: const Text("Refresh")),
            ],
          ),
        ],
      ),
    );
  }
}
