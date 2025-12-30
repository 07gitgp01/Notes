import 'package:flutter/material.dart';
import 'package:notes/consts/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Projects(12)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.card,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(width: 400, height: 100, color: Colors.green),
              Container(width: 400, height: 100, color: Colors.red),
              Container(width: 400, height: 100, color: Colors.amber),
              Container(width: 400, height: 100, color: Colors.green),
              Container(width: 400, height: 100, color: Colors.red),
              Container(width: 400, height: 100, color: Colors.green),
              Container(width: 400, height: 100, color: Colors.red),
              Container(width: 400, height: 100, color: Colors.amber),
              Container(width: 400, height: 100, color: Colors.green),
              Container(width: 400, height: 100, color: Colors.red),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
