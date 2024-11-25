import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: 200,
        width: 400,
        child: Card(         
          semanticContainer: true,
          color: Theme.of(context).colorScheme.primary,
          child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                Text(
                  getCurrentDate(),
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 6
                      ..color = Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Text(
                  "Tienes 11 paquetes hoy",
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..strokeWidth = 4
                      ..color = Theme.of(context).colorScheme.onPrimary,
                  ),
                ), 
              ],
            ),
          ),
      ),
      ],
    );
  }
}

getCurrentDate() {
  var date = DateTime.now().toString();

  var dateParse = DateTime.parse(date);

  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

  return formattedDate;
}
