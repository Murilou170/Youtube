import 'package:flutter/material.dart';

class Inscricao extends StatefulWidget {
  const Inscricao({Key? key}) : super(key: key);

  @override
  _InscricaoState createState() => _InscricaoState();
}

class _InscricaoState extends State<Inscricao> {
  @override
  Widget build(BuildContext context) {
    return
        Center(
          child: Text("Inscrição",
            style: TextStyle(
                fontSize: 25
            ),
          ),
        );

  }
}
