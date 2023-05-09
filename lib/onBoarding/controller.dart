import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/readcsv.dart';
import 'model.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      Get.to(()=> ReadCSV());
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('images/welcome.gif', 'Welcome to GRE Vocabulary Application',
        'We are here to help you prepare'),
    OnboardingInfo('images/vocab.jpg', 'Study in peace',
        'This is the best choice for you to sit and learn'),
    OnboardingInfo('images/exam.jpg', 'The best platform to enhance your vocabulary',
        'We are here to help you reach your goal')
  ];
}