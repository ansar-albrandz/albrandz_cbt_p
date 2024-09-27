import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
class CountryCodeBuilder extends StatefulWidget {
  final void Function(Country) onSelect;
  CountryData? country;
   bool canSelect = true;
   CountryCodeBuilder({super.key, required this.onSelect, required this.canSelect,this.country});

  @override
  State<CountryCodeBuilder> createState() => _CountryCodeBuilderState();
}

class _CountryCodeBuilderState extends State<CountryCodeBuilder> {
  String _countryCode = '+91'; // Default country code
  String _countryFlag = '🇮🇳';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.canSelect){
          _showCountryPicker();
        }
      },
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal padding
        child: Row(
          children: [
            Text(
              widget.country?.flag??_countryFlag, // Display country flag
              style: const TextStyle(fontSize: 20), // Adjust font size for the flag
            ),
            const SizedBox(width: 4), // Small space between flag and code
            Text(
              widget.country?.code??_countryCode,
              style: const TextStyle(fontSize: 16), // Font size for country code
            ),
            const SizedBox(width: 4), // Small space before the dropdown icon
            const Icon(Icons.arrow_drop_down), // Dropdown icon
          ],
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        widget.onSelect(country);
        setState(() {
          _countryCode = country.phoneCode; // Update selected country code
          _countryFlag = country.flagEmoji; // Update selected country flag
        });
      },
      favorite: ['IN'], // Add favorite countries
      showPhoneCode: true, // Show phone code
    );
  }
}

class CountryData{
  String? code;
  String? flag;

  CountryData({ this.code,  this.flag});
}

