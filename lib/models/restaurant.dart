import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart_item.dart';
import 'package:flutter_application_1/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier{

  final List<Food> _menu = [
    // burguers
      Food(
        name: "Hamburguer Tradicional",
        description: "Um clássico com um bife suculento, acompanhado de alface, tomate e cheddar derretido.",
        imagePath: "assets/images/burgers/tradicional_burguer.jpeg",
        price: 15.00,
        category: FoodCategory.hamburgers,
        availableAddons: [
          Addon(name: "Queijo Extra", price: 2.00),
          Addon(name: "Picles", price: 1.50),
          Addon(name: "Bacon", price: 5.00)
        ]
      ),

      Food(
        name: "Hamburguer de Frango",
        description: "Um delicioso hamburguer de frango empanado com tomate, cheddar, alface e maionese da casa.",
        imagePath: "assets/images/burgers/frango_burguer.jpeg",
        price: 18.00,
        category: FoodCategory.hamburgers,
        availableAddons: [
          Addon(name: "Queijo Extra", price: 2.00),
          Addon(name: "Picles", price: 1.50),
          Addon(name: "Bacon", price: 5.00)
        ]
      ),

      Food(
        name: "Hamburguer com Bacon",
        description: "Um hamburguer de bife suculento, com fitas de bacon, alface, cebola, tomate, cheddar e um molho de picles especial.",
        imagePath: "assets/images/burgers/bacon_burguer.jpeg",
        price: 20.00,
        category: FoodCategory.hamburgers,
        availableAddons: [
          Addon(name: "Queijo Extra", price: 2.00),
          Addon(name: "Picles", price: 1.50),
          Addon(name: "Bacon", price: 5.00)
        ]
      ),

      Food(
        name: "Hamburguer Vegetariano",
        description: "Um hamburguer com uma carne de soja deliciosa, alface, cebola, tomate e queijo vegano.",
        imagePath: "assets/images/burgers/vegetariano_burguer.jpeg",
        price: 20.00,
        category: FoodCategory.hamburgers,
        availableAddons: [
          Addon(name: "Queijo Extra", price: 2.00),
          Addon(name: "Picles", price: 1.50),
          Addon(name: "Batatas pequenas", price: 5.00)
        ]
      ),

    // saladas
    /*
      Food(
        name: "Salada Caesar",
        description: "Uma salada deliciosa com pedaços de frango.",
        imagePath: "assets/images/saladas/caesar_salad.jpeg",
        price: 20.00,
        category: FoodCategory.saladas,
        availableAddons: [
          Addon(name: "Frango Extra", price: 6.00),
          Addon(name: "Queijo", price: 4.00),
          Addon(name: "Tomate", price: 2.00),
        ]
      ),

      Food(
        name: "Salada de Frutas",
        description: "Uma salada deliciosa com morango, abacaxi, pepinos e uva passa.",
        imagePath: "assets/images/saladas/fruits_salad.jpeg",
        price: 21.00,
        category: FoodCategory.saladas,
        availableAddons: [
          Addon(name: "Tomate", price: 2.00),
          Addon(name: "Abacaxi", price: 3.00),
          Addon(name: "Morango", price: 3.00),
           Addon(name: "Outras Frutas", price: 5.00),
        ]
      ),

      Food(
        name: "Salada de Frutas",
        description: "Uma salada deliciosa com pepino, cebola, azeitona e queijo cottage.",
        imagePath: "assets/images/saladas/greek_salad.jpeg",
        price: 21.00,
        category: FoodCategory.saladas,
        availableAddons: [
          Addon(name: "Azeitona", price: 2.00),
          Addon(name: "Pepino", price: 3.00),
          Addon(name: "Quejo Extra", price: 3.00)
        ]
      ),
    */
    // acompanhamentos
      Food(
        name: "Cebola Frita",
        description: "Uma porção fenomenal de cebolas fritas sequinhas.",
        imagePath: "assets/images/sides/cebola_side.jpeg",
        price: 13.00,
        category: FoodCategory.acompanhamentos,
        availableAddons: [
          Addon(name: "Cebola Extra", price: 2.00),
        ]
      ),

      Food(
        name: "Pão de Alho",
        description: "Uma porção saborosa de pão de alho.",
        imagePath: "assets/images/sides/garlic_side.jpeg",
        price: 15.00,
        category: FoodCategory.acompanhamentos,
        availableAddons: [
          Addon(name: "Pão de Alho Extra", price: 5.00),
        ]
      ),

      Food(
        name: "Batata Frita",
        description: "Uma porção da clássica e deliciosa batata frita.",
        imagePath: "assets/images/sides/fries_side.jpeg",
        price: 12.00,
        category: FoodCategory.acompanhamentos,
        availableAddons: [
          Addon(name: "Batata Extra", price: 3.00),
        ]
      ),
    // deserts
      Food(
        name: "Açai",
        description: "Uma porção de açaí com frutas.",
        imagePath: "assets/images/desserts/acai_dessert.jpeg",
        price: 18.00,
        category: FoodCategory.sobremesas,
        availableAddons: [
          Addon(name: "Banana", price: 2.00),
          Addon(name: "Morango", price: 3.00),
          Addon(name: "Blueberry", price: 23.00),
        ]
      ),
    
      Food(
        name: "Sorvete",
        description: "Uma casquinha de sorvete de morango docinho.",
        imagePath: "assets/images/desserts/ice_cream_dessert.jpeg",
        price: 12.00,
        category: FoodCategory.sobremesas,
        availableAddons: [
          Addon(name: "Cobertura", price: 2.00),
          Addon(name: "Confetes", price: 2.00),
          Addon(name: "Cereja", price: 3.00),
  
        ]
      ),
    
      Food(
        name: "Cookies",
        description: "Cookies bem recheados e com bastante chocolate.",
        imagePath: "assets/images/desserts/cookie_dessert.jpeg",
        price: 10.00,
        category: FoodCategory.sobremesas,
        availableAddons: [
  
        ]
      ),
    
      Food(
        name: "Fatia de bolo",
        description: "Uma fatia molhadinha de bolo de chocolate com cobertura de baunilha.",
        imagePath: "assets/images/desserts/cake_dessert.jpeg",
        price: 12.00,
        category: FoodCategory.sobremesas,
        availableAddons: [
  
        ]
      ),
    
    // bebidas
      Food(
        name: "Mohito",
        description: "Um clássico Mohito com tiras de limão.",
        imagePath: "assets/images/drinks/mohito_drink.jpeg",
        price: 15.00,
        category: FoodCategory.bebidas,
        availableAddons: [
          Addon(name: "Aumentar Tamanho", price: 5.00),

        ]
      ),

      Food(
        name: "Cuba Libre",
        description: "Um clássico Cuba Libre com guaraná e rum..",
        imagePath: "assets/images/drinks/cuba_libre_drink.jpeg",
        price: 15.00,
        category: FoodCategory.bebidas,
        availableAddons: [
          Addon(name: "Aumentar Tamanho", price: 5.00),

        ]
      ),
    
      Food(
        name: "Pink Lemonade",
        description: "Uma clássica e deliciosa pink lemonade.",
        imagePath: "assets/images/drinks/pink_lemonade_drink.jpeg",
        price: 15.00,
        category: FoodCategory.bebidas,
        availableAddons: [
          Addon(name: "Aumentar Tamanho", price: 5.00),

        ]
      ),
    // pizzas
      Food(
        name: "Pizza de Calabresa",
        description: "Uma tradicional pizza de calabresa deliciosa.",
        imagePath: "assets/images/pizzas/calabresa_pizza.jpeg",
        price: 35.00,
        category: FoodCategory.pizzas,
        availableAddons: [
          Addon(name: "Aumentar Tamanho", price: 10.00),
          Addon(name: "Borda de Cheddar", price: 10.00),
          Addon(name: "Borda de Catupiry", price: 10.00),

        ]
      ),

      Food(
        name: "Pizza de Atum",
        description: "Uma pizza de atum fenomenal e inesquecível.",
        imagePath: "assets/images/pizzas/atum_pizza.jpeg",
        price: 39.00,
        category: FoodCategory.pizzas,
        availableAddons: [
          Addon(name: "Aumentar Tamanho", price: 10.00),
          Addon(name: "Borda de Cheddar", price: 10.00),
          Addon(name: "Borda de Catupiry", price: 10.00),

        ]
      ),

        Food(
        name: "Pizza Marguerita",
        description: "Uma tradicional pizza marguerita deliciosa.",
        imagePath: "assets/images/pizzas/calabresa_pizza.jpeg",
        price: 30.00,
        category: FoodCategory.pizzas,
        availableAddons: [
          Addon(name: "Aumentar Tamanho", price: 10.00),
          Addon(name: "Borda de Cheddar", price: 10.00),
          Addon(name: "Borda de Catupiry", price: 10.00),

        ]
      ),
  ];

  // user cart

  final List<CartItem> _cart = [];

  // delivery address
  String _deliveryAddress = ' ';
  String _paymentMethod = ' ';
  late Future<String> _currentOrder;
  double _deliveryfee = 8.00;

  // GETTERS

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;
  String get paymentMethod => _paymentMethod;
  Future<String> get currentOrder => _currentOrder;
  double get deliveryfee => _deliveryfee;

  // OPERATIONS

  // add to cart
  void addToCart(Food food, List <Addon> selectedAddons){
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if food items are the same
      bool isSameFood = item.food == food;

      // check if the list of selected addons are the same
      bool isSameAddons = const ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameAddons && isSameFood;
    });

    // if item already exists, increase its quantity
    if (cartItem != null){
      cartItem.quantity++;
    } else {
      // otherwise add a new cart item to the cart
    _cart.add(
      CartItem(food: food, selectedAddons: selectedAddons)
    );
    }

    // to update the UI
    notifyListeners();

  }

  // remove from cart

  void removeFromCart(CartItem cartItem){
    int cartIndex = _cart.indexOf(cartItem);

    if(cartIndex != -1){
      if (_cart[cartIndex].quantity > 1){
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

     notifyListeners();
  }

  // get total price
  double getTotalPrice(){
    double total = 0.0;

    for (CartItem cartItem in _cart){
      double itemTotal = cartItem.food.price;

      for(Addon addon in cartItem.selectedAddons){
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;

    }

    total += deliveryfee;

    return total;
  }

  // get total number of items

  int getTotalItemCount(){
    int totalItemCount = 0;

    for (CartItem cartItem in _cart){
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // calculate estimated delivery time
  DateTime calculateEstimatedDeliveryTime(DateTime orderTime, {int prepTime = 50, int deliveryTime = 20}) {
    return orderTime.add(Duration(minutes: prepTime + deliveryTime));
  }

  // calculate the time left to delivery
  int getRemainingTime(DateTime estimatedTime) {
    return estimatedTime.difference(DateTime.now()).inMinutes;
  }

  // clear cart

  void clearCart(){
    _cart.clear();
    notifyListeners();
  }

  // update delivery address

  void updateDeliveryAddress(String newAddress){
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  // update payment method

  void updatePaymentMethod(String newMethod){
    _paymentMethod = newMethod;
    notifyListeners();
  }

  void updateCurrentOrder(Future<String> newOrder){
    _currentOrder = newOrder;
    notifyListeners();
  }

  // UTILS

  // generate receipt
  String displayCartReceipt(){
    final receipt = StringBuffer();

    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("---------------");

    for(final cartItem in _cart){
      receipt.writeln("R${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if(cartItem.selectedAddons.isNotEmpty){
        receipt.writeln("Adicionais: R${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("---------------");
    receipt.writeln();
    receipt.writeln("Total de itens: ${getTotalItemCount()}");
    receipt.writeln("Taxa de entrega: $deliveryfee");
    receipt.writeln("Preço total: R${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Entregar para: $deliveryAddress");
    receipt.writeln("Forma de Pagamento: $paymentMethod");

    return receipt.toString();

  }

  String receiptToDatabase(){
    final receipt = StringBuffer();

    for(final cartItem in _cart){
      receipt.writeln("${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if(cartItem.selectedAddons.isNotEmpty){
        receipt.writeln("Adicionais: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }
    receipt.writeln();
    receipt.writeln("Total de itens: ${getTotalItemCount()}");
    receipt.writeln("Taxa de entrega: $deliveryfee");
    receipt.writeln("Preço total: R${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Endereço de Entrega: $deliveryAddress");
    receipt.writeln("Forma de Pagamento: $paymentMethod");

    return receipt.toString();

  }

  // format double value
  String _formatPrice(double price){
    return "\$R${price.toStringAsFixed(2)}";
  }

  // format list of addons into a string summay
  String _formatAddons(List<Addon> addons){
    return addons.map((addon) => "${addon.name} (${_formatPrice(addon.price)})").join(", ");
  }

}