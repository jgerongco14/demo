import 'package:demo/connection.dart';
import 'package:flutter/material.dart';

class ViewUserScreen extends StatefulWidget {
  const ViewUserScreen({super.key});

  @override
  _ViewUserScreenState createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  List<dynamic> _records = []; // This will store the records

  @override
  void initState() {
    super.initState();
    read(); // Fetch the records when the screen is loaded
  }

  // Function to read data from the collection
  Future<void> read() async {
    try {
      final records = await Conn.pb.collection('nameList').getFullList();
      for (var record in records) {
        print(record.toJson()); // Check the structure of each record
      }
      setState(() {
        _records = records;
      });
    } catch (e) {
      print('Error fetching records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: _records.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Course')),
                ],
                rows: _records.map((record) {
                  var data = record.toJson();
                  return DataRow(
                    cells: [
                      DataCell(Text(record.id.toString())),
                      DataCell(Text(data['name'] ??
                          'Unknown')), // Access 'name' from data
                      DataCell(Text(data['course'] ??
                          'Unknown')), // Access 'email' from data
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
