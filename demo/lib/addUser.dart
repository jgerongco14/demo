import 'package:demo/connection.dart';
import 'package:demo/viewUser.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> create(name, course) async {
    final body = <String, dynamic>{
      "name": name,
      "course": course,
    };

    final result = await Conn.pb.collection('nameList').create(body: body);
    print("Successful: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ADD USER',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    create(nameController.text, emailController.text);
                  },
                  child: const Text('Add User'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewUserScreen()));
                  },
                  child: const Text('View User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
