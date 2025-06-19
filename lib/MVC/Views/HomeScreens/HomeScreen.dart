import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/HomeComponents/DailyProgressCompo.dart';
import 'package:reclaim/Components/HomeComponents/weekLessonCompo.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/HomeControllers/HomeController.dart';
import 'package:reclaim/MVC/Views/HomeScreens/CustomDrawerScreen.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(HomeController());

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 400));
      controller.showTutorial(context);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Reclaimcolors.BlueSecondary),
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _topBar(context),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return const DailyProgressComponent(
                                  title: "Yesterday",
                                  subtitle: "Daily Affirmative",
                                  description:
                                      "here to place the text for the daily progress of the Task/Goal",
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 15),

                          _sectionTitle("Weekly Lesson"),
                          const SizedBox(height: 15),
                          _weeklyLessonSection(),
                          const SizedBox(height: 20),
                          // _sectionTitle("Evening Recollect"),
                          // _eveningRecollectImage(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _bouncingButton(),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }


  Widget _topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            key: controller.keyFeature1,
            onTap: () => Scaffold.of(context).openDrawer(),
            child: SvgPicture.asset(ReclaimIcon.myAccount),
          ),
          SvgPicture.asset(ReclaimIcon.ReclaimIcons),
          SpringWidget(
            key: controller.keyFeature2,
            onTap: () => Get.toNamed(GetRouteNames.Notificationscreen),
            child: SvgPicture.asset(ReclaimIcon.Notification),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Reclaimcolors.BasicBlack),
        ),
      );

  Widget _weeklyLessonSection() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, index) => SizedBox(
          width: 250,
          child: SpringWidget(
            key: controller.keyFeature3,
            onTap: () => Get.toNamed(GetRouteNames.Detaillessonscreen),
            child: WeekLessonComponent(
              imageUrl:
                  "https://images.unsplash.com/photo-1621873493031-d871c4e49d61?...",
              description: "Cause It's Bad For Mental Health too",
              title: "Say No to Porn",
            ),
          ),
        ),
      ),
    );
  }

  Widget _eveningRecollectImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: Image.asset(Reclaimimages.alertImage,
            width: double.infinity, fit: BoxFit.cover),
      ),
    );
  }

  Widget _bouncingButton() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Add your action here
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Reclaimcolors.BasicBlue, // Text color
              backgroundColor: Reclaimcolors.BasicBlue, // Background
              side: const BorderSide(
                color: Reclaimcolors.BasicBlue,
              ), // Border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 4,
            ),
            child: const Text(
              ' Evening Recollect',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Reclaimcolors.BasicWhite),
            ),
          ),
        ),
      ),
    );
  }
}
