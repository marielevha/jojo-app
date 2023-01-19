import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jojo/models/delivery/delivery.dart';
import 'package:jojo/pages/widgets/display.dart';
import 'package:jojo/services/api/delivery.api.dart';
import 'package:jojo/services/delivery/delivery-view-model.dart';
import 'package:jojo/utils/global.colors.dart';
import 'package:jojo/utils/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:jojo/utils/functions.dart';


class MesCourses extends StatefulWidget {
  const MesCourses({super.key});

  @override
  State<MesCourses> createState() => _MesCoursesState();
}

class _MesCoursesState extends State<MesCourses> {

  final ScrollController _scrollController = ScrollController();
  final ScrollController __scrollController = ScrollController();
  final DeliveryApi deliveryApi = locator<DeliveryApi>();
  late bool isLoading = false;
  late int currentPage = 1;
  final DeliveryViewModel _viewModel = DeliveryViewModel();
  late List<Delivery> _deliveries = [];

  @override
  void initState() {
    super.initState();
    loadDeliveries(currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !isLoading) {
        currentPage++;
        loadDeliveries(currentPage);
      }
    });
    __scrollController.addListener(() {
      if (__scrollController.position.pixels >= __scrollController.position.maxScrollExtent && !isLoading) {
        currentPage++;
        loadDeliveries(currentPage);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    __scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.bluecolor,
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: Text('Mes courses',style: GoogleFonts.poppins(),)
      ),
      body: RefreshIndicator(
        onRefresh: () {
          loadDeliveries(1);
          Completer<void> completer = Completer<void>();
          Timer timer = Timer(const Duration(seconds: 1), () {
            completer.complete();
          });
          return completer.future;
        },
        child: SingleChildScrollView(
          controller: __scrollController,
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      child: ViewModelBuilder<DeliveryViewModel>.reactive(
                          viewModelBuilder: () => DeliveryViewModel(),
                          onModelReady: (model) => model.findDeliveriesByUserId(page: 1,),
                          builder: (context, model, child) {
                            if(!model.testFindDeliveries && !isLoading) {

                              if(model.deliveriesList.isNotEmpty || _deliveries.isNotEmpty) {
                                return DisplayDoc(
                                  deliveries: _deliveries.isEmpty ? model.deliveriesList.toList() : _deliveries
                                );
                              }
                              else {
                                return Container();
                              }
                            }
                            return Center(child: Image.asset('assets/images/ripple.gif'),);
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadDeliveries(int page) async {
    try {
      isLoading = true;
      await _viewModel.findDeliveriesByUserId(page: page);
      setState(() {
        _deliveries = _viewModel.deliveriesList;
        isLoading = false;
        printWarning("List 1: ${_viewModel.deliveriesList.length}");
      });

      /*_deliveries.forEach((el) {
        printWarning("Delivery: ${el.code}, ${el.departLng}, ${el.destinationLng}, ${el.stopLng}");
      });*/
    }
    catch (_) {
      isLoading = false;
    }
  }
}