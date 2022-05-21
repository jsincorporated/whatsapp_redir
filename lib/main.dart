import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(MaterialApp(
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

  _launchUrl() async {
    var number = int.tryParse(_textController.text);
    var whatsappURl_android = 'whatsapp://send?phone=$number';

    if (await canLaunchUrl(Uri.parse(whatsappURl_android))) {
      await launchUrlString(Uri.parse(whatsappURl_android).toString(),
          mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 245, 245),
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text('Enter the number (with country code)'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'WhatsApp Redir',
              style: TextStyle(
                color: Color.fromARGB(255, 56, 172, 60),
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Text(
                'Open a new WhatsApp chat without adding a new contact. E.g. type +65 8888 8888 as 6588888888 below',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(20))),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 29),
              controller: _textController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 46,
            ),
            TextButton(
                child: Text(
                  'open in WhatsApp',
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
