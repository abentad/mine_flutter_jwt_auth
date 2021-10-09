import 'package:flutter/material.dart';
import 'package:flutter_node_auth/utils/ad_helper.dart';
import 'package:flutter_node_auth/view/ad_stuff/cusom_ad.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class NativeAds extends StatefulWidget {
  const NativeAds({Key? key}) : super(key: key);

  @override
  _NativeAdsState createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds> with AutomaticKeepAliveClientMixin {
  Widget? child;

  final controller = NativeAdController(unitId: AdHelper.nativeAdUnitId);

  @override
  void initState() {
    super.initState();
    // controller.load(keywords: ['valorant', 'games', 'fortnite']);
    controller.load();
    controller.onEvent.listen((event) {
      if (event.keys.first == NativeAdEvent.loaded) {
        printAdDetails(controller);
      }
      setState(() {});
    });
  }

  void printAdDetails(NativeAdController controller) async {
    /// Just for showcasing the ability to access
    /// NativeAd's details via its controller.
    print("------- NATIVE AD DETAILS: -------");
    print(controller.headline);
    print(controller.body);
    print(controller.price);
    print(controller.store);
    print(controller.callToAction);
    print(controller.advertiser);
    print(controller.iconUri);
    print(controller.imagesUri);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (child != null) return child!;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() => child = const SizedBox());
        // await controller.load(force: true);
        await Future.delayed(const Duration(milliseconds: 20));
        setState(() => child = null);
      },
      child: controller.isLoaded
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: NativeAd(
                height: 320,
                unitId: AdHelper.nativeAdUnitId,
                builder: (context, child) => Material(elevation: 0.0, child: child),
                buildLayout: customAdTemplateLayoutBuilder,
                loading: const Center(child: Text('loading ad')),
                error: const Text('error'),
                icon: AdImageView(size: 40),
                headline: AdTextView(style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), maxLines: 1),
                body: AdTextView(style: const TextStyle(color: Colors.black), maxLines: 1),
                media: AdMediaView(height: 170, width: MATCH_PARENT),
                attribution: AdTextView(
                  width: WRAP_CONTENT,
                  text: 'Ad',
                  decoration: AdDecoration(
                    border: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: AdBorderRadius.all(16.0),
                  ),
                  style: const TextStyle(color: Colors.green),
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                ),
                button: AdButtonView(
                  elevation: 18,
                  decoration: AdDecoration(backgroundColor: Colors.blue),
                  height: MATCH_PARENT,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                ratingBar: AdRatingBarView(starsColor: Colors.white),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
