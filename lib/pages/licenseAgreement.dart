import 'package:flutter/material.dart';
import 'package:qr_code/pages/login.dart';

class LicenseAgreement extends StatefulWidget {
  const LicenseAgreement({Key? key}) : super(key: key);

  @override
  State<LicenseAgreement> createState() => _LicenseAgreementState();
}

class _LicenseAgreementState extends State<LicenseAgreement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Правила ТБ на стрельбище",
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget> [
          _licenseText(),
          _licenseNext()
        ],
      )
    );
  }
}

_licenseNext() {
  bool _agree = false;
  return Expanded(
    //flex: 2,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(
              checkColor: Colors.white,
              //fillColor: MaterialStateProperty.resolveWith(Colors.blue),
              value: _agree ,
              onChanged: (bool? value) {
                _agree = value!;
              }),
            const Text("Я ознакомился с правилами и принял их")
          ],
        ),
        ElevatedButton(
          onPressed: () => const LogInPage(),
          child: const Text("Вход",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
            shadowColor: Colors.greenAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            minimumSize: const Size(150, 70),
            maximumSize: const Size(150, 70),//////// HERE
          ),
        )],
    )
  );
}

_licenseText() {
  return Expanded(
    flex: 3,
    child: ListView(
      children: const [
        Text("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ],
    ),
  );
}