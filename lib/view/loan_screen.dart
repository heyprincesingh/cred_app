import 'package:cred_stack/utils/circular_range.dart';
import 'package:cred_stack/utils/curreny_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/loan_screen_controller.dart';
import '../utils/scroll_tab.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoanScreenController _controller = Get.put(LoanScreenController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (_controller.activeTab.value > 0) {
          _controller.activeTab.value--;
          return;
        } else {
          Get.back();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff0f131b),
          body: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xff1b1e26),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xff1b1e26),
                        child: Icon(
                          Icons.question_mark_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return _controller.isDataLoaded.value == true
                      ? Container(
                          color: Colors.transparent,
                          height: MediaQuery.sizeOf(context).height - 160,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomCenter,
                            children: [
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 300),
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    if (_controller.activeTab.value != 0) {
                                      _controller.activeTab.value = 0;
                                    }
                                  },
                                  child: scrollTab(
                                    boxColor: _controller.activeTab.value == 0 ? const Color(0xff3e1f4e) : Color.alphaBlend(Colors.black.withOpacity(0.3), const Color(0xff3e1f4e)),
                                    isActive: _controller.activeTab.value == 0,
                                    height: 680,
                                    width: MediaQuery.sizeOf(context).width,
                                    activeTitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: MediaQuery.sizeOf(context).width - 100,
                                          child: Text(
                                            _controller.loanData.items![0].openState!.body!.title!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: MediaQuery.sizeOf(context).width - 100,
                                          child: Text(
                                            _controller.loanData.items![0].openState!.body!.subtitle!,
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    inactiveTitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: MediaQuery.sizeOf(context).width - 100,
                                          child: Text(
                                            _controller.loanData.items![0].closedState!.body!.key1!,
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: MediaQuery.sizeOf(context).width - 100,
                                          child: Text(
                                            _controller.loanAmount,
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    cta_text: _controller.loanData.items![0].ctaText!,
                                    centerWidget: Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
                                      child: Container(
                                        height: MediaQuery.sizeOf(context).width - 30,
                                        width: MediaQuery.sizeOf(context).width - 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircularRangeSlider(
                                              header: _controller.loanData.items![0].openState!.body!.card!.header!,
                                              description: _controller.loanData.items![0].openState!.body!.card!.description!,
                                              maxRange: _controller.loanData.items![0].openState!.body!.card!.maxRange!.toDouble(),
                                              minRange: _controller.loanData.items![0].openState!.body!.card!.minRange!.toDouble(),
                                              initialValue: _controller.loanData.items![0].openState!.body!.card!.minRange!.toDouble(),
                                              onChange: (newValue) {
                                                _controller.loanAmount = convertCurrencyIntoString(newValue.toStringAsFixed(0));
                                              },
                                            ),
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context).width / 1.5,
                                              child: Text(
                                                _controller.loanData.items![0].openState!.body!.footer!,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      _controller.activeTab.value = 1;
                                    },
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 300),
                                bottom: _controller.activeTab.value >= 1 ? 0 : -750,
                                child: GestureDetector(
                                  onTap: () {
                                    if (_controller.activeTab.value != 1) {
                                      _controller.activeTab.value = 1;
                                    }
                                  },
                                  child: scrollTab(
                                    boxColor: _controller.activeTab.value == 1 ? const Color(0xff4c1a72) : Color.alphaBlend(Colors.black.withOpacity(0.3), const Color(0xff4c1a72)),
                                    isActive: _controller.activeTab.value == 1,
                                    height: 560,
                                    width: MediaQuery.sizeOf(context).width,
                                    activeTitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: MediaQuery.sizeOf(context).width - 100,
                                          child: Text(
                                            _controller.loanData.items![1].openState!.body!.title!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: MediaQuery.sizeOf(context).width - 100,
                                          child: Text(
                                            _controller.loanData.items![1].openState!.body!.subtitle!,
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    inactiveTitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: MediaQuery.sizeOf(context).width / 3,
                                              child: Text(
                                                _controller.loanData.items![1].closedState!.body!.key1!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: MediaQuery.sizeOf(context).width / 3,
                                              child: Text(
                                                "Rs4,500 /mo",
                                                style: TextStyle(
                                                  color: Colors.white38,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: MediaQuery.sizeOf(context).width / 3,
                                              child: Text(
                                                _controller.loanData.items![1].closedState!.body!.key2!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: MediaQuery.sizeOf(context).width / 3,
                                              child: Text(
                                                "12 months",
                                                style: TextStyle(
                                                  color: Colors.white38,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    cta_text: _controller.loanData.items![1].ctaText!,
                                    centerWidget: Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 240,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _controller.loanData.items![1].openState!.body!.items!.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 20, 15, 20),
                                                  child: Container(
                                                    height: 200,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff5a5156),
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(20),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  border: Border.all(
                                                                    color: Colors.white70,
                                                                    width: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                              Spacer(
                                                                flex: 1,
                                                              ),
                                                              Text(
                                                                _controller.loanData.items![1].openState!.body!.items![index].tag ?? "",
                                                                style: TextStyle(color: Colors.white70),
                                                              ),
                                                              Spacer(
                                                                flex: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            _controller.loanData.items![1].openState!.body!.items![index].title!,
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            _controller.loanData.items![1].openState!.body!.items![index].subtitle!,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white54,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: 45,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white70,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(30)),
                                            child: Center(
                                              child: Text(
                                                _controller.loanData.items![1].openState!.body!.footer!,
                                                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      _controller.activeTab.value = 2;
                                    },
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 300),
                                bottom: _controller.activeTab.value >= 2 ? 0 : -750,
                                child: GestureDetector(
                                  onTap: () {
                                    if (_controller.activeTab.value != 2) {
                                      _controller.activeTab.value = 2;
                                    }
                                  },
                                  child: scrollTab(
                                    boxColor: _controller.activeTab.value == 2 ? const Color(0xff7c26bd) : Color.alphaBlend(Colors.black.withOpacity(0.3), const Color(0xff7c26bd)),
                                    isActive: _controller.activeTab.value == 2,
                                    height: 440,
                                    width: MediaQuery.sizeOf(context).width,
                                    activeTitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: MediaQuery.sizeOf(context).width - 100,
                                          child: Text(
                                            _controller.loanData.items![2].openState!.body!.title!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: MediaQuery.sizeOf(context).width - 100,
                                          child: Text(
                                            _controller.loanData.items![2].openState!.body!.subtitle!,
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    cta_text: _controller.loanData.items![2].ctaText!,
                                    centerWidget: Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
                                      child: SizedBox(
                                        height: 170,
                                        width: MediaQuery.sizeOf(context).width - 60,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12),
                                                    child: Image(
                                                      image: NetworkImage(
                                                        "https://companieslogo.com/img/orig/HDB-bb6241fe.png?t=1720244492",
                                                      ),
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        _controller.loanData.items![2].openState!.body!.items![0].title!,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        _controller.loanData.items![2].openState!.body!.items![0].subtitle!.toString(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white54,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.check_circle_rounded,
                                                  color: Colors.grey,
                                                  size: 28,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: 45,
                                              width: 160,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white70,
                                                    width: 2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(30)),
                                              child: Center(
                                                child: Text(
                                                  _controller.loanData.items![2].openState!.body!.footer!,
                                                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height - 300,
                            width: 100,
                            child: Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
