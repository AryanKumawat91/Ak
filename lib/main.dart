import 'package:flutter/material.dart';

void main() => runApp(BusManagementApp());

class BusManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Management',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Montserrat',
      ),
      home: BusManagementPage(),
    );
  }
}

// Bus Management Home Page
class BusManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(0),
          child: Image.asset('lib/assets/logo.png'), // School logo
        ),
        title: Text(
          'Prestige Public School',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TabButton(label: 'Bus Management', isActive: true),
                  TabButton(label: 'School Management (Coming soon)'),
                  TabButton(label: 'Issue notice'),
                  TabButton(label: 'Tickets'),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Find bus by bus no. allotted by school/government',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: Text('Add Driver'),
                  icon: Icon(Icons.add),
                  backgroundColor: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 2.2,
                ),
                itemCount: 6, // Number of bus cards
                itemBuilder: (context, index) {
                  // Passing bus details to the BusCard widget
                  Bus bus = Bus(
                    busNumber: '81', // Example bus number
                    officialNumber: 'MP.09.CZ.8822',
                    driverName: 'Rajesh Kumar',
                    route: 'Khandwa road - Rajwada',
                  );
                  
                  return GestureDetector(
                    // Adding onTap to navigate to BusDetailsPage
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusDetailsPage(bus: bus),
                        ),
                      );
                    },
                    child: BusCard(index: index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String label;
  final bool isActive;

  TabButton({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: isActive ? Colors.purple : Colors.grey[300],
          onPrimary: isActive ? Colors.white : Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class BusCard extends StatelessWidget {
  final int index;

  BusCard({required this.index});

  @override
  Widget build(BuildContext context) {
    bool isBusActive = index % 2 == 0; // Example condition for bus status

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text('81'), // Example bus number
                ),
                Icon(
                  Icons.circle,
                  color: isBusActive ? Colors.green : Colors.red,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('Bus no. - 81',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Official bus no. - MP.09.CZ.8822'),
            Text('Driver name: Rajesh Kumar'),
            Text('Driver contact: +91 76767 67676'),
            Text('Bus route: Khandwa road - Rajwada'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatusIcon(label: 'Gate', status: 'Closed', icon: Icons.lock),
                StatusIcon(label: 'Seatbelt', status: 'Unlocked', icon: Icons.lock_open),
                StatusIcon(label: 'Alcohol', status: '02/100', icon: Icons.local_drink),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusIcon extends StatelessWidget {
  final String label;
  final String status;
  final IconData icon;

  StatusIcon({required this.label, required this.status, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.purple, size: 20),
        Text(
          status,
          style: TextStyle(fontSize: 12),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

// Bus Data Model
class Bus {
  final String busNumber;
  final String officialNumber;
  final String driverName;
  final String route;

  Bus({
    required this.busNumber,
    required this.officialNumber,
    required this.driverName,
    required this.route,
  });
}

// Individual Bus Details Page
class BusDetailsPage extends StatelessWidget {
  final Bus bus;

  const BusDetailsPage({required this.bus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bus no. - ${bus.busNumber}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Official no. - ${bus.officialNumber}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Driver name - ${bus.driverName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Bus route - ${bus.route}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusManagementDetailPage(bus: bus)),
                );
              },
              child: Text('Manage Bus'),
            ),
          ],
        ),
      ),
    );
  }
}

// Bus Management Page with Cameras and Tracking
class BusManagementDetailPage extends StatelessWidget {
  final Bus bus;

  const BusManagementDetailPage({required this.bus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bus no. - ${bus.busNumber}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Bus No- 81', style: TextStyle(fontSize: 16)),
            Text('official Bus No. -MP.09.CZ.8822', style: TextStyle(fontSize: 16)),
            Text('Driver Name- Rakesh Pandey', style: TextStyle(fontSize: 16)),
            Text('Bus Route- Rakesh Pandey', style: TextStyle(fontSize: 16)),
            Text('Contact driver - +91 55555-55555', style: TextStyle(fontSize: 16)),
            Text('Contact conductor - +91 66666-66666', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.announcement),
                  label: Text('Announcement'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                  label: Text('Manage Bus'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  // Cameras Grid
                  Expanded(
                    flex: 2,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 6, // Assuming 6 cameras
                      itemBuilder: (context, index) {
                        String imagePath = 'lib/assets/cam${index + 1}.png';
                        return Container(
                          color: Colors.grey[300],
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Handle case where image is missing or incorrect
                              return Center(
                                child: Text(
                                  'Cam ${index + 1}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  // Bus Tracking Map
                  Expanded(
  flex: 1,
  child: Container(
    color: Colors.grey[300],
    child: Center(
      child: Image.asset(
        'lib/assets/map.png', // Correct path to the image
        fit: BoxFit.cover, // Adjusts the image to cover the entire container
        errorBuilder: (context, error, stackTrace) {
          return Text('Map ', style: TextStyle(fontSize: 16));
        },
      ),
    ),
  ),
),

          ],
        ),
      ),
          ]
    )
      ),
    );
  }
}
