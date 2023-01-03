import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_apps_deall/data/repositories/remote/config/api_constant.dart';
import 'package:github_apps_deall/inject_container.dart';
import 'package:github_apps_deall/presentation/view/home/home_page.dart';
import 'package:github_apps_deall/utils/observer.dart';
import 'package:get/get.dart';
import 'package:github_apps_deall/utils/ui_lib.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await init(ApiConstant.baseUrl);
    runApp(const MyApp());
  },
    blocObserver: GithubBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('en_En', null);
    return GetMaterialApp(
      title: 'Github Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: UiLib.colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
      ),
      initialRoute: '/home',
      // initialRoute: '/home-new',
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }
}