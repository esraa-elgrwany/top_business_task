// product_list_entity.dart

class ProductListEntity {
  final ProductListEntityData? data;
  final String? msg;
  final int? status;

  ProductListEntity({
    this.data,
    this.msg,
    this.status,
  });
}

class ProductListEntityData {
  final PaginationEntity? pagination;
  final String? productsPerPage;
  final List<ProductsEntity>? products;

  ProductListEntityData({
    this.pagination,
    this.productsPerPage,
    this.products,
  });
}

class ProductsEntity {
  final int? id;
  final String? name;
  final List<int>? categoryIds;
  final int? priceBeforeDiscount;
  final int? priceAfterDiscount;
  final String? thumbnail;
  final List<String>? images;
  final bool? inWishlist;
  final String? slug;
  final int? productStockCount;
  final double? discount;
  final bool? isTaxable;
  final dynamic buyTogetherId;
  final dynamic buyItTogether;
  final int? mainProductDiscount;
  final int? buyTogetherDiscount;
  final int? orderDetailsCount;
  final int? cartCount;
  final dynamic variant;
  final List<dynamic>? variants;

  ProductsEntity({
    this.id,
    this.name,
    this.categoryIds,
    this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.thumbnail,
    this.images,
    this.inWishlist,
    this.slug,
    this.productStockCount,
    this.discount,
    this.isTaxable,
    this.buyTogetherId,
    this.buyItTogether,
    this.mainProductDiscount,
    this.buyTogetherDiscount,
    this.orderDetailsCount,
    this.cartCount,
    this.variant,
    this.variants,
  });

  bool get isOutOfStock => (productStockCount ?? 0) <= 0;
  bool get hasDiscount => (priceBeforeDiscount ?? 0) > (priceAfterDiscount ?? 0);
}

class PaginationEntity {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int? from;
  final int? to;

  PaginationEntity({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
    this.from,
    this.to,
  });
}