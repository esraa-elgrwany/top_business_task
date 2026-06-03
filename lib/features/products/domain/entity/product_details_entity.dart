class ProductDetailsResponseEntity {
  final ProductDetailsDataEntity? data;
  final String? msg;
  final int? status;

  ProductDetailsResponseEntity({
    this.data,
    this.msg,
    this.status,
  });
}

class ProductDetailsDataEntity {
  final ProductDetailsItemEntity? productDetails;

  ProductDetailsDataEntity({
    this.productDetails,
  });
}

class ProductDetailsItemEntity {
  final int? id;
  final String? name;
  final List<int>? categoryIds;
  final int? priceBeforeDiscount;
  final int? priceAfterDiscount;
  final String? thumbnail;
  final List<String>? images;
  final String? description;
  final String? shortDescription;
  final bool? inWishlist;
  final String? slug;
  final int? productStockCount;
  final double? discount;
  final num? rate;
  final bool? isTaxable;
  final List<dynamic>? attributes;
  final List<RelatedProductEntity>? relatedProducts;
  final Map<String, dynamic>? translation;
  final List<dynamic>? buyItTogether;

  ProductDetailsItemEntity({
    this.id,
    this.name,
    this.categoryIds,
    this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.thumbnail,
    this.images,
    this.description,
    this.shortDescription,
    this.inWishlist,
    this.slug,
    this.productStockCount,
    this.discount,
    this.rate,
    this.isTaxable,
    this.attributes,
    this.relatedProducts,
    this.translation,
    this.buyItTogether,
  });

  bool get isOutOfStock => (productStockCount ?? 0) <= 0;
  bool get hasDiscount => (priceBeforeDiscount ?? 0) > (priceAfterDiscount ?? 0);
}

class RelatedProductEntity {
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

  RelatedProductEntity({
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