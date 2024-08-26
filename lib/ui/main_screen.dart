import 'package:flutter/material.dart';

import '../service/create_data.dart';  // Import the create data functions
import '../service/get_data.dart';  // Import the fetchData function
import '../widgets/add_student_screen.dart';  // Import the AddStudentScreen
import '../widgets/detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<dynamic>> _items;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _items = fetchData();
    });
  }

  void _addStudent(String firstName, String lastName, String course, String year, bool enrolled) async {
    await addItem(firstName, lastName, course, year, enrolled);
    _refreshData();
  }

  void _showAddStudentScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddStudentScreen(
          onAddStudent: (firstName, lastName, course, year, enrolled) {
            _addStudent(firstName, lastName, course, year, enrolled);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _items,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text('${item['firstName']} ${item['lastName']}'),
                  subtitle: Text('${item['course']} - ${item['year']}'),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(item: item),
                      ),
                    );

                    if (result == true || result is Map<String, dynamic>) {
                      _refreshData();
                    }
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStudentScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
