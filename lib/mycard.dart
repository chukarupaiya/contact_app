import 'package:flutter/material.dart';
import './details.dart';
import './user_class.dart';

class MyWidget extends StatelessWidget {
  final user user_;
  MyWidget({required this.user_});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (con) {
            return MyWidget2(this.user_.id);
          },
        ));
      },
      splashColor: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        width: double.infinity,
        height: 270,
        decoration: BoxDecoration(
            color: Color(0xff2d2d2d),
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 56, 56, 56),
                blurRadius: 10,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (con) {
                          return MyWidget2(this.user_.id);
                        },
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: Colors.transparent),
                    child: const Text(
                      'i',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 10, 181, 161),
                          backgroundColor: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Image.network(
                  "https://i.pinimg.com/originals/3b/ed/41/3bed41ea8eeaab4fbdc572d2a0ba9cb6.png"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
              child: Text(
                user_.name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 5),
              child: Text(
                user_.company,
                style: const TextStyle(
                  color: Color.fromARGB(255, 10, 181, 161),
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 2),
              child: Text(
                user_.phone,
                style: const TextStyle(
                  color: Color.fromARGB(255, 194, 192, 192),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
