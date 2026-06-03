import '../../domain/entity/product_list_entity.dart';

class ProductListModel extends ProductListEntity {
  ProductListModel({
    ProductListModelData? super.data,
    super.msg,
    super.status,
  });

  factory ProductListModel.fromJson(dynamic json) {
    return ProductListModel(
      data: json['data'] != null ? ProductListModelData.fromJson(json['data']) : null,
      msg: json['msg']?.toString(),
      status: json['status'] is int ? json['status'] : int.tryParse(json['status']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (data != null) 'data': (data as ProductListModelData).toJson(),
      'msg': msg,
      'status': status,
    };
  }
}

class ProductListModelData extends ProductListEntityData {
  ProductListModelData({
    PaginationModel? super.pagination,
    super.productsPerPage,
    List<ProductsModel>? super.products,
  });

  factory ProductListModelData.fromJson(dynamic json) {
    return ProductListModelData(
      pagination: json['pagination'] != null ? PaginationModel.fromJson(json['pagination']) : null,
      productsPerPage: json['products_per_page']?.toString(),
      products: json['products'] != null
          ? (json['products'] as List).map((v) => ProductsModel.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (pagination != null) 'pagination': (pagination as PaginationModel).toJson(),
      'products_per_page': productsPerPage,
      if (products != null)
        'products': products!.map((v) => (v as ProductsModel).toJson()).toList(),
    };
  }
}

class ProductsModel extends ProductsEntity {
  ProductsModel({
    super.id,
    super.name,
    super.categoryIds,
    super.priceBeforeDiscount,
    super.priceAfterDiscount,
    super.thumbnail,
    super.images,
    super.inWishlist,
    super.slug,
    super.productStockCount,
    super.discount,
    super.isTaxable,
    super.buyTogetherId,
    super.buyItTogether,
    super.mainProductDiscount,
    super.buyTogetherDiscount,
    super.orderDetailsCount,
    super.cartCount,
    super.variant,
    super.variants,
  });

  ProductsModel copyWith({
    bool? inWishlist,
  }) {
    return ProductsModel(
      id: id,
      name: name,
      categoryIds: categoryIds,
      priceBeforeDiscount: priceBeforeDiscount,
      priceAfterDiscount: priceAfterDiscount,
      thumbnail: thumbnail,
      images: images,
      inWishlist: inWishlist ?? this.inWishlist,
      slug: slug,
      productStockCount: productStockCount,
      discount: discount,
      isTaxable: isTaxable,
      buyTogetherId: buyTogetherId,
      buyItTogether: buyItTogether,
      mainProductDiscount: mainProductDiscount,
      buyTogetherDiscount: buyTogetherDiscount,
      orderDetailsCount: orderDetailsCount,
      cartCount: cartCount,
      variant: variant,
      variants: variants,
    );
  }

  factory ProductsModel.fromJson(dynamic json) {
    return ProductsModel(
      id: json['id'],
      name: json['name']?.toString(),
      categoryIds: json['category_ids'] != null ? List<int>.from(json['category_ids']) : [],
      priceBeforeDiscount: json['price_before_discount'],
      priceAfterDiscount: json['price_after_discount'],
      thumbnail: json['thumbnail']?.toString(),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      inWishlist: json['in_wishlist'] is bool ? json['in_wishlist'] : (json['in_wishlist'] == 1),
      slug: json['slug']?.toString(),
      productStockCount: json['product_stock_count'],
      discount: json['discount'] is num ? (json['discount'] as num).toDouble() : double.tryParse(json['discount']?.toString() ?? '0.0'),
      isTaxable: json['is_taxable'] is bool ? json['is_taxable'] : (json['is_taxable'] == 1),
      buyTogetherId: json['buy_together_id'],
      buyItTogether: json['buy_it_together'],
      mainProductDiscount: json['main_product_discount'],
      buyTogetherDiscount: json['buy_together_discount'],
      orderDetailsCount: json['order_details_count'],
      cartCount: json['cart_count'],
      variant: json['variant'],
      variants: json['variants'] != null ? List<dynamic>.from(json['variants']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_ids': categoryIds,
      'price_before_discount': priceBeforeDiscount,
      'price_after_discount': priceAfterDiscount,
      'thumbnail': thumbnail,
      'images': images,
      'in_wishlist': inWishlist,
      'slug': slug,
      'product_stock_count': productStockCount,
      'discount': discount,
      'is_taxable': isTaxable,
      'buy_together_id': buyTogetherId,
      'buy_it_together': buyItTogether,
      'main_product_discount': mainProductDiscount,
      'buy_together_discount': buyTogetherDiscount,
      'order_details_count': orderDetailsCount,
      'cart_count': cartCount,
      'variant': variant,
      'variants': variants,
    };
  }
}

class PaginationModel extends PaginationEntity {
  PaginationModel({
    super.total,
    super.perPage,
    super.currentPage,
    super.lastPage,
    super.nextPageUrl,
    super.prevPageUrl,
    super.from,
    super.to,
  });

  factory PaginationModel.fromJson(dynamic json) {
    return PaginationModel(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url']?.toString(),
      prevPageUrl: json['prev_page_url']?.toString(),
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'last_page': lastPage,
      'next_page_url': nextPageUrl,
      'prev_page_url': prevPageUrl,
      'from': from,
      'to': to,
    };
  }
}