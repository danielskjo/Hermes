import 'package:flutter/material.dart';

class DonorProfile extends StatefulWidget {

  static const routeName = '/donor-profile';

  @override
  _DonorProfileState createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Donor Profile'),
    );
  }
}
