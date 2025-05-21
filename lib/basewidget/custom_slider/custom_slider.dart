
// import 'dart:async';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sixvalley_ecommerce/basewidget/custom_slider/utils.dart';
// import 'carousel_controller.dart';
// import 'carousel_options.dart';
// import 'carousel_state.dart';
// typedef ExtendedIndexedWidgetBuilder = Widget Function(BuildContext context, int index, int realIndex);
// class CarouselSlider extends StatefulWidget {
//   final CarouselOptions options;
//   final bool? disableGesture;
//   final List<Widget>? items;
//   final ExtendedIndexedWidgetBuilder? itemBuilder;
//   final CarouselControllerImpl _carouselController;
//   final int? itemCount;
//   CarouselSlider(
//       {required this.items,
//         required this.options,
//         this.disableGesture,
//         CarouselController? carouselController,
//         super.key})
//       : itemBuilder = null,
//         itemCount = items != null ? items.length : 0,
//         _carouselController = carouselController != null
//             ? carouselController as CarouselControllerImpl
//             : CarouselController() as CarouselControllerImpl;

//   /// The on demand item builder constructor
//   CarouselSlider.builder(
//       {required this.itemCount,
//         required this.itemBuilder,
//         required this.options,
//         this.disableGesture,
//         CarouselController? carouselController,
//         super.key})
//       : items = null,
//         _carouselController = carouselController != null
//             ? carouselController as CarouselControllerImpl
//             : CarouselController() as CarouselControllerImpl;

//   @override
//   CarouselSliderState createState() => CarouselSliderState(_carouselController);
// }

// class CarouselSliderState extends State<CarouselSlider> with TickerProviderStateMixin {
//    CarouselControllerImpl carouselController;
//   Timer? timer;

//   CarouselOptions get options => widget.options;

//   CarouselState? carouselState;

//   PageController? pageController;
//   CarouselPageChangedReason mode = CarouselPageChangedReason.controller;

//   CarouselSliderState(this.carouselController);

//   void changeMode(CarouselPageChangedReason mode) {
//     mode = mode;
//   }

//   @override
//   void didUpdateWidget(CarouselSlider oldWidget) {
//     carouselState!.options = options;
//     carouselState!.itemCount = widget.itemCount;

//     // pageController needs to be re-initialized to respond to state changes
//     pageController = PageController(
//       viewportFraction: options.viewportFraction,
//       initialPage: carouselState!.realPage,
//     );
//     carouselState!.pageController = pageController;

//     // handle autoplay when state changes
//     handleAutoPlay();

//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   void initState() {
//     super.initState();
//     carouselState =
//         CarouselState(options, clearTimer, resumeTimer, changeMode);

//     carouselState!.itemCount = widget.itemCount;
//     carouselController.state = carouselState;
//     carouselState!.initialPage = widget.options.initialPage;
//     carouselState!.realPage = options.enableInfiniteScroll
//         ? carouselState!.realPage + carouselState!.initialPage
//         : carouselState!.initialPage;
//     handleAutoPlay();

//     pageController = PageController(
//       viewportFraction: options.viewportFraction,
//       initialPage: carouselState!.realPage,
//     );

//     carouselState!.pageController = pageController;
//   }

//   Timer? getTimer() {
//     return widget.options.autoPlay
//         ? Timer.periodic(widget.options.autoPlayInterval, (_) {
//       if (!mounted) {
//         clearTimer();
//         return;
//       }

//       final route = ModalRoute.of(context);
//       if (route?.isCurrent == false) {
//         return;
//       }

//       CarouselPageChangedReason previousReason = mode;
//       changeMode(CarouselPageChangedReason.timed);
//       int nextPage = carouselState!.pageController!.page!.round() + 1;
//       int itemCount = widget.itemCount ?? widget.items!.length;

//       if (nextPage >= itemCount &&
//           widget.options.enableInfiniteScroll == false) {
//         if (widget.options.pauseAutoPlayInFiniteScroll) {
//           clearTimer();
//           return;
//         }
//         nextPage = 0;
//       }

//       carouselState!.pageController!
//           .animateToPage(nextPage,
//           duration: widget.options.autoPlayAnimationDuration,
//           curve: widget.options.autoPlayCurve)
//           .then((_) => changeMode(previousReason));
//     })
//         : null;
//   }

//   void clearTimer() {
//     if (timer != null) {
//       timer?.cancel();
//       timer = null;
//     }
//   }

//   void resumeTimer() {
//     timer ??= getTimer();
//   }

//   void handleAutoPlay() {
//     bool autoPlayEnabled = widget.options.autoPlay;

//     if (autoPlayEnabled && timer != null) return;

//     clearTimer();
//     if (autoPlayEnabled) {
//       resumeTimer();
//     }
//   }

//   Widget getGestureWrapper(Widget child) {
//     Widget wrapper;
//     if (widget.options.height != null) {
//       wrapper = SizedBox(height: widget.options.height, child: child);
//     } else {
//       wrapper =
//           AspectRatio(aspectRatio: widget.options.aspectRatio, child: child);
//     }

//     if (true == widget.disableGesture) {
//       return NotificationListener(
//         onNotification: (Notification notification) {
//           if (widget.options.onScrolled != null &&
//               notification is ScrollUpdateNotification) {
//             widget.options.onScrolled!(carouselState!.pageController!.page);
//           }
//           return false;
//         },
//         child: wrapper,
//       );
//     }

//     return RawGestureDetector(
//       behavior: HitTestBehavior.opaque,
//       gestures: {
//         _MultipleGestureRecognizer:
//         GestureRecognizerFactoryWithHandlers<_MultipleGestureRecognizer>(
//                 () => _MultipleGestureRecognizer(),
//                 (_MultipleGestureRecognizer instance) {
//               instance.onStart = (_) {
//                 onStart();
//               };
//               instance.onDown = (_) {
//                 onPanDown();
//               };
//               instance.onEnd = (_) {
//                 onPanUp();
//               };
//               instance.onCancel = () {
//                 onPanUp();
//               };
//             }),
//       },
//       child: NotificationListener(
//         onNotification: (Notification notification) {
//           if (widget.options.onScrolled != null &&
//               notification is ScrollUpdateNotification) {
//             widget.options.onScrolled!(carouselState!.pageController!.page);
//           }
//           return false;
//         },
//         child: wrapper,
//       ),
//     );
//   }

//   Widget getCenterWrapper(Widget child) {
//     if (widget.options.disableCenter) {
//       return Container(
//         child: child,
//       );
//     }
//     return Center(child: child);
//   }

//   Widget getEnlargeWrapper(Widget? child,
//       {double? width,
//         double? height,
//         double? scale,
//         required double itemOffset}) {
//     if (widget.options.enlargeStrategy == CenterPageEnlargeStrategy.height) {
//       return SizedBox(width: width, height: height, child: child);
//     }
//     if (widget.options.enlargeStrategy == CenterPageEnlargeStrategy.zoom) {
//       late Alignment alignment;
//       final bool horizontal = options.scrollDirection == Axis.horizontal;
//       if (itemOffset > 0) {
//         alignment = horizontal ? Alignment.centerRight : Alignment.bottomCenter;
//       } else {
//         alignment = horizontal ? Alignment.centerLeft : Alignment.topCenter;
//       }
//       return Transform.scale(scale: scale!, alignment: alignment, child: child);
//     }
//     return Transform.scale(
//         scale: scale!,
//         child: SizedBox(width: width, height: height, child: child));
//   }

//   void onStart() {
//     changeMode(CarouselPageChangedReason.manual);
//   }

//   void onPanDown() {
//     if (widget.options.pauseAutoPlayOnTouch) {
//       clearTimer();
//     }

//     changeMode(CarouselPageChangedReason.manual);
//   }

//   void onPanUp() {
//     if (widget.options.pauseAutoPlayOnTouch) {
//       resumeTimer();
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     clearTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return getGestureWrapper(PageView.builder(
//       padEnds: widget.options.padEnds,
//       scrollBehavior: ScrollConfiguration.of(context).copyWith(
//         scrollbars: false,
//         overscroll: false,
//         dragDevices: {
//           PointerDeviceKind.touch,
//           PointerDeviceKind.mouse,
//         },
//       ),
//       clipBehavior: widget.options.clipBehavior,
//       physics: widget.options.scrollPhysics,

//       scrollDirection: widget.options.scrollDirection,
//       pageSnapping: widget.options.pageSnapping,
//       controller: carouselState!.pageController,
//       reverse: widget.options.reverse,
//       itemCount: widget.options.enableInfiniteScroll ? null : widget.itemCount,
//       key: widget.options.pageViewKey,
//       onPageChanged: (int index) {
//         int currentPage = getRealIndex(index + carouselState!.initialPage,
//             carouselState!.realPage, widget.itemCount);
//         if (widget.options.onPageChanged != null) {
//           widget.options.onPageChanged!(currentPage, mode);
//         }
//       },
//       itemBuilder: (BuildContext context, int idx) {
//         final int index = getRealIndex(idx + carouselState!.initialPage,
//             carouselState!.realPage, widget.itemCount);

//         return AnimatedBuilder(
//           animation: carouselState!.pageController!,
//           child: (widget.items != null)
//               ? (widget.items!.isNotEmpty ? widget.items![index] : Container())
//               : widget.itemBuilder!(context, index, idx),
//           builder: (BuildContext context, child) {
//             double distortionValue = 1.0;
//             // if `enlargeCenterPage` is true, we must calculate the carousel item's height
//             // to display the visual effect
//             double itemOffset = 0;
//             if (widget.options.enlargeCenterPage != null &&
//                 widget.options.enlargeCenterPage == true) {
//               // pageController.page can only be accessed after the first build,
//               // so in the first build we calculate the itemoffset manually
//               var position = carouselState?.pageController?.position;
//               if (position != null &&
//                   position.hasPixels &&
//                   position.hasContentDimensions) {
//                 var page = carouselState?.pageController?.page;
//                 if (page != null) {
//                   itemOffset = page - idx;
//                 }
//               } else {
//                 BuildContext storageContext = carouselState!
//                     .pageController!.position.context.storageContext;
//                 final double? previousSavedPosition =
//                 PageStorage.of(storageContext).readState(storageContext)
//                 as double?;
//                 if (previousSavedPosition != null) {
//                   itemOffset = previousSavedPosition - idx.toDouble();
//                 } else {
//                   itemOffset =
//                       carouselState!.realPage.toDouble() - idx.toDouble();
//                 }
//               }

//               final double enlargeFactor =
//               options.enlargeFactor.clamp(0.0, 1.0);
//               final num distortionRatio =
//               (1 - (itemOffset.abs() * enlargeFactor)).clamp(0.0, 1.0);
//               distortionValue =
//                   Curves.easeOut.transform(distortionRatio as double);
//             }

//             final double height = widget.options.height ??
//                 MediaQuery.of(context).size.width *
//                     (1 / widget.options.aspectRatio);

//             if (widget.options.scrollDirection == Axis.horizontal) {
//               return getCenterWrapper(getEnlargeWrapper(child,
//                   height: distortionValue * height,
//                   scale: distortionValue,
//                   itemOffset: itemOffset));
//             } else {
//               return getCenterWrapper(getEnlargeWrapper(child,
//                   width: distortionValue * MediaQuery.of(context).size.width,
//                   scale: distortionValue,
//                   itemOffset: itemOffset));
//             }
//           },
//         );
//       },
//     ));
//   }
// }

// class _MultipleGestureRecognizer extends PanGestureRecognizer {}


import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_slider/utils.dart';
import 'carousel_controller.dart' as custom_carousel;
import 'carousel_options.dart';
import 'carousel_state.dart';

typedef ExtendedIndexedWidgetBuilder = Widget Function(BuildContext context, int index, int realIndex);

class CarouselSlider extends StatefulWidget {
  final CarouselOptions options;
  final bool? disableGesture;
  final List<Widget>? items;
  final ExtendedIndexedWidgetBuilder? itemBuilder;
  final custom_carousel.CarouselControllerImpl _carouselController;
  final int? itemCount;

  CarouselSlider({
    required this.items,
    required this.options,
    this.disableGesture,
    custom_carousel.CarouselController? carouselController,
    super.key,
  })  : itemBuilder = null,
        itemCount = items?.length ?? 0,
        _carouselController = carouselController as custom_carousel.CarouselControllerImpl? ?? 
            custom_carousel.CarouselControllerImpl();

  CarouselSlider.builder({
    required this.itemCount,
    required this.itemBuilder,
    required this.options,
    this.disableGesture,
    custom_carousel.CarouselController? carouselController,
    super.key,
  })  : items = null,
        _carouselController = carouselController as custom_carousel.CarouselControllerImpl? ?? 
            custom_carousel.CarouselControllerImpl();

  @override
  CarouselSliderState createState() => CarouselSliderState(_carouselController);
}

class CarouselSliderState extends State<CarouselSlider> with TickerProviderStateMixin {
  custom_carousel.CarouselControllerImpl carouselController;
  Timer? timer;
  CarouselPageChangedReason mode = CarouselPageChangedReason.controller;

  CarouselOptions get options => widget.options;
  CarouselState? carouselState;
  PageController? pageController;

  CarouselSliderState(this.carouselController);

  void changeMode(CarouselPageChangedReason newMode) {
    mode = newMode;
  }

  @override
  void didUpdateWidget(CarouselSlider oldWidget) {
    carouselState?.options = options;
    carouselState?.itemCount = widget.itemCount;

    pageController = PageController(
      viewportFraction: options.viewportFraction,
      initialPage: carouselState?.realPage ?? 0,
    );
    carouselState?.pageController = pageController;

    handleAutoPlay();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    carouselState = CarouselState(options, clearTimer, resumeTimer, changeMode);
    carouselState?.itemCount = widget.itemCount;
    carouselController.state = carouselState;
    carouselState?.initialPage = widget.options.initialPage;
    carouselState?.realPage = options.enableInfiniteScroll
        ? (carouselState?.realPage ?? 0) + (carouselState?.initialPage ?? 0)
        : carouselState?.initialPage ?? 0;
    
    handleAutoPlay();

    pageController = PageController(
      viewportFraction: options.viewportFraction,
      initialPage: carouselState?.realPage ?? 0,
    );

    carouselState?.pageController = pageController;
  }

  Timer? getTimer() {
    return widget.options.autoPlay
        ? Timer.periodic(widget.options.autoPlayInterval, (_) {
            if (!mounted) {
              clearTimer();
              return;
            }

            final route = ModalRoute.of(context);
            if (route?.isCurrent == false) {
              return;
            }

            final previousReason = mode;
            changeMode(CarouselPageChangedReason.timed);
            final nextPage = (carouselState?.pageController?.page?.round() ?? 0) + 1;
            final itemCount = widget.itemCount ?? widget.items?.length ?? 0;

            if (nextPage >= itemCount && !widget.options.enableInfiniteScroll) {
              if (widget.options.pauseAutoPlayInFiniteScroll) {
                clearTimer();
                return;
              }
              carouselState?.pageController?.animateToPage(
                0,
                duration: widget.options.autoPlayAnimationDuration,
                curve: widget.options.autoPlayCurve,
              ).then((_) => changeMode(previousReason));
              return;
            }

            carouselState?.pageController?.animateToPage(
              nextPage,
              duration: widget.options.autoPlayAnimationDuration,
              curve: widget.options.autoPlayCurve,
            ).then((_) => changeMode(previousReason));
          })
        : null;
  }

  void clearTimer() {
    timer?.cancel();
    timer = null;
  }

  void resumeTimer() {
    timer ??= getTimer();
  }

  void handleAutoPlay() {
    if (!widget.options.autoPlay || timer != null) return;
    clearTimer();
    resumeTimer();
  }

  Widget getGestureWrapper(Widget child) {
    Widget wrapper = widget.options.height != null
        ? SizedBox(height: widget.options.height, child: child)
        : AspectRatio(aspectRatio: widget.options.aspectRatio, child: child);

    if (widget.disableGesture == true) {
      return NotificationListener(
        onNotification: (Notification notification) {
          if (widget.options.onScrolled != null && notification is ScrollUpdateNotification) {
            widget.options.onScrolled!(carouselState?.pageController?.page);
          }
          return false;
        },
        child: wrapper,
      );
    }

    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        _MultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<_MultipleGestureRecognizer>(
          () => _MultipleGestureRecognizer(),
          (_MultipleGestureRecognizer instance) {
            instance.onStart = (_) => onStart();
            instance.onDown = (_) => onPanDown();
            instance.onEnd = (_) => onPanUp();
            instance.onCancel = () => onPanUp();
          },
        ),
      },
      child: NotificationListener(
        onNotification: (Notification notification) {
          if (widget.options.onScrolled != null && notification is ScrollUpdateNotification) {
            widget.options.onScrolled!(carouselState?.pageController?.page);
          }
          return false;
        },
        child: wrapper,
      ),
    );
  }

  Widget getCenterWrapper(Widget child) {
    return widget.options.disableCenter
        ? Container(child: child)
        : Center(child: child);
  }

  Widget getEnlargeWrapper(Widget? child, {
    double? width,
    double? height,
    double? scale,
    required double itemOffset,
  }) {
    switch (widget.options.enlargeStrategy) {
      case CenterPageEnlargeStrategy.height:
        return SizedBox(width: width, height: height, child: child);
      case CenterPageEnlargeStrategy.zoom:
        final alignment = itemOffset > 0
            ? (options.scrollDirection == Axis.horizontal 
                ? Alignment.centerRight 
                : Alignment.bottomCenter)
            : (options.scrollDirection == Axis.horizontal 
                ? Alignment.centerLeft 
                : Alignment.topCenter);
        return Transform.scale(scale: scale!, alignment: alignment, child: child);
      default:
        return Transform.scale(
          scale: scale!,
          child: SizedBox(width: width, height: height, child: child),
        );
    }
  }

  void onStart() {
    changeMode(CarouselPageChangedReason.manual);
  }

  void onPanDown() {
    if (widget.options.pauseAutoPlayOnTouch) {
      clearTimer();
    }
    changeMode(CarouselPageChangedReason.manual);
  }

  void onPanUp() {
    if (widget.options.pauseAutoPlayOnTouch) {
      resumeTimer();
    }
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getGestureWrapper(
      PageView.builder(
        padEnds: widget.options.padEnds,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        clipBehavior: widget.options.clipBehavior,
        physics: widget.options.scrollPhysics,
        scrollDirection: widget.options.scrollDirection,
        pageSnapping: widget.options.pageSnapping,
        controller: carouselState?.pageController,
        reverse: widget.options.reverse,
        itemCount: widget.options.enableInfiniteScroll ? null : widget.itemCount,
        key: widget.options.pageViewKey,
        onPageChanged: (int index) {
          final currentPage = getRealIndex(
            index + (carouselState?.initialPage ?? 0),
            carouselState?.realPage ?? 0,
            widget.itemCount,
          );
          widget.options.onPageChanged?.call(currentPage, mode);
        },
        itemBuilder: (BuildContext context, int idx) {
          final index = getRealIndex(
            idx + (carouselState?.initialPage ?? 0),
            carouselState?.realPage ?? 0,
            widget.itemCount,
          );

          return AnimatedBuilder(
            animation: carouselState?.pageController ?? PageController(),
            child: widget.items != null
                ? (widget.items!.isNotEmpty ? widget.items![index] : Container())
                : widget.itemBuilder?.call(context, index, idx) ?? Container(),
            builder: (BuildContext context, Widget? child) {
              double distortionValue = 1.0;
              double itemOffset = 0;

              if (widget.options.enlargeCenterPage == true) {
                final position = carouselState?.pageController?.position;
                if (position != null && position.hasPixels && position.hasContentDimensions) {
                  itemOffset = (carouselState?.pageController?.page ?? 0) - idx;
                } else {
                  final storageContext = carouselState?.pageController?.position.context.storageContext;
                  if (storageContext != null) {
                    final previousSavedPosition = PageStorage.of(storageContext).readState(storageContext) as double?;
                    itemOffset = previousSavedPosition ?? (carouselState?.realPage ?? 0).toDouble() - idx.toDouble();
                  }
                }

                final enlargeFactor = options.enlargeFactor.clamp(0.0, 1.0);
                final distortionRatio = (1 - (itemOffset.abs() * enlargeFactor)).clamp(0.0, 1.0);
                distortionValue = Curves.easeOut.transform(distortionRatio);
              }

              final height = widget.options.height ?? 
                  MediaQuery.of(context).size.width * (1 / widget.options.aspectRatio);

              return widget.options.scrollDirection == Axis.horizontal
                  ? getCenterWrapper(getEnlargeWrapper(
                      child,
                      height: distortionValue * height,
                      scale: distortionValue,
                      itemOffset: itemOffset,
                    ))
                  : getCenterWrapper(getEnlargeWrapper(
                      child,
                      width: distortionValue * MediaQuery.of(context).size.width,
                      scale: distortionValue,
                      itemOffset: itemOffset,
                    ));
            },
          );
        },
      ),
    );
  }
}

class _MultipleGestureRecognizer extends PanGestureRecognizer {}