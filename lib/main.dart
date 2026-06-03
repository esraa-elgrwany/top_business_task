import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/config/routes/routes.dart';
import 'package:test_task/core/cache/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Products App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: const Color(0xFF1A237E),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1A237E),
              primary: const Color(0xFF1A237E),
            ),
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          initialRoute: RoutesName.productsScreen,
          onGenerateRoute: AppRouter.onGenerate,
        );
      },
    );
  }
}
