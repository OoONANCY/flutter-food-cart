import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodListScreen(),
    );
  }
}

class FoodListScreen extends StatefulWidget {
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final List<String> foodNames = ["Pizza", "Burger", "Pasta", "Sushi"];
  final List<String> foodImages = [
    "assets/pizza.png",
    "assets/burger.png",
    "assets/pasta.png",
    "assets/sushi.png"
  ];
  final List<int> itemPrices = [100, 50, 120, 200];

  List<int> itemCounts = List.filled(4, 0);

  int getTotalPrice() {
    int total = 0;
    for (int i = 0; i < itemCounts.length; i++) {
      total += itemCounts[i] * itemPrices[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant Menu')),
      body: ListView.builder(
        itemCount: foodNames.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 116, 158),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              visualDensity: VisualDensity.compact,
              leading: Image.asset(
                foodImages[index],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.fastfood, size: 50, color: Colors.white);
                },
              ),
              title: Text(
                foodNames[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                '₹ Rate: ${itemPrices[index]}/ piece',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.white, size: 18),
                    onPressed: () {
                      setState(() {
                        if (itemCounts[index] > 0) {
                          itemCounts[index]--;
                        }
                      });
                    },
                  ),
                  Text('${itemCounts[index]}', style: TextStyle(fontSize: 18, color: Colors.white)),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white, size: 18),
                    onPressed: () {
                      setState(() {
                        itemCounts[index]++;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Amount', style: TextStyle(fontSize: 14, color: Colors.white)),
                      SizedBox(height: 4),
                      Text(
                        '₹ ${itemCounts[index] * itemPrices[index]}',
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink[700],
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ₹${getTotalPrice()}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                        foodNames: foodNames,
                        itemCounts: itemCounts,
                        itemPrices: itemPrices,
                      ),
                    ),
                  );
                },
                child: Text('Checkout →'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Checkout Screen
class CheckoutScreen extends StatelessWidget {
  final List<String> foodNames;
  final List<int> itemCounts;
  final List<int> itemPrices;

  CheckoutScreen({required this.foodNames, required this.itemCounts, required this.itemPrices});

  int getTotalPrice() {
    int total = 0;
    for (int i = 0; i < itemCounts.length; i++) {
      total += itemCounts[i] * itemPrices[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Summary')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your order total is ₹${getTotalPrice()}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[700],
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              onPressed: () {
                // Dummy action (Snackbar notification)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order Placed Successfully!')),
                );
              },
              child: Text('Place Order', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink[700],
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.pop(context); // Takes user back to FoodListScreen
          },
        ),
      ),
    );
  }
}
