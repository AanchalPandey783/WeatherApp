import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_getx/module/home_controller.dart';
import '../widgets/weather_item.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.find<HomeController>();

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE d MMMM y');
    return formatter.format(date);
  }

   @override
   void initState() {
     super.initState();
     print('in init');
     controller.getCurrentLocation();
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 2,
        title: Column(
          children: [
            Text(
              "Today",
              style: GoogleFonts.ubuntu(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              formatDate(DateTime.now()),
              style: GoogleFonts.ubuntu(
                color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
      body: SizedBox.expand(
        child: Obx(
              () => controller.locationData.value == null
              ? Center(
            child: LoadingAnimationWidget.halfTriangleDot(color: Colors.black, size: 40),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherItem(
                lottie: 'assets/loc.json',
                text: "Your location is: ",
                subtext: controller.address,
              ),
              WeatherItem(
                lottie: 'assets/temp.json',
                text: "Your temperature is: ",
                subtext: controller.temperature,
              ),
              WeatherItem(
                lottie: 'assets/thums_up.json',
                text: "You should: ",
                subtext: controller.infoText.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
