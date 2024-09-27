import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Number Input with Country Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Phone Number Input')),
        body: PhoneNumberForm(),
      ),
    );
  }
}

class PhoneNumberForm extends StatefulWidget {
  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _countryCode = '+1'; // Default country code
  String _countryFlag = '🇺🇸'; // Default country flag

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          _countryCode = country.phoneCode; // Update selected country code
          _countryFlag = country.flagEmoji; // Update selected country flag
        });
      },
      favorite: ['US', 'IN'], // Add favorite countries
      showPhoneCode: true, // Show phone code
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Full widget border
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Minimize space occupied
                children: <Widget>[
                  // Country Picker with Flag and Code
                  GestureDetector(
                    onTap: _showCountryPicker,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal padding
                      child: Row(
                        children: [
                          Text(
                            _countryFlag, // Display country flag
                            style: TextStyle(fontSize: 20), // Adjust font size for the flag
                          ),
                          SizedBox(width: 4), // Small space between flag and code
                          Text(
                            _countryCode,
                            style: TextStyle(fontSize: 16), // Font size for country code
                          ),
                          SizedBox(width: 4), // Small space before the dropdown icon
                          Icon(Icons.arrow_drop_down), // Dropdown icon
                        ],
                      ),
                    ),
                  ),

                  // Vertical Divider
                  Container(
                    height: 40, // Adjust height to fit the text field
                    width: 1,
                    color: Colors.grey, // Color of the divider
                  ),

                  // Phone number input
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none, // Removes the default text field border
                        hintText: 'Phone Number',
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8), // Tighten padding
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        _phoneNumber = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process the input
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
