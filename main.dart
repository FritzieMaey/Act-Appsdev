import 'dart:io';

class Store {
  String product;
  double price;
  int quantity;

  Store(this.product, this.price, this.quantity);
}

void main() {
  List<Store> inventory = [];

  while (true) {
    print('-----------------------------');
    print('Inventory System');
    print('-----------------------------');

    print('1. Add Product');
    print('2. View Products');
    print('3. Sell Products');
    print('4. Exit');

    stdout.write('Enter Choice: ');
    String? i = stdin.readLineSync();

    if (i == null || i.isEmpty) {
      print('Please Input choice 1-4');
      continue;
    }

    int choice = int.tryParse(i) ?? 0;

    if (choice == 1) {
      stdout.write('Enter Product Name: ');
      String? p = stdin.readLineSync();
      if (p == null || p.trim().isEmpty) {
        print('Invalid Product Name');
        continue;
      }

      stdout.write('Enter Price: ');
      String? priceI = stdin.readLineSync();
      double price = double.tryParse(priceI ?? '') ?? 0;
      if (price <= 0) {
        print('Invalid Price. Must be greater than 0.');
        continue;
      }

      stdout.write('Enter Quantity: ');
      String? quantityInput = stdin.readLineSync();
      int quantity = int.tryParse(quantityInput ?? '') ?? 0;
      if (quantity <= 0) {
        print('Invalid Quantity. Must be greater than 0.');
        continue;
      }

      bool productExists = false;
      for (var product in inventory) {
        if (product.product.toLowerCase() == p.toLowerCase()) {
          product.quantity += quantity;
          print(
              'Product "$p" exists. Quantity updated to ${product.quantity}.');
          productExists = true;
          break;
        }
      }
      if (!productExists) {
        inventory.add(Store(p, price, quantity));
        print('Product added successfully.');
      }
    } else if (choice == 2) {
       if (inventory.isEmpty) {
        print('Inventory is empty.');
        continue;
      }
    } else if (choice == 3) {
      stdout.write('Enter Product Name to Sell: ');
      String? p = stdin.readLineSync();
      if (p == null || p.trim().isEmpty) {
        print('Invalid Product Name');
        continue;
      }
      String productName = p.trim();

      stdout.write('Enter Quantity: ');
      String? quantityInput = stdin.readLineSync();
      int sellQty = int.tryParse(quantityInput ?? '') ?? 0;
      if (sellQty <= 0) {
        print('Invalid Quantity. Must be greater than 0.');
        continue;
      }

      bool found = false;
      for (var product in inventory) {
        if (product.product.toLowerCase() == productName.toLowerCase()) {
          found = true;
          if (product.quantity >= sellQty) {
            product.quantity -= sellQty;
            print(
                'Sold $sellQty units of "$productName". Remaining: ${product.quantity}');
          } else {
            print(
                'Insufficient stock. Only ${product.quantity} units available.');
          }
          break;
        }
      }
      if (!found) {
        print('Product "$productName" not found in inventory.');
      }
    } else if (choice == 4) {
      print('Exiting system.');
      break; 
    } else {
      print('Invalid choice. Please enter a number between 1-4.');
    }
  }
}
