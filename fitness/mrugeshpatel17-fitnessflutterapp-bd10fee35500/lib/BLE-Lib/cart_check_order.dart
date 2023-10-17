/*
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:wasm';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ratio/localizations.dart';
import 'package:ratio/models/req_create_order.dart';
import 'package:ratio/models/res_cart_coupon.dart';
import 'package:ratio/models/res_create_order.dart';
import 'package:ratio/models/res_store_state.dart';
import 'package:ratio/pages/cart_page.dart';
import 'package:ratio/pages/main_page.dart';
import 'package:ratio/pages/scan_pay.dart';
import 'package:ratio/utils/glob.dart';
import 'package:ratio/utils/my_data_manager.dart';
import 'package:ratio/utils/network_utils.dart';

import 'package:ratio/widgets/check_order_product_item.dart';
import 'package:ratio/widgets/my_loading.dart';
import 'package:serial_port_flutter/serial_port_flutter.dart';
import 'dart:math';

class CheckOrderPage extends StatefulWidget {
  final Function(String orderId) submitCallBack;
  final Map<OrderProductItem, int> itemCount;
  final String couponId;
  final List<PromotionItem> promotions;
  final List<CouponUsedItem> coupons;

  CheckOrderPage(this.couponId, this.submitCallBack, this.itemCount,
      this.promotions, this.coupons);

  @override
  _CartCheckOrderState createState() => _CartCheckOrderState();
}

class _CartCheckOrderState extends State<CheckOrderPage>
    with TickerProviderStateMixin {
  bool submit = false;

  bool machineMake = false;

  int machineNum;
  int humanNum;

  int payWay;

  bool open = false;
  AnimationController _controller;
  Animation animation;
  GlobalKey key = GlobalKey();

  String curOrderNumber;
  bool _allowWriteFile = false;

  @override
  void initState() {
    // TODO: implement initState

    //Ankita

    //requestWritePermission();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = new Tween<double>(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
      } else if (_controller.status == AnimationStatus.dismissed) {
        this.open = false;
      }
    });

    super.initState();
    loadStoreState();

    MyDataManager().startTimer(); //添加全局计时器
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(
            top: 16, //MainPage.TITLE_HIGHT + MainPage.BOTTOM_HIGHT,
            bottom: 0),
        child: Stack(children: <Widget>[
          SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                    // top: MainPage.TITLE_HIGHT + MainPage.BOTTOM_HIGHT,
                      bottom: 100),
                  child: Column(
                    children: getOrderItem(),
                  ))),
          Container(
              margin: EdgeInsets.only(top: MainPage.TITLE_HIGHT, left: 12),
              height: MainPage.BOTTOM_HIGHT,
              color: Theme.of(context).bottomAppBarColor,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context).checkout,
                  style: Theme.of(context).accentTextTheme.headline1,
                ),
              )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 100,
              child: Column(
                children: <Widget>[
                  Divider(height: 1),
                  Container(
                      height: 99,
                      color: Theme.of(context).bottomAppBarColor,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                          child:
                          Column(mainAxisSize: MainAxisSize.min, children: <
                              Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    Text(
                                      CartPageState
                                          .reqCreateOrder.orderDetail.length
                                          .toString(),
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline3,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      AppLocalizations.of(context).items,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline4,
                                    ),
                                  ],
                                ),
                                Wrap(
                                  children: <Widget>[
                                    Text(
                                      '\$',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline4
                                          .apply(
                                          fontFamily: 'proxima',
                                          color:
                                          Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      CartPageState.reqCreateOrder.price.toString(),
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline5
                                          .apply(
                                          fontFamily: 'proxima',
                                          color:
                                          Theme.of(context).primaryColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: <Widget>[
                                FlatButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    color: Glob.isDarkMode
                                        ? Color.fromARGB(0xff, 0x31, 0x31, 0x31)
                                        : Color.fromARGB(0xff, 0xcc, 0xcc, 0xcc),
                                    onPressed: () {
                                      MyDataManager().startTimer(); //添加全局计时器
                                      widget.submitCallBack(null);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color:
                                      Theme.of(context).accentIconTheme.color,
                                      size: 16,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: FlatButton(
                                        padding: EdgeInsets.symmetric(vertical: 13),
                                        color: Theme.of(context).primaryColor,
                                        disabledColor:
                                        Theme.of(context).disabledColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                        onPressed: (CartPageState.reqCreateOrder
                                            .orderDetail.isEmpty ||
                                            submit)
                                            ? null
                                            : () async {
                                          MyDataManager()
                                              .startTimer(); //添加全局计时器
                                          submitOrder(context);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context).placeOrder,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline4
                                              .apply(
                                              fontFamily: 'proxima',
                                              color: Colors.white),
                                        )))
                              ],
                            )
                          ]))),
                ],
              ),
            ),
          ),
          open
              ? Container(
              color: Color.fromARGB(150, 0, 0, 0),
              child: ScaleTransition(
                //设置动画的缩放中心
                alignment: Alignment.center,
                //动画控制器
                scale: _controller,
                //将要执行动画的子view
                child: ScanPayPage(() {
                  this.setState(() {
                    _controller.reverse();
                    // this.open = false;
                  });
                }, this.curOrderNumber),
              ))
              : Container(),

          //  AppActionBarWidget(),
        ]),
      ),
    );
  }

  void submitOrder(context) {
    //   showModalBottomSheet(
    //     context: context,

    //   builder: (BuildContext context) {
    //     return new Container(
    //       height: 2000,
    //       width: 100,
    //       color: Colors.red,
    //       child: ScanPayPage(),
    //     );
    //     // return ScanPayPage();
    //   },
    // ).then((val) {
    //   print(val);
    // });

    if (submit) {
      return;
    }
    LoadingPage myLoading = LoadingPage(context);
    myLoading.show();
    submit = true;
    CartPageState.reqCreateOrder.tableNumber = Glob.table;
    CartPageState.reqCreateOrder.createTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    CartPageState.reqCreateOrder.coupon = widget.couponId;
    CartPageState.reqCreateOrder.orderChannel = 'app';
    CartPageState.reqCreateOrder.userId = Glob.userId;
    CartPageState.reqCreateOrder.userName = 'hx';
    CartPageState.reqCreateOrder.orderType = 100;
//    CartPageState.reqCreateOrder.orderType = 1;
    CartPageState.reqCreateOrder.userPhoneNumber = '';
    CartPageState.reqCreateOrder.userAddress = '';
    CartPageState.reqCreateOrder.storeId = Glob.storeId;
    CartPageState.reqCreateOrder.tableNumber = 1;
    CartPageState.reqCreateOrder.payStatus = 0;
    CartPageState.reqCreateOrder.paySuccessDate = '';
    CartPageState.reqCreateOrder.orderStatus = 100;
    CartPageState.reqCreateOrder.takeCode = "";
    CartPageState.reqCreateOrder.coupon = "";
    CartPageState.reqCreateOrder.remark = "";
    CartPageState.reqCreateOrder.totalPrice =
        CartPageState.reqCreateOrder.totalPrice;
    CartPageState.reqCreateOrder.price = CartPageState.reqCreateOrder.price;
    CartPageState.reqCreateOrder.count =
        CartPageState.reqCreateOrder.orderDetail.length;
    for (OrderProductItem opi in CartPageState.reqCreateOrder.orderDetail) {
      if (this.machineMake) {
        opi.isMachine = 1;
      } else {
        opi.isMachine = 0;
      }
    }
    var callBack = (dataMap, {error}) {
      submit = false;
      myLoading.close();
      ResCreateOrder res = ResCreateOrder.fromJson(dataMap);

      print("CreateOrderNew :$dataMap");
      if (res.errcode != null && res.errcode == '0') {
        // widget.submitCallBack(res.ordernumber);
        // CartPageState.reqCreateOrder =
        //     new ReqCreateOrder(orderDetail: List(), totalPrice: 0);

// 新的逻辑，不返回，显示支付二维码
        // CartPageState.reqCreateOrder =
        //     new ReqCreateOrder(orderDetail: List(), totalPrice: 0);

        if (payWay == 2) {
          this.setState(() {
            this.curOrderNumber = res.ordernumber;
            this.open = true;
            _controller.forward();
          });
        } else {
          widget.submitCallBack(res.ordernumber);
          CartPageState.reqCreateOrder =
          new ReqCreateOrder(orderDetail: List(), totalPrice: 0);
        }
      } else {
        print(dataMap);
      }
    };
    NetworkUtils.postHttps(
        'order/CreateOrderNew', CartPageState.reqCreateOrder, callBack);
  }

  getOrderItem() {
    var res = <Widget>[];
    var orderItems = <Widget>[];
    res.add(SizedBox(height: 40));
    for (OrderProductItem opi in widget.itemCount.keys) {
      orderItems.add(CheckOrderProductItemWidget(opi, widget.itemCount));
    }
    orderItems.add(Divider(
      color: Colors.white,
    ));
    orderItems.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(AppLocalizations.of(context).subTotal,
            style: Theme.of(context).primaryTextTheme.headline5.apply(
              fontSizeDelta: -2,
            )),
        Wrap(
          children: <Widget>[
            Text(
              '\$',
              style: Theme.of(context).primaryTextTheme.headline4.apply(
                fontSizeDelta: -2,
              ),
            ),
            Text((CartPageState.reqCreateOrder.price).toString(),
                style: Theme.of(context).primaryTextTheme.headline5.apply(
                  fontSizeDelta: -2,
                )),
          ],
        )
      ],
    ));
    res.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Glob.isDarkMode
              ? Color.fromARGB(0xff, 0x23, 0x2a, 0x31)
              : Color.fromARGB(0xff, 0xf8, 0xf8, 0xf8),
          borderRadius: BorderRadius.circular(6)),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(mainAxisSize: MainAxisSize.min, children: orderItems),
    ));

    if (widget.promotions != null) {
      for (PromotionItem promotionItem in widget.promotions) {
        res.add(Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Glob.isDarkMode
                    ? Color.fromARGB(0xff, 0x31, 0x31, 0x31)
                    : Color.fromARGB(0xff, 0xf0, 0xf0, 0xf0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Text(AppLocalizations.of(context).promotion,
                        style:
                        Theme.of(context).primaryTextTheme.headline4.apply(
                          fontFamily: 'proxima',
                          fontSizeDelta: 4,
                        )),
                    Text(
                        (AppLocalizations.of(context).locale.languageCode ==
                            'zh')
                            ? promotionItem.name
                            : promotionItem.nameEn,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline4
                            .apply(
                            fontFamily: 'proxima',
                            fontSizeDelta: 4,
                            color: Theme.of(context).hintColor))
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    Text('-\$',
                        style:
                        Theme.of(context).primaryTextTheme.headline4.apply(
                          fontFamily: 'proxima',
                          color: Theme.of(context).hintColor,
                        )),
                    Text(
                      promotionItem.discountprice.toString(),
                      style: Theme.of(context).primaryTextTheme.headline4.apply(
                          fontFamily: 'proxima',
                          fontSizeDelta: 4,
                          color: Theme.of(context).hintColor),
                    ),
                  ],
                )
              ],
            )));
      }
    }

    if (widget.coupons != null) {
      for (CouponUsedItem couponItem in widget.coupons) {
        res.add(Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Glob.isDarkMode
                    ? Color.fromARGB(0xff, 0x31, 0x31, 0x31)
                    : Color.fromARGB(0xff, 0xf0, 0xf0, 0xf0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Text(AppLocalizations.of(context).coupon,
                        style:
                        Theme.of(context).primaryTextTheme.headline4.apply(
                          fontFamily: 'proxima',
                          fontSizeDelta: 4,
                        )),
                    Text(
                        (AppLocalizations.of(context).locale.languageCode ==
                            'zh')
                            ? couponItem.name
                            : couponItem.nameEn,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline4
                            .apply(
                            fontFamily: 'proxima',
                            fontSizeDelta: 4,
                            color: Theme.of(context).hintColor))
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    Text('-\$',
                        style:
                        Theme.of(context).primaryTextTheme.headline4.apply(
                          fontFamily: 'proxima',
                          color: Theme.of(context).hintColor,
                        )),
                    Text(
                      couponItem.discountprice.toString(),
                      style: Theme.of(context).primaryTextTheme.headline4.apply(
                          fontFamily: 'proxima',
                          fontSizeDelta: 4,
                          color: Theme.of(context).hintColor),
                    ),
                  ],
                )
              ],
            )));
      }
    }
    var time = DateTime.now();
    try {
      time.add(Duration(seconds: Glob.waitTime));
    } catch (e) {}
    res.add(Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
            color: Glob.isDarkMode
                ? Color.fromARGB(0xff, 0x23, 0x2a, 0x31)
                : Color.fromARGB(0xff, 0xf8, 0xf8, 0xf8),
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(AppLocalizations.of(context).orderReadyHint,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline6
                    .apply(fontSizeDelta: -2, fontFamily: 'proxima')),
            const SizedBox(height: 6),
            Text(DateFormat("hh:mm a").format(time),
                style: Theme.of(context).primaryTextTheme.headline5.apply(
                    fontSizeDelta: 10, color: Theme.of(context).primaryColor)),
          ],
        )));
    res.add(Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
            color: Glob.isDarkMode
                ? Color.fromARGB(0xff, 0x23, 0x2a, 0x31)
                : Color.fromARGB(0xff, 0xf8, 0xf8, 0xf8),
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(AppLocalizations.of(context).productionMethod,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline6
                    .apply(fontSizeDelta: -2, fontFamily: 'proxima')),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Glob.isDarkMode
                            ? Color.fromARGB(0xff, 0x18, 0x1c, 0x21)
                            : (machineMake
                            ? Colors.white
                            : Color.fromARGB(0xff, 0xf0, 0xf0, 0xf0)),
                        border: machineMake
                            ? Border.all(
                            width: 1, color: Theme.of(context).primaryColor)
                            : null,
                      ),
                      child: Material(
                          type: MaterialType.transparency,
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: InkWell(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        AppLocalizations.of(context)
                                            .manualProduction,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline5
                                            .apply(
                                            fontSizeDelta: -6,
                                            color: machineMake
                                                ? Theme.of(context)
                                                .primaryColor
                                                : (Glob.isDarkMode
                                                ? Color.fromARGB(0xff,
                                                0x87, 0x87, 0x87)
                                                : Color.fromARGB(0xff,
                                                0x72, 0x72, 0x72)),
                                            fontFamily: 'proxima')),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Wrap(
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context).queue,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline6
                                              .apply(
                                              fontSizeDelta: -4,
                                              color: (Glob.isDarkMode
                                                  ? Color.fromARGB(0xff,
                                                  0x87, 0x87, 0x87)
                                                  : Color.fromARGB(0xff,
                                                  0x72, 0x72, 0x72)),
                                              fontFamily: 'proxima'),
                                        ),
                                        Text(this.humanNum.toString() ?? '...',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline5
                                                .apply(
                                                fontSizeDelta: -6,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontFamily: 'proxima')),
                                        Text(
                                            AppLocalizations.of(context)
                                                .inFront,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6
                                                .apply(
                                                fontSizeDelta: -4,
                                                color: (Glob.isDarkMode
                                                    ? Color.fromARGB(0xff,
                                                    0x87, 0x87, 0x87)
                                                    : Color.fromARGB(0xff,
                                                    0x72, 0x72, 0x72)),
                                                fontFamily: 'proxima')),
                                      ],
                                    )
                                  ],
                                )),
                            onTap: () {
                              MyDataManager().startTimer(); //重启定时器
                              machineMake = true;
                              loadStoreState();
                            },
                          ))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Glob.isDarkMode
                            ? Color.fromARGB(0xff, 0x18, 0x1c, 0x21)
                            : (!machineMake
                            ? Colors.white
                            : Color.fromARGB(0xff, 0xf0, 0xf0, 0xf0)),
                        border: !machineMake
                            ? Border.all(
                            width: 1, color: Theme.of(context).primaryColor)
                            : null,
                      ),
                      child: Material(
                          type: MaterialType.transparency,
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: InkWell(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .robotProduction,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline5
                                          .apply(
                                          fontSizeDelta: -6,
                                          color: !machineMake
                                              ? Theme.of(context)
                                              .primaryColor
                                              : (Glob.isDarkMode
                                              ? Color.fromARGB(0xff,
                                              0x87, 0x87, 0x87)
                                              : Color.fromARGB(0xff,
                                              0x72, 0x72, 0x72)),
                                          fontFamily: 'proxima'),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Wrap(
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context).queue,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline6
                                              .apply(
                                              fontSizeDelta: -4,
                                              color: (Glob.isDarkMode
                                                  ? Color.fromARGB(0xff,
                                                  0x87, 0x87, 0x87)
                                                  : Color.fromARGB(0xff,
                                                  0x72, 0x72, 0x72)),
                                              fontFamily: 'proxima'),
                                        ),
                                        Text(
                                            this.machineNum.toString() ?? '...',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline5
                                                .apply(
                                                fontSizeDelta: -6,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontFamily: 'proxima')),
                                        Text(
                                            AppLocalizations.of(context)
                                                .inFront,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6
                                                .apply(
                                                fontSizeDelta: -4,
                                                color: (Glob.isDarkMode
                                                    ? Color.fromARGB(0xff,
                                                    0x87, 0x87, 0x87)
                                                    : Color.fromARGB(0xff,
                                                    0x72, 0x72, 0x72)),
                                                fontFamily: 'proxima')),
                                      ],
                                    )
                                  ],
                                )),
                            onTap: () {
                              MyDataManager().startTimer(); //重启定时器
                              machineMake = false;
                              loadStoreState();
                            },
                          ))),
                )
              ],
            )
          ],
        )));
    res.add(Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: Glob.isDarkMode
              ? Color.fromARGB(0xff, 0x23, 0x2a, 0x31)
              : Color.fromARGB(0xff, 0xf8, 0xf8, 0xf8),
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(AppLocalizations.of(context).paymentMethod,
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline6
                  .apply(fontSizeDelta: -2, fontFamily: 'proxima')),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Glob.isDarkMode
                          ? Color.fromARGB(0xff, 0x18, 0x1c, 0x21)
                          : (payWay == 1
                          ? Colors.white
                          : Color.fromARGB(0xff, 0xf0, 0xf0, 0xf0)),
                      border: payWay == 1
                          ? Border.all(
                          width: 1, color: Theme.of(context).primaryColor)
                          : null,
                    ),
                    child: Material(
                        type: MaterialType.transparency,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: InkWell(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Column(
                                children: <Widget>[
                                  Text('Terminal',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline5
                                          .apply(
                                          fontSizeDelta: 0,
                                          color: payWay == 1
                                              ? Theme.of(context)
                                              .primaryColor
                                              : (Glob.isDarkMode
                                              ? Color.fromARGB(0xff,
                                              0x87, 0x87, 0x87)
                                              : Color.fromARGB(0xff,
                                              0x72, 0x72, 0x72)),
                                          fontFamily: 'proxima')),
//                                  const SizedBox(
//                                    height: 6,
//                                  ),
//                                  Wrap(
//                                    spacing: 0,
//                                    runSpacing: 0,
//                                    children: <Widget>[
//                                      Image.asset(
//                                        Glob.imageAssetsPage(
//                                            'card-Mastercard.png'),
//                                        width: 40,
//                                        height: 40,
//                                        fit: BoxFit.contain,
//                                      ),
//                                      Image.asset(
//                                        Glob.imageAssetsPage('card-Visa.png'),
//                                        width: 40,
//                                        height: 40,
//                                        fit: BoxFit.contain,
//                                      ),
//                                      Image.asset(
//                                        Glob.imageAssetsPage('card-nets.png'),
//                                        width: 40,
//                                        height: 40,
//                                        fit: BoxFit.contain,
//                                      ),
//                                    ],
//                                  )
                                ],
                              )),
                          onTap: () {
                            //todo parth pitroda
//                            swipeCard();
                            creteSerialPort();
                            MyDataManager().startTimer(); //重启定时器
                            setState(() {
                              payWay = 1;
                            });
                          },
                        ))),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Glob.isDarkMode
                          ? Color.fromARGB(0xff, 0x18, 0x1c, 0x21)
                          : (payWay == 2
                          ? Colors.white
                          : Color.fromARGB(0xff, 0xf0, 0xf0, 0xf0)),
                      border: payWay == 2
                          ? Border.all(
                          width: 1, color: Theme.of(context).primaryColor)
                          : null,
                    ),
                    child: Material(
                        type: MaterialType.transparency,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: InkWell(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).scanToPay,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline5
                                        .apply(
                                        fontSizeDelta: -6,
                                        color: payWay == 2
                                            ? Theme.of(context).primaryColor
                                            : (Glob.isDarkMode
                                            ? Color.fromARGB(
                                            0xff, 0x87, 0x87, 0x87)
                                            : Color.fromARGB(0xff, 0x72,
                                            0x72, 0x72)),
                                        fontFamily: 'proxima'),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    children: <Widget>[
                                      Image.asset(
                                        Glob.imageAssetsPage('card-dbs.png'),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                      Image.asset(
                                        Glob.imageAssetsPage('card-ocbc.png'),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                      Image.asset(
                                        Glob.imageAssetsPage(
                                            'card-netspay.png'),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          onTap: () {
                            MyDataManager().startTimer(); //重启定时器
                            setState(() {
                              payWay = 2;
                            });
                          },
                        ))),
              )
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    ));
    return res;
  }

  void loadStoreState() {
    var callBack = (dataMap, {error}) {
      ResStoreState res = ResStoreState.fromJson(dataMap);
      if (res.errcode != null && res.errcode == '0') {
        setState(() {
          machineNum = res.data.machineNum;
          humanNum = res.data.humanNum;
        });
      } else {}
    };
    NetworkUtils.postHttps(
        'order/GetIndexInfo?storeId=' + Glob.storeId, {}, callBack);
  }

  Future<List<Device>> findDevices() async {
    return await FlutterSerialPort.listDevices();
  }

  var increment = 000000000001;
  var requestData = new List<int>();
  bool isDeviceConnected = false;
  var serialPort;
  bool isPortOpen =false;
  int nackCount = 0;
  bool isTerminalGivenReply = false;
  int noResponseFromTerminalCount = -1;
  bool timeoutTransaction = false;

  static const timeout = const Duration(seconds: 2);
  static const ms = const Duration(milliseconds: 1);

  creteSerialPort() async {
    findDevices().then((value) async {
      int count = 0;
      nackCount = 0;
      noResponseFromTerminalCount = 0;

      for (Device opi in value) {
        count++;
        if (opi != null && opi.name == "ttyS4 (serial)") {
          final debounceTransformer =
          StreamTransformer<Uint8List, dynamic>.fromBind((s) =>
              s.transform(
                  debounceBuffer(const Duration(milliseconds: 500))));

          if(!isPortOpen) {
            serialPort = await FlutterSerialPort.createSerialPort(opi, 9600);
            isPortOpen = await serialPort.open();
            serialPort.receiveStream.transform(debounceTransformer).listen((recv) async {
              noReply = true;
              stopTimer();
              String recvCovertedData = formatReceivedData(recv);
              Fluttertoast.showToast(msg: "recv Coverted Data : " + recvCovertedData);
              Clipboard.setData(new ClipboardData(text: recvCovertedData));
              if(recvCovertedData.length<5 )
              {
                  if(recvCovertedData == "6")
                  {
                    isTerminalGivenReply = true;
                    //Fluttertoast.showToast(msg: "ACK");
                    nackCount = 0;
                    noResponseFromTerminalCount = 0;
                    stopTimer();
                    timeoutTransaction = true;
                  }
                  if(recvCovertedData == "15")
                  {
                    nackCount++;
                    if(nackCount >= 3)
                      {
                        Fluttertoast.showToast(msg: "Error while doing transaction 1. Data : " + recvCovertedData);
                        nackCount = 0;
                        noResponseFromTerminalCount = 0;
                        stopTimer();
                      }
                    else if(nackCount==1 && noResponseFromTerminalCount>=2)
                      {
                        Fluttertoast.showToast(msg: "Error while doing transaction 2. Data : " + recvCovertedData);
                        nackCount = 0;
                        noResponseFromTerminalCount = 0;
                        stopTimer();
                      }
                    else {
                      //Fluttertoast.showToast(msg: "NACK");
                      isTerminalGivenReply = false;
                      String data = doTransaction(true);
                      noReply = false;
                      serialPort.write(Uint8List.fromList(hexToUnits(data)));
                      startTimer();
                    }
                  }
              }
              else
              {
                String checkFirstString = recvCovertedData.substring(0,2);

                if(checkFirstString != "02")
                {
                  recvCovertedData = recvCovertedData.substring(2,recvCovertedData.length);
                }

                timeoutTransaction = false;
                if(checkLRC(recvCovertedData)) {
                  if (recvCovertedData.length > 100) {
                    isTerminalGivenReply = false;
                    nackCount = 0;
                    noResponseFromTerminalCount = 0;
                    stopTimer();
                    serialPort.write(Uint8List.fromList(hexToUnits("06")));
                    responseTransaction(recvCovertedData);
                  }
                }
                else
                {
                  serialPort.write(Uint8List.fromList(hexToUnits("15")));
                  Fluttertoast.showToast(msg: "Check LRC Failed : " + recvCovertedData);

                  if(noResponseFromTerminalCount<3) {
                    startTimer();
                  }
                }
              }
            });
          }

          if (isPortOpen) {
            String data = doTransaction(false);
            isTerminalGivenReply = false;
            noReply = false;
            //Fluttertoast.showToast(msg: "Data : " + data);
            serialPort.write(Uint8List.fromList( hexToUnits(data)));
            stopTimeoutTimer();
            startTimer();
            startTimeoutTimer();
          }
        }
      }
    });
  }

  void responseTransaction(String recvCovertedData)
  {
    switch(currentPaymentMode)
    {
      case "NetsPayment":
        List<String> dataArray = recvCovertedData.split('1C');
        String approvalCode = dataArray[1].substring(4,dataArray[1].length).toString();

        if(approvalCode == "0040415050524F5645442020202020202020202020202020202020202020202020202020202020202020")
        {
          stopTimer();
          stopTimeoutTimer();
          Fluttertoast.showToast(msg: "Transaction successfull. Approval Code = " + approvalCode);
        }
        else
        {
          Fluttertoast.showToast(msg: "Transaction Failed. Approval Code = " + approvalCode);
        }
        break;
      case "CreditCardPayment":
        List<String> dataArray = recvCovertedData.split('1C');
        String approvalCode = dataArray[5].substring(6,18).toString();
        if(approvalCode=="063030303030")
        {
          stopTimer();
          stopTimeoutTimer();
          Fluttertoast.showToast(msg: "Transaction successfull. Approval Code = " + approvalCode);
        }
        else
        {
          Fluttertoast.showToast(msg: "Transaction Failed. Approval Code = " + approvalCode);
        }
        break;
      case "CepasPayment":
        List<String> dataArray = recvCovertedData.split('1C');
        String approvalCode = dataArray[2].substring(6,dataArray[2].length).toString();
        if(approvalCode=="303030303030")
        {
          stopTimer();
          stopTimeoutTimer();
          Fluttertoast.showToast(msg: "Transaction successfull. Approval Code = " + approvalCode);
        }
        else
        {
          Fluttertoast.showToast(msg: "Transaction Failed. Approval Code = " + approvalCode);
        }
        break;
    }
  }

  Timer timeoutTimer;
  void startTimeoutTimer() {
    timeoutTimer = Timer.periodic(Duration(minutes: 2), (Timer t) => handleTimeoutTimer());
  }

  void stopTimeoutTimer() {
    timeoutTimer?.cancel();
  }

  void handleTimeoutTimer() {
      if(timeoutTransaction)
        {
          Fluttertoast.showToast(msg: "Transaction Timeout.");
        }
      stopTimeoutTimer();
  }

  bool noReply = false;
  Timer timer;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => handleTimeout());
  }

  void stopTimer() {
    timer?.cancel();
  }

  void handleTimeout() {
    //Fluttertoast.showToast(msg: "Timer Tick : isTerminalGivenReply : " + isTerminalGivenReply.toString());
    if(isTerminalGivenReply)
    {
      noResponseFromTerminalCount = 0;
      stopTimer();
    }
    else {
      noResponseFromTerminalCount++;
      //Fluttertoast.showToast(msg: "Timer Tick : noResponseFromTerminalCount : " + noResponseFromTerminalCount.toString());

      if(noResponseFromTerminalCount>=3)
      {
        Fluttertoast.showToast(msg: "Error while doing transaction 3.");
        nackCount = 0;
        noResponseFromTerminalCount = 0;
        stopTimer();
      }
      else {
        //Fluttertoast.showToast(msg: "Timer Tick : isPortOpen : " + isPortOpen.toString() + " noResponseFromTerminalCount : " + noResponseFromTerminalCount.toString());

        if (!noReply && isPortOpen && noResponseFromTerminalCount>=0) {
          String data = doTransaction(true);
          //Fluttertoast.showToast(msg: "Data : " + data);
          serialPort.write(Uint8List.fromList(hexToUnits(data)));
        }
      }
    }
  }

  bool checkLRC(String response)
  {
    try {
      String data = response.substring(2,response.length-2);
     // Fluttertoast.showToast(msg: "response " + data);

      String responseLRC = response.substring(response.length-2,response.length);
     // Fluttertoast.showToast(msg: "responseLRC " + responseLRC);
      int checkSumByte = 0x00;

      for (int i = 0; i < data.length; i += 2) {
        checkSumByte ^=
            hexToInt(data.split('')[i] + data.split('')[i + 1]);
      }

      String LRC = gethexstring(checkSumByte);

      Fluttertoast.showToast(msg: "Current LRC : " + responseLRC + " Calculated LRC : " + LRC);

      if(responseLRC == LRC)
      {
        return true;
      }
      return false;
    }
    catch(ex)
    {
      Fluttertoast.showToast(msg: "Error from LRC check. " + ex);
    }
  }

  String firstConnection()  {
    try {
      String STX = "02";

      String dataToSend = "";
      dataToSend += "0018";
      dataToSend += gethexOfstring(getUniqueNumber().toString());
      dataToSend += "3535";
      dataToSend += "3031";
      dataToSend += "30";
      dataToSend += "1C";
      dataToSend += "03"; //ETX

      int checkSumByte = 0x00;

      for (int i = 0; i < dataToSend.length; i += 2) {
        checkSumByte ^= hexToInt(dataToSend.split('')[i]+dataToSend.split('')[i+1]);
      }
      dataToSend += gethexstring(checkSumByte);
      return STX+dataToSend;

    } catch (ex) {
      Fluttertoast.showToast(msg: "error $ex");
    }
  }

  String previousNetsPayment="";

  String NetsPayment(bool resession)  {
    if(resession)
    {
      return previousNetsPayment;
    }

    try {
      previousNetsPayment="";
      String STX = "02";
      String dataToSend = "0048";
      dataToSend += gethexOfstring(getUniqueNumber().toString());
      dataToSend += "3330";
      dataToSend += "3031";
      dataToSend += "30";
      dataToSend += "1C";

      dataToSend += "5432000230311C34330001301C";
      dataToSend += gethexOfstring("40");
      String totalPrice = (CartPageState.reqCreateOrder.price * 10).toString().replaceAll('.', '');
      if(totalPrice.length<12)
      {
        int requireZero = 12-totalPrice.length;
        for(int i=0;i<requireZero;i++)
        {
          totalPrice = "0"+totalPrice;
        }
      }

      String msgData2 = gethexOfstring(totalPrice);
      dataToSend += "0012";
      dataToSend += msgData2;
      dataToSend += "1C";
      dataToSend += "03"; //ETX

      int checkSumByte = 0x00;

      for (int i = 0; i < dataToSend.length; i += 2) {
        checkSumByte ^= hexToInt(dataToSend.split('')[i]+dataToSend.split('')[i+1]);
      }
      dataToSend += gethexstring(checkSumByte);

      previousNetsPayment = STX + dataToSend;
      return previousNetsPayment;

    } catch (ex) {
      Fluttertoast.showToast(msg: "Error $ex");
    }
  }

  String previousCCPayment="";

  String CreditCardPayment(bool resession)  {
    if(resession)
    {
      return previousCCPayment;
    }

    try {
      previousCCPayment="";
      String STX = "02";
      String dataToSend = "0064";
      dataToSend += gethexOfstring(getUniqueNumber().toString());
      dataToSend += "4930";
      dataToSend += "3031";
      dataToSend += "30";
      dataToSend += "1C";

      dataToSend += gethexOfstring("40");
      String totalPrice = (CartPageState.reqCreateOrder.price * 10).toString().replaceAll('.', '');
      if(totalPrice.length<12)
      {
        int requireZero = 12-totalPrice.length;
        for(int i=0;i<requireZero;i++)
        {
          totalPrice = "0"+totalPrice;
        }
      }

      String msgData2 = gethexOfstring(totalPrice);
      dataToSend += "0012";
      dataToSend += msgData2;
      dataToSend += "1C";

      //Acquirer Name
      dataToSend += "394700064442532020201C";

      //Enhanced ECR
      //Reference Number
      dataToSend += "48440013313233343536373839303132331C";

      dataToSend += "03"; //ETX

      int checkSumByte = 0x00;

      for (int i = 0; i < dataToSend.length; i += 2) {
        checkSumByte ^= hexToInt(dataToSend.split('')[i]+dataToSend.split('')[i+1]);
      }
      dataToSend += gethexstring(checkSumByte);

      previousCCPayment = STX + dataToSend;
      return previousCCPayment;

    } catch (ex) {
      Fluttertoast.showToast(msg: "Error $ex");
    }
  }


  String previousCepasPayment="";

  String CepasPayment(bool resession)  {
    if(resession)
    {
      return previousCepasPayment;
    }

    try {
      previousCepasPayment="";
      String STX = "02";
      String dataToSend = "0053";
      dataToSend += gethexOfstring(getUniqueNumber().toString());
      dataToSend += "3236";
      dataToSend += "3031";
      dataToSend += "30";
      dataToSend += "1C";

      dataToSend += gethexOfstring("40");
      String totalPrice = (CartPageState.reqCreateOrder.price * 10).toString().replaceAll('.', '');
      if(totalPrice.length<12)
      {
        int requireZero = 12-totalPrice.length;
        for(int i=0;i<requireZero;i++)
        {
          totalPrice = "0"+totalPrice;
        }
      }

      String msgData2 = gethexOfstring(totalPrice);
      dataToSend += "0012";
      dataToSend += msgData2;
      dataToSend += "1C";

      //Enhanced ECR
      //Reference Number
      dataToSend += "48440013313233343536373839303132331C";

      dataToSend += "03"; //ETX

      int checkSumByte = 0x00;

      for (int i = 0; i < dataToSend.length; i += 2) {
        checkSumByte ^= hexToInt(dataToSend.split('')[i]+dataToSend.split('')[i+1]);
      }
      dataToSend += gethexstring(checkSumByte);

      previousCCPayment = STX + dataToSend;
      return previousCCPayment;

    } catch (ex) {
      Fluttertoast.showToast(msg: "Error $ex");
    }
  }

  String currentPaymentMode = "NetsPayment";
  String doTransaction(bool resession)
  {
    switch(currentPaymentMode)
    {
      case "NetsPayment":
        return NetsPayment(resession);
      case "CreditCardPayment":
        return CreditCardPayment(resession);
      case "CepasPayment":
        return CepasPayment(resession);
    }
  }

  int getUniqueNumber() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i <= 11; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }

    return int.parse(rndnumber);
  }

  String convertStringFromUint8List(Uint8List bytes) {
    StringBuffer buffer = new StringBuffer();
    for (int i = 0; i < bytes.length;) {
      int firstWord = (bytes[i] << 8) + bytes[i + 1];
      if (0xD800 <= firstWord && firstWord <= 0xDBFF) {
        int secondWord = (bytes[i + 2] << 8) + bytes[i + 3];
        buffer.writeCharCode(
            ((firstWord - 0xD800) << 10) + (secondWord - 0xDC00) + 0x10000);
        i += 4;
      } else {
        buffer.writeCharCode(firstWord);
        i += 2;
      }
    }
    return buffer.toString();
  }

  Uint8List getData(String str, int byteLength) {
    Uint8List returnData = new Uint8List(byteLength);

    Uint8List stringByteData = convertStringToUint8List(str);
    int j = 0;
    for (int i = returnData.length - 1; i >= 0; i--) {
      if (stringByteData.length < j) {
        returnData[i] = stringByteData[j];
        j++;
      } else {
        returnData[i] = 0x0;
      }
    }
    return returnData;
  }

  List<int> addToList(List<int> list, Uint8List value) {
    for (int i = 0; i < value.length; i++) list.add(value[i]);
    return list;
  }

  Uint8List convertStringToUint8List(String source) {
    var list = new List<int>();
    source.runes.forEach((rune) {
      if (rune >= 0x10000) {
        rune -= 0x10000;
        int firstWord = (rune >> 10) + 0xD800;
        list.add(firstWord >> 8);
        list.add(firstWord & 0xFF);
        int secondWord = (rune & 0x3FF) + 0xDC00;
        list.add(secondWord >> 8);
        list.add(secondWord & 0xFF);
      } else {
        list.add(rune >> 8);
        list.add(rune & 0xFF);
      }
    });

    return Uint8List.fromList(list);
  }

  String formatReceivedData(recv) {
    return recv
        .map((List<int> char) => char.map((c) => intToHexOut(c)).join())
        .join();
  }

  String gethexstring(int sendStr) {
    return intToHexOut(sendStr); //to get hex string
  }

  String gethexOfstring(String sendStr) {
    String str = "";
    for(int i=0;i<sendStr.split('').length;i++)
    {
      str = str + intToHex(sendStr.codeUnitAt(i));
    }
    return str;
  }

  String gethexOfstring1(String sendStr) {
    String str = "";
    for(int i=0;i<sendStr.split('').length;i++)
    {
      str = str + intToHex(sendStr.codeUnitAt(i));
    }
    return str;
  }

  List<int> hexToUnits(String hexStr, {int combine = 2}) {
    hexStr = hexStr.replaceAll(" ", "");
    List<int> hexUnits = [];
    for (int i = 0; i < hexStr.length; i += combine) {
      hexUnits.add(hexToInt(hexStr.substring(i, i + combine)));
    }
    return hexUnits;
  }

  int hexToInt(String hex) {
    return int.parse(hex, radix: 16);
  }

  String conertHexDecimal(String str1) {
    final fullString = str1;
    int number = 0;
    for (int i = 0; i <= fullString.length - 8; i += 8) {
      final hex = fullString.substring(i, i + 8);

      number = int.parse(hex, radix: 16);
      print(number);
    }
    return number.toString();
  }

  String intToHexOut(int i) {
    String outValue = i.toRadixString(16).toUpperCase();
    if(outValue.length<2)
    {
      outValue = "0"+outValue;
    }
    return outValue;
  }

  String intToHex(int i) {
    return i.toRadixString(16).toUpperCase();
  }
//
//  Future<void> requestWritePermission() async {
//
//    PermissionStatus permissionStatus = await  SimplePermissions.requestPermission(Permission.WriteExternalStorage);
//
//    if (permissionStatus == PermissionStatus.authorized) {
//      setState(() {
//        _allowWriteFile = true;
//      });
//
//
//    }
//
//
//  }

//
//  Future get _localPath async {
//    // Application documents directory: /data/user/0/{package_name}/{app_name}
//    final applicationDirectory = await getApplicationDocumentsDirectory();
//
//    // External storage directory: /storage/emulated/0
//    final externalDirectory = await getExternalStorageDirectory();
//
//    // Application temporary directory: /data/user/0/{package_name}/cache
//    final tempDirectory = await getTemporaryDirectory();
//
//    return applicationDirectory.path;
//  }
//
//  Future get _localFile async {
//    final path = await _localPath;
//
//    return File('$path/file-name.txt');
//  }
}



//---------------------------------------------




//---------------------------------------------
*/
