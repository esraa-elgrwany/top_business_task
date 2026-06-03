import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/config/routes/routes.dart';
import 'package:test_task/core/utils/debouncer.dart';
import 'package:test_task/features/products/presentation/manager/get_product_cubit/product_list_cubit.dart';
import 'package:test_task/features/products/presentation/manager/get_product_cubit/product_list_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/search_text_field.dart';
import '../widgets/product_card_item.dart';
import '../widgets/custom_error_widget.dart';
import '../../data/models/product_list_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    context.read<ProductsListCubit>().fetchProducts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.85) {
      context.read<ProductsListCubit>().fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Top Selling Products',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SearchTextField(
            controller: _searchController,
            onChanged: (value) {
              _debouncer.run(() {
                context.read<ProductsListCubit>().searchProducts(value);
              });
            },
          ),
          Expanded(
            child: BlocBuilder<ProductsListCubit, ProductsListState>(
              builder: (context, state) {
                if (state.status == ProductsListStatus.loading && state.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                }

                if (state.status == ProductsListStatus.failure && state.products.isEmpty) {
                  return CustomErrorWidget(
                    message: state.errorMessage,
                    onRetry: () => context.read<ProductsListCubit>().fetchProducts(isRefresh: true),
                  );
                }

                if (state.products.isEmpty) {
                  return Center(
                    child: Text(
                      'No matching items cataloged here.',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => context.read<ProductsListCubit>().fetchProducts(isRefresh: true),
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.61,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemCount: state.hasReachedMax ? state.products.length : state.products.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= state.products.length) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: const CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }

                      // Casting safety check ensuring model parameters populate properly
                      final ProductsModel item = state.products[index] as ProductsModel;

                      return ProductCardItem(
                        product: item,
                        onTap: () => Navigator.pushNamed(
                          context,
                          RoutesName.productDetailsScreen,
                          arguments: item.slug ?? '',
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }
}