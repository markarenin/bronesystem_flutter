// ignore_for_file: prefer_const_constructors

import 'package:bronesystem/models/service.dart';
import 'package:bronesystem/servicesprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:provider/provider.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          height: 100,
          child: const SafeArea(
            child: Text(
              "Paul Kerese 14",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(230, 230, 230, 1)),
        child: SafeArea(child: ServicesListWidget()),
      ),
    );
  }
}

class ServicesListWidget extends StatefulWidget {
  const ServicesListWidget({Key? key}) : super(key: key);

  @override
  State<ServicesListWidget> createState() => _ServicesListWidgetState();
}

class _ServicesListWidgetState extends State<ServicesListWidget> {
  @override
  Widget build(BuildContext context) {
    List<Service> services = context.watch<ServicesProvider>().services;
    return ListView.separated(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.symmetric(
        vertical: 30,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) => ServiceWidget(
          name: services[index].name,
          price: services[index].price,
          paid: services[index].paid),
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: 20,
      ),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  final String name;
  final int price;
  final bool paid;
  const ServiceWidget(
      {Key? key, required this.name, required this.price, required this.paid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
        enableFeedback: false,
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, .2), blurRadius: 10)
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
