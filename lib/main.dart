import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textController = TextEditingController();
  String countryCode = '65';

  _launchUrl() async {
    var number = int.tryParse(_textController.text);
    var whatsappUrlAndroid = 'whatsapp://send?phone=$countryCode$number';

    if (await canLaunchUrl(Uri.parse(whatsappUrlAndroid))) {
      await launchUrlString(Uri.parse(whatsappUrlAndroid).toString(), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occured when trying to launch WhatsApp'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text('Enter the number (with country code)'),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              'WhatsApp Redir',
              style: TextStyle(
                color: Color.fromARGB(255, 56, 172, 60),
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Text(
                'Open a new WhatsApp chat without adding a new contact.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true, // optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        setState(() {
                          countryCode = country.phoneCode;
                        });
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: height * 0.08,
                    width: width * 0.18,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      '+$countryCode',
                      style: const TextStyle(fontSize: 20),
                    )),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                  width: width * 0.60,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(20)),
                        focusedBorder:
                            OutlineInputBorder(borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(20))),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                    controller: _textController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 46,
            ),
            TextButton(
                child: const Text(
                  'Open in WhatsApp',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () async {
                  _launchUrl();
                }),
          ],
        ),
      ),
    );
  }
}
