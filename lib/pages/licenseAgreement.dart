import 'package:flutter/material.dart';
import 'package:qr_code/pages/qrCode.dart';

class LicenseAgreement extends StatefulWidget {
  const LicenseAgreement({Key? key}) : super(key: key);

  @override
  State<LicenseAgreement> createState() => _LicenseAgreementState();
}

class _LicenseAgreementState extends State<LicenseAgreement> {

  bool? _agree = false;
  bool _isEnd = false;
  final _scrollController =  ScrollController();
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

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
          _licenseText(context),
          _licenseNext()
        ],
      )
    );
  }

  _licenseNext() {
    // final double end = _scrollController.position.maxScrollExtent;
    return Expanded(
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text("Я ознакомился с правилами и принял их",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5
                ),
              ),
              value: _agree,
              activeColor: Colors.blue,
              checkColor: Colors.black38,
              onChanged: (bool? value) {
                if (_isEnd){
                  setState(() {
                    _agree = value;
                  });
                }
              }
            ),
            ElevatedButton(
              onPressed: _agree! ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QrCode()),
                );
              } : null,
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
            )
          ],
        )
    );
  }

  _licenseText(context ) {
    return Expanded(
      flex: 3,
      child: Scrollbar(
        isAlwaysShown: true,
        child: ListView.builder(
          controller: _controller,
          itemCount: 1,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text(
                "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            );
          }
        )
      )
    );
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _isEnd = true;
      });
    }
  }
}
