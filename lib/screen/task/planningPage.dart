import 'package:flutter/material.dart';

class PanningPage extends StatefulWidget {
  const PanningPage({Key? key}) : super(key: key);

  @override
  State<PanningPage> createState() => _PanningPageState();
}

class _PanningPageState extends State<PanningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Today',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Example number of items
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    width: 150, // Adjust the width as needed
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Description of the task',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Upcoming',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Example number of items
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Task ${index + 6}'),
                  subtitle: Text('Description of the task'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Add your navigation logic here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
