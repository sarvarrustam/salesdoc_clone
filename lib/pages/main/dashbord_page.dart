import 'package:flutter/material.dart';

class DashbordPage extends StatefulWidget {
  const DashbordPage({super.key});

  @override
  State<DashbordPage> createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 50,
          color: Color.fromARGB(255, 38, 50, 56),
          child: Row(
            children: [
              FlutterLogo(size: 50),
              const SizedBox(width: 20),
              ButtonWidget(text: ('Supervayzer')),
              ButtonWidget(text: ('Savdo')),
              ButtonWidget(text: ('Foinansiy')),
              ButtonWidget(text: ('Foinansiy')),
            ],
          ),
        ),
      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  const ButtonWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
