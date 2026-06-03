import 'package:test_task/features/products/domain/entity/product_details_entity.dart';

class ProductDetailsResponseModel extends ProductDetailsResponseEntity {
  ProductDetailsResponseModel({
    ProductDetailsDataModel? super.data,
    super.msg,
    super.status,
  });

  factory ProductDetailsResponseModel.fromJson(dynamic json) {
    return ProductDetailsResponseModel(
      data: json['data'] != null ? ProductDetailsDataModel.fromJson(json['data']) : null,
      msg: json['msg']?.toString(),
      status: json['status'] is int ? json['status'] : int.tryParse(json['status']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (data != null) 'data': (data as ProductDetailsDataModel).toJson(),
      'msg': msg,
      'status': status,
    };
  }
}

class ProductDetailsDataModel extends ProductDetailsDataEntity {
  ProductDetailsDataModel({
    ProductDetailsItemModel? super.productDetails,
  });

  factory ProductDetailsDataModel.fromJson(dynamic json) {
    return ProductDetailsDataModel(
      productDetails: json['productDetails'] != null
          ? ProductDetailsItemModel.fromJson(json['productDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (productDetails != null)
        'productDetails': (productDetails as ProductDetailsItemModel).toJson(),
    };
  }
}

class ProductDetailsItemModel extends ProductDetailsItemEntity {
  ProductDetailsItemModel({
    super.id,
    super.name,
    super.categoryIds,
    super.priceBeforeDiscount,
    super.priceAfterDiscount,
    super.thumbnail,
    super.images,
    super.description,
    super.shortDescription,
    super.inWishlist,
    super.slug,
    super.productStockCount,
    super.discount,
    super.rate,
    super.isTaxable,
    super.attributes,
    List<RelatedProductModel>? super.relatedProducts,
    super.translation,
    super.buyItTogether,
  });

  factory ProductDetailsItemModel.fromJson(dynamic json) {
    return ProductDetailsItemModel(
      id: json['id'],
      name: json['name']?.toString(),
      categoryIds: json['category_ids'] != null ? List<int>.from(json['category_ids']) : [],
      priceBeforeDiscount: json['price_before_discount'],
      priceAfterDiscount: json['price_after_discount'],
      thumbnail: json['thumbnail']?.toString(),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      description: json['description']?.toString(),
      shortDescription: json['short_description']?.toString(),
      inWishlist: json['in_wishlist'] is bool ? json['in_wishlist'] : (json['in_wishlist'] == 1),
      slug: json['slug']?.toString(),
      productStockCount: json['product_stock_count'],
      discount: json['discount'] is num ? (json['discount'] as num).toDouble() : double.tryParse(json['discount']?.toString() ?? '0.0'),
      rate: json['rate'],
      isTaxable: json['is_taxable'] is bool ? json['is_taxable'] : (json['is_taxable'] == 1),
      attributes: json['attributes'] != null ? List<dynamic>.from(json['attributes']) : [],
      relatedProducts: json['related_ids'] != null
          ? (json['related_ids'] as List).map((v) => RelatedProductModel.fromJson(v)).toList()
          : [],
      translation: json['translation'] != null ? Map<String, dynamic>.from(json['translation']) : null,
      buyItTogether: json['buy_it_together'] != null ? List<dynamic>.from(json['buy_it_together']) : [],
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
      'description': description,
      'short_description': shortDescription,
      'in_wishlist': inWishlist,
      'slug': slug,
      'product_stock_count': productStockCount,
      'discount': discount,
      'rate': rate,
      'is_taxable': isTaxable,
      'attributes': attributes,
      if (relatedProducts != null)
        'related_ids': relatedProducts!.map((v) => (v as RelatedProductModel).toJson()).toList(),
      'translation': translation,
      'buy_it_together': buyItTogether,
    };
  }
}

class RelatedProductModel extends RelatedProductEntity {
  RelatedProductModel({
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

  factory RelatedProductModel.fromJson(dynamic json) {
    return RelatedProductModel(
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