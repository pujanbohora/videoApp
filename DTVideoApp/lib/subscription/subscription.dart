import 'dart:developer';
import 'package:dtvideo/model/packagesmodel.dart';
import 'package:dtvideo/pages/setting.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/myappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../widget/mytext.dart';
import 'consumable_store.dart';

final bool _kAutoConsume = Platform.isIOS || true;

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  String? userId;
  SharedPre sharePref = SharedPre();
  List<Result>? packagelist;
  int? selectIndex = 0;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final List<ProductDetails> _products = <ProductDetails>[];
  final List<String> _kProductIds = <String>[];
  final List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    getUserId();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        log("===> ${productDetailResponse.error!.message}");
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;

        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        log("===> ${productDetailResponse.productDetails}");
        _queryProductError = null;
        _isAvailable = isAvailable;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      log("===> 2 ${productDetailResponse.productDetails}");
      _purchasePending = false;
      _loading = false;
    });
  }

  getUserId() async {
    userId = await sharePref.read('userid') ?? "0";
    debugPrint('userID===>${userId.toString()}');

    final packageProvider = Provider.of<ApiProvider>(context, listen: false);
    packageProvider.getPackage(context, userId);
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final packageProvider = Provider.of<ApiProvider>(context);
    if (!packageProvider.loading) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appBgColor,
          body: Center(
            child: Container(
                width: 100,
                height: 100,
                color: primary,
                child: const CircularProgressIndicator()),
          ));
    } else {
      if (packageProvider.packagemodel.status == 200 &&
          (packageProvider.packagemodel.result?.length ?? 0) > 0) {
        packagelist = packageProvider.packagemodel.result;
        log("===>package ${packagelist?.length}");
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appBgColor,
          body: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyAppbar(title: "Subscription"),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MyText(
                          text: "Get Access of All Paid Videos",
                          color: white,
                          textalign: TextAlign.center,
                          fontwaight: FontWeight.w500,
                          fontsize: 30),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: packagelist?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectIndex = index;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 8, right: 20, bottom: 8),
                          child: Container(
                            height: 110,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            width: MediaQuery.of(context).size.width,
                            decoration: selectIndex == index
                                ? const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/ic_packagebg_select.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/ic_packagebg.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 15),
                                SizedBox(
                                  child: MyText(
                                    text: (packageProvider
                                            .packagemodel.result?[index].name ??
                                        ""),
                                    fontsize: 20,
                                    fontwaight: FontWeight.w500,
                                    color: white,
                                    maxline: 2,
                                  ),
                                ),
                                const Spacer(),
                                MyText(
                                  text:
                                      "${packageProvider.packagemodel.result?[index].price ?? ""} ",
                                  fontsize: 36,
                                  fontwaight: FontWeight.bold,
                                  color: white,
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () async {
                    _kProductIds.clear();
                    _kProductIds.add(
                        packagelist?[selectIndex ?? 0].productPackage ?? "");
                    log("===> ${_kProductIds.length}");

                    purchaseItem();
                    // addPurchase();
                  },
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    }
  }

  purchaseItem() async {
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kProductIds.toSet());
    if (response.notFoundIDs.isNotEmpty) {
      Utils.toastMessage("Please check SKU");
      return;
    }
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: response.productDetails[0]);
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          log("===> status ${purchaseDetails.status}");
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume &&
              purchaseDetails.productID ==
                  packagelist?[selectIndex ?? 0].productPackage) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                _inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          log("===> pendingCompletePurchase ${purchaseDetails.pendingCompletePurchase}");
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    log("===> productID ${purchaseDetails.productID}");
    if (purchaseDetails.productID ==
        packagelist?[selectIndex ?? 0].productPackage) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      log("===> consumables ${consumables}");
      addPurchase();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      log("===> consumables else ${purchaseDetails}");
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    log("===> invalid Purchase ${purchaseDetails}");
  }

  addPurchase() async {
    final provider = Provider.of<ApiProvider>(context, listen: false);
    await provider.getaddTranscation(
        userId.toString(),
        packagelist?[selectIndex ?? 0].id.toString() ?? "",
        packagelist?[selectIndex ?? 0].price.toString() ?? "",
        packagelist?[selectIndex ?? 0].price.toString() ?? "");
    debugPrint('===>get responce${provider.successModel.status}');
    if (!provider.loading) {
      const CircularProgressIndicator();
    } else {
      if (provider.successModel.status == 200) {
        log("===> message ${provider.successModel.message}");
        Utils().showToast("Thank you for Subscribe Packages");
        await sharePref.save("is_buy", "1");
        Navigator.pop(context);
      }
    }
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
