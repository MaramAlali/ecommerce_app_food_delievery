import 'package:ecommerce_app_food_delievery/controllers/order_controller.dart';
import 'package:ecommerce_app_food_delievery/pages/order/view_order.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/custom_app_bar.dart';
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      _tabController = TabController(length: 2, vsync: this);
      // get order list//Get.orderList();
      Get.find<OrderController>().getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "طَلَبَاتِي",),
        body: Column(
          children: [
            Container(
              width: Dimensions.screenWidth,
              child: TabBar(
                indicatorColor:  const Color.fromARGB(255, 10, 10, 10),
                indicatorWeight: 5,
                labelColor: const Color.fromARGB(255, 21, 21, 21),
                unselectedLabelColor: const Color.fromARGB(255, 206, 143, 48),
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: "الحَالِيةَ",

                  ),
                  Tab(
                    text: "المُسبَقَة",
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children:const [
                ViewOrder(
                  isCurrent: true,
                ),
                ViewOrder(isCurrent: false)
              ]),
            ),
          ],
        ));
  }
}
