import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/api/api-manager.dart';
import 'package:test_task/features/products/data/data_source/remote/product_remote_ds_impl.dart';
import 'package:test_task/features/products/data/repo/product_repo_impl.dart';
import 'package:test_task/features/products/domain/use_case/get_product_details_use_case.dart';
import 'package:test_task/features/products/domain/use_case/get_product_use_case.dart';
import 'package:test_task/features/products/presentation/manager/get_product_cubit/product_list_cubit.dart';
import 'package:test_task/features/products/presentation/manager/get_product_details_cubit/get_product_details_cubit.dart';
import 'package:test_task/features/products/presentation/pages/product_details_screen.dart';
import 'package:test_task/features/products/presentation/pages/products_screen.dart';

class RoutesName {
  static const String productsScreen = "/";
  static const String productDetailsScreen = "/productDetails";
}

class AppRouter {
  static final ApiManager _apiManager = ApiManager();

  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.productsScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => ProductsListCubit(
              GetProductsUseCase(
                ProductRepositoryImpl(
                  ProductRemoteDsImpl(_apiManager),
                ),
              ),
            ),
            child: const ProductsScreen(),
          ),
        );

      case RoutesName.productDetailsScreen:
        final String slug = settings.arguments as String? ?? '';

        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => ProductDetailsCubit(
              GetProductDetailsUseCase(
                ProductRepositoryImpl(
                  ProductRemoteDsImpl(_apiManager),
                ),
              ),
            ),
            child: ProductDetailsScreen(slug: slug),
          ),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => unDefineScreen(),
        );
    }
  }

  static Widget unDefineScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text("Undefined page")),
      body: const Center(child: Text("Page not found")),
    );
  }
}
