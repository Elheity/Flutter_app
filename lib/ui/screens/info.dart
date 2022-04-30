import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Who We are"),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Text(
            'This application includes scientific content as it includes'
            'courses in most electronic fields'
            'Therefore, it includes the most important free and paid courses in most fields,'
            'which are divided into \n'
            '1- bioinformatics \n'
            '2- web developer \n'
            '3- investment \n'
            '4- photoshop \n'
            '5- digital marketing \n'
            '6- games(unity) \n'
            '7- android developer \n'
            '8- python ,c#,...... \n'
            '9- cyber security \n'
            '10- docker \n'
            '11- IT \n'
            '12- machine learning \n'
            '13- artificial intelligence \n'
            '14- networking',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
