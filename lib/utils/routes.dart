import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sebarin/pages/attendpage/ui/attend_screen.dart';
import 'package:sebarin/pages/createpage/binding/create_binding.dart';
import 'package:sebarin/pages/createpage/binding/create_success_binding.dart';
import 'package:sebarin/pages/createpage/ui/create_screen.dart';
import 'package:sebarin/pages/createpage/ui/create_success_screen.dart';
import 'package:sebarin/pages/homepage/binding/home_binding.dart';
import 'package:sebarin/pages/homepage/ui/home_screen.dart';
import 'package:sebarin/pages/myeventpage/ui/myevent_screen.dart';
import 'package:sebarin/pages/profilepage/ui/profile_screen.dart';
import 'package:sebarin/pages/resultpage/ui/result_screen.dart';
import 'package:sebarin/pages/savedpage/ui/saved_screen.dart';
import 'package:sebarin/pages/searchpage/binding/search_binding.dart';
import 'package:sebarin/pages/searchpage/ui/search_screen.dart';
import 'package:sebarin/pages/settingpage/binding/setting_binding.dart';
import 'package:sebarin/pages/settingpage/ui/setting_screen.dart';
import 'package:sebarin/pages/testpage/binding/test_binding.dart';
import 'package:sebarin/pages/testpage/ui/test_screen.dart';
import 'package:sebarin/pages/viewcontentpage/binding/viewcontent_binding.dart';
import 'package:sebarin/pages/viewcontentpage/ui/viewcontent_screen.dart';

import '../pages/loginpage/binding/login_binding.dart';
import '../pages/loginpage/ui/login_screen.dart';
import '../pages/profilepage/binding/profile_binding.dart';

List<GetPage> routes = [
  GetPage(
    name: "/",
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: "/login",
    page: () => LoginScreen(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: "/search",
    page: () => SearchScreen(),
    binding: SearchBinding(),
  ),
  GetPage(
    name: '/results',
    page: () => ResultScreen(),
  ),
  GetPage(
    name: '/view-event',
    page: () => ViewContentScreen(),
    binding: ViewContentBinding(),
  ),
  GetPage(
    name: '/attend',
    page: () => AttendScreen(),
  ),
  GetPage(
    name: '/saved',
    page: () => SavedScreen(),
  ),
  GetPage(
    name: '/my-event',
    page: () => MyEventScreen(),
  ),
  GetPage(
    name: '/my-profile',
    page: () => ProfileScreen(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: '/settings',
    page: () => SettingScreen(),
    binding: SettingBinding(),
  ),
  GetPage(
    name: '/create',
    page: () => CreateScreen(),
    binding: CreateBinding(),
  ),
  GetPage(
    name: '/create/success',
    page: () => CreateSuccessScreen(),
    binding: CreateSuccessBinding(),
  ),
  GetPage(
      name: '/create/test', page: () => TestScreen(), binding: TestBinding()),
];
