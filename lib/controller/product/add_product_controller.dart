import 'dart:convert';

import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/global_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/product_repo.dart';
import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/brand_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/image_picker_option_bottom_sheet.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';

class AddProductController extends GetxController {
  AddProductController({
    required this.productRepo,
  });

  final ProductRepo productRepo;

  List<Images> arrSubImages = <Images>[];
  Images? mainImage;

  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
  final TextEditingController txtProdName = TextEditingController();
  final TextEditingController txtProdDesc = TextEditingController();
  final TextEditingController txtProdInitialQuantity = TextEditingController();
  final TextEditingController txtProdPrice = TextEditingController();
  final TextEditingController txtMinOrderQty = TextEditingController();
  final TextEditingController txtBarcode = TextEditingController();

  List<StoreModel> arrStores = <StoreModel>[];
  List<Category> arrCategory = <Category>[];
  List<Category> arrSubCategory = <Category>[];
  List<Brand> arrBrands = <Brand>[];
  StoreModel? selectedStore;
  Category? selectedCategory;
  Category? selectedSubCategory;
  Brand? selectedBrand;
  ProductDetailsModel? product;
  List<int> deletedImages = <int>[];

  final GlobalKey<FormState> addUnitFormKey = GlobalKey<FormState>();
  List<ProductSizeModel> arrBulkAmount = <ProductSizeModel>[];
  Set<int> deletedSizes = <int>{};

  @override
  void onInit() {
    super.onInit();
    manageArguments();
  }

  void manageArguments() {
    if (Get.arguments != null) {
      if (Get.arguments['product'] != null) {
        if (Get.arguments['product'] is ProductDetailsModel) {
          product = Get.arguments['product'];
          getProductDetails(
              productUUID: product?.uuid ?? '', productId: product?.id ?? 0);
        }
      }
    }
    getBrandList();
    if (product == null) {
      getStoreList();
    }
  }

  void setProductData() {
    txtMinOrderQty.text = product?.minimumOrderQuantity.toString() ?? '';
    txtProdPrice.text = product?.price ?? '';
    txtProdDesc.text = product?.description ?? '';
    txtProdName.text = product?.title ?? '';
    txtBarcode.text = product?.barcode ?? '';
    txtProdInitialQuantity.text = product?.quantity.toString() ?? '';
    selectedStore = arrStores.firstWhereOrNull(
        (final StoreModel store) => store.uuid == product?.storeUuid);
    selectedBrand = product?.brand;
    if ((product?.images ?? <Images>[]).isNotEmpty) {
      mainImage = product?.coverImage;

      arrSubImages = product!.images!
          .map((final Images e) => Images(
              id: e.id,
              image: e.image,
              isCoverImage: e.isCoverImage,
              name: e.name))
          .toList();

      arrSubImages
          .removeWhere((final Images image) => image.isCoverImage == true);
    }
    arrBulkAmount = product?.sizeData ?? <ProductSizeModel>[];
    update();
  }

  Future<void> onTapUploadMainImage() async {
    Get.bottomSheet(
      CommonBottomSheet(
        onTapCamera: () {
          pickMainImage(PhotoPickerType.camera);
        },
        onTapGallery: () {
          pickMainImage(PhotoPickerType.photos);
        },
      ),
      isDismissible: true,
      enableDrag: false,
      isScrollControlled: false,
    );
  }

  Future<void> pickMainImage(final PhotoPickerType photoPickerType) async {
    try {
      Media? media;
      if (photoPickerType == PhotoPickerType.camera) {
        media =
            await ImagePickers.openCamera(cameraMimeType: CameraMimeType.photo);
      } else {
        final List<Media> medias = await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          selectCount: 1,
          showGif: false,
        );
        if (medias.isNotEmpty) {
          media = medias.first;
        }
      }
      if (media != null) {
        mainImage = Images(image: media.path);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onTapUploadSubImage() async {
    if (arrSubImages.length == AppConstants.maxImageUploadCount) {
      return;
    }
    Get.bottomSheet(
      CommonBottomSheet(
        onTapCamera: () async {
          onTapPickSubImageFromCamera();
        },
        onTapGallery: () {
          onTapPickSubImageFromGallery();
        },
      ),
      isDismissible: true,
      enableDrag: false,
      isScrollControlled: false,
    );
  }

  Future<void> onTapPickSubImageFromCamera() async {
    final Media? media =
        await ImagePickers.openCamera(cameraMimeType: CameraMimeType.photo);
    if (media != null) {
      arrSubImages.add(Images(image: media.path));
      update();
    }
  }

  Future<void> onTapPickSubImageFromGallery() async {
    final int limit = AppConstants.maxImageUploadCount - arrSubImages.length;
    try {
      final List<Media> medias = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: limit,
        showGif: false,
      );
      for (int i = 0; i < medias.length; i++) {
        final Images image = Images(image: medias[i].path);
        arrSubImages.add(image);
      }

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getStoreList() async {
    try {
      final Map<String, dynamic> param = <String, dynamic>{
        'status': 'active',
        'page_size': 'all',
      };
      await productRepo
          .getStoreList(params: param)
          .then((final List<StoreModel> stores) async {
        arrStores = stores;
        if (product != null) {
          selectedStore = arrStores.firstWhereOrNull(
              (final StoreModel store) => store.uuid == product?.storeUuid);
          if (selectedStore?.uuid != null) {
            getStoreCategoryList();
          }
        }
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getStoreCategoryList() async {
    try {
      await productRepo
          .getStoreCategoryList(storeUUID: selectedStore?.uuid ?? '')
          .then((final List<Category> categories) async {
        arrCategory = categories;
        if (product != null) {
          selectedCategory = arrCategory.firstWhereOrNull(
              (final Category category) =>
                  category.id == product?.category?.id);
          if (selectedCategory?.id != null) {
            getStoreSubCategoryList();
          }
        }
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getStoreSubCategoryList() async {
    try {
      await productRepo
          .getStoreSubCategoryList(categoryId: selectedCategory?.id ?? 0)
          .then((final List<Category> subCategories) async {
        arrSubCategory = subCategories;
        if (product != null) {
          selectedSubCategory = arrSubCategory.firstWhereOrNull(
              (final Category category) =>
                  category.id == product?.subCategory?.id);
        }
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getProductDetails(
      {required final String productUUID, required final int productId}) async {
    try {
      Loader.load(true);
      final Map<String, dynamic> param = <String, dynamic>{
        'is_vendor': true,
        'id': productId
      };
      await productRepo
          .getProductDetails(productUUID: productUUID, params: param)
          .then((final ProductDetailsModel details) async {
        Loader.load(false);
        product = details;
        setProductData();
        getStoreList();
      });
    } catch (e) {
      Loader.load(false);
    }
  }

  Future<void> onTapAddOrEditProduct() async {
    if ((addProductFormKey.currentState?.validate() ?? false)) {
      if (!isImageAndStoreValidate()) {
        return;
      }
      final Map<String, dynamic> parameters = await getRequestParameters();
      debugPrint('parameters $parameters');

      if (product != null) {
        updateProduct(request: parameters, productUUID: product?.uuid ?? '');
      } else {
        createNewProduct(request: parameters);
      }
    }
  }

  bool isImageAndStoreValidate() {
    if (mainImage == null) {
      showCustomSnackBar(message: 'Please select product cover image'.tr);
      return false;
    } else if (selectedStore == null) {
      showCustomSnackBar(message: 'Please select product store'.tr);
      return false;
    } else if (selectedCategory == null) {
      showCustomSnackBar(message: 'Please select product category'.tr);
      return false;
    } else if (selectedSubCategory == null) {
      showCustomSnackBar(message: 'Please select product sub category'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<Map<String, dynamic>> getRequestParameters() async {
    final Map<String, dynamic> requestParameters = <String, dynamic>{
      'owner': selectedStore?.owner?.id ?? 0,
      'title': txtProdName.text.trim(),
      'description': txtProdDesc.text.trim(),
      'store': selectedStore?.id ?? 0,
      'category': selectedCategory?.id ?? 0,
      'price': txtProdPrice.text,
      'quantity': txtProdInitialQuantity.text,
      'minimum_order_quantity': txtMinOrderQty.text,
      'is_vendor': true,
      if (arrBulkAmount.isNotEmpty)
        'size_data': jsonEncode(arrBulkAmount
            .map((final ProductSizeModel unit) => unit.toJson())
            .toList()),
      if (deletedSizes.toList().isNotEmpty)
        'deleted_size': deletedSizes.toList(),
      if (selectedBrand != null) 'brand': selectedBrand?.id,
      'barcode': txtBarcode.text,
    };
    if (selectedSubCategory != null) {
      requestParameters['sub_category'] = selectedSubCategory?.id ?? 0;
    }

    final List<dio.MultipartFile> images = <dio.MultipartFile>[];
    for (int i = 0; i < arrSubImages.length; i++) {
      if (!Utility.checkIsNetworkUrl(arrSubImages[i].image ?? '')) {
        final String filename =
            Uri.file(arrSubImages[i].image ?? '').pathSegments.last;
        final dio.MultipartFile mpFile = await dio.MultipartFile.fromFile(
            arrSubImages[i].image ?? '',
            filename: filename);
        images.add(mpFile);
      }
    }
    requestParameters['product_images'] = images;
    if (mainImage != null) {
      if (!Utility.checkIsNetworkUrl(mainImage?.image ?? '')) {
        final String filename =
            Uri.file(mainImage?.image ?? '').pathSegments.last;
        final dio.MultipartFile coverFile = await dio.MultipartFile.fromFile(
            mainImage?.image ?? '',
            filename: filename);

        requestParameters['cover_image'] = coverFile;
      }
    }

    if (product != null) {
      requestParameters['deleted_images'] = deletedImages;
    }
    return requestParameters;
  }

  Future<void> createNewProduct(
      {required final Map<String, dynamic> request}) async {
    try {
      Loader.load(true);
      await productRepo.createNewProduct(body: request).then(
        (final dynamic stores) async {
          Loader.load(false);
          Get.find<GlobalController>().getProductFilter();
          Get.offAllNamed(
            RouteHelper.successScreen,
            arguments: <String, String>{
              AppConstants.successArgumentKey:
                  'Product Submitted for\nReview'.tr
            },
          );
        },
      );
    } catch (e) {
      Loader.load(false);
    }
  }

  Future<void> updateProduct(
      {required final Map<String, dynamic> request,
      required final String productUUID}) async {
    final Map<String, dynamic> queryParams = <String, dynamic>{
      'is_vendor': true,
      'id': product?.id
    };
    try {
      Loader.load(true);
      await productRepo
          .updateProduct(
        body: request,
        uuid: productUUID,
        queryParams: queryParams,
      )
          .then(
        (final dynamic stores) async {
          Loader.load(false);

          Get.back(result: true);
          showCustomSnackBar(
              isError: false, message: 'Product Updated Successfully'.tr);
          updateProductList();
        },
      );
    } catch (e) {
      Loader.load(false);
    }
  }

  void deleteImageFromSubImages(final int index) {
    if (product != null) {
      if (arrSubImages[index].id != null) {
        deletedImages.add(arrSubImages[index].id ?? 0);
      }
    }
    arrSubImages.removeAt(index);
    update();
  }

  void deleteCoverImage() {
    if (product != null) {
      if (mainImage?.id != null) {
        deletedImages.add(mainImage!.id ?? 0);
      }
    }
    mainImage = null;
    update();
  }

  void updateProductList() {
    Get.find<ProductListController>().refreshProductList();
    Get.find<GlobalController>().getProductFilter();
  }

  void onSelectStore({required final StoreModel? store}) {
    if (selectedStore != store) {
      selectedStore = store;
      selectedCategory = null;
      selectedSubCategory = null;
      arrCategory = <Category>[];
      arrSubCategory = <Category>[];
      update();
      getStoreCategoryList();
    }
  }

  void onSelectBrand({required final Brand? brand}) {
    if (selectedBrand?.id != brand?.id) {
      selectedBrand = brand;
      debugPrint('selected Brand $selectedBrand');
      update();
    }
  }

  void onSelectStoreCategory({required final Category? category}) {
    if (selectedCategory?.id != category?.id) {
      selectedCategory = category;
      selectedSubCategory = null;
      arrSubCategory = <Category>[];
      update();
      getStoreSubCategoryList();
    }
  }

  void onSelectStoreSubCategory({required final Category? subCategory}) {
    if (selectedSubCategory?.id != subCategory?.id) {
      selectedSubCategory = subCategory;
      update();
    }
  }

  Future<void> getBrandList() async {
    try {
      final BrandListResponseModel data = await Get.find<GlobalRepository>()
          .getBrandList(queryParams: <String, dynamic>{});
      arrBrands = data.results ?? <Brand>[];
      selectedBrand = arrBrands.firstWhereOrNull(
          (final Brand brand) => brand.uuid == product?.brand?.uuid);
      debugPrint('selectedBrand $selectedBrand');
      debugPrint('selectedBrand ${product?.brand}');
      update();
    } catch (e) {
      rethrow;
    }
  }

  void onTapSaveNewSize(final ProductSizeModel? sizeData, final int? index,
      final String price, final String unit) {
    if (addUnitFormKey.currentState?.validate() ?? false) {
      final double? number = double.tryParse(price.replaceAll(',', ''));
      if (number == null) {
        showCustomSnackBar(message: 'Please enter valid amount'.tr);
        return;
      } else if (number <= 0) {
        showCustomSnackBar(message: 'Please enter amount greater than 0'.tr);
        return;
      }

      if (sizeData != null && index != null) {
        arrBulkAmount[index].price = price;
        arrBulkAmount[index].unit = unit;
      } else {
        arrBulkAmount.add(
          ProductSizeModel(unit: unit, price: price),
        );
      }
      update();
      Get.back();
    }
  }

  void onTapDeleteSizeData(final ProductSizeModel item) {
    final int index = arrBulkAmount.indexOf(item);
    if (item.id != null) {
      deletedSizes.add(item.id!);
    }
    arrBulkAmount.removeAt(index);
    update();
  }
}
