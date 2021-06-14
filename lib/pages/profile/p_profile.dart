import 'package:flutter/material.dart';
import 'package:fluttour/utils/widgets/p_material.dart';

class PProfile extends StatefulWidget {
  const PProfile({Key? key}) : super(key: key);

  @override
  _PProfileState createState() => _PProfileState();
}

class _PProfileState extends State<PProfile> {
  @override
  Widget build(BuildContext context) {
    return PMaterial(
        child: Container(
          color: Colors.white,
        )
    );
  }
}
