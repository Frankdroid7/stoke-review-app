import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stoke_reviews_app/appwide_custom_widgets/action_button.dart';
import 'package:stoke_reviews_app/appwide_custom_widgets/app_scaffold.dart';
import 'package:stoke_reviews_app/appwide_custom_widgets/custom_textfield.dart';
import 'package:stoke_reviews_app/features/ranked_places/domain/places_model.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/app_constants.dart';
import 'custom_widgets/review_list_tile.dart';

class ReviewPage extends StatefulWidget {
  final PlacesModel placesModel;
  const ReviewPage({Key? key, required this.placesModel}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://thumbs.gfycat.com/AccurateFemaleJavalina.webp');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool showPostReviewWidget = false;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Review page'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 400, child: VideoPlayer(_controller)),
          TextButton(
            onPressed: () {
              _controller.pause();
            },
            child: Text('PAUSE'),
          ),
          Hero(
            tag: 'placeImg',
            child: Image.network(
              (widget.placesModel.imageUrl == null ||
                      widget.placesModel.imageUrl!.isEmpty)
                  ? stokeOnTrentPlaceHolderImage
                  : widget.placesModel.imageUrl!,
              height: 140,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, _, __) {
                return Image.network(
                  stokeOnTrentPlaceHolderImage,
                  height: 140,
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Hero(
            tag: 'placesText',
            child: Text(
              widget.placesModel.placeName ?? '',
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 2),
          InkWell(
            onTap: () {
              setState(() {
                showPostReviewWidget = !showPostReviewWidget;
              });
            },
            child: const Text(
              'Post review',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
          Visibility(
            visible: showPostReviewWidget,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RatingBar.builder(
                  minRating: 1,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                CustomTextField(
                  maxLines: 5,
                  hintText: '\nWrite your review...',
                ),
                ActionButton(onPressed: () {}, title: 'Post Review'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Reviews',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
                itemCount: widget.placesModel.reviewDtos.length,
                itemBuilder: (context, index) {
                  return ReviewListTile(
                    placesModel: widget.placesModel,
                    reviewData: widget.placesModel.reviewDtos[index],
                  );
                }),
          ),
          // PDFView(
          //   filePath: path,
          //   enableSwipe: true,
          //   swipeHorizontal: true,
          //   autoSpacing: false,
          //   pageFling: false,
          //   onRender: (_pages) {
          //     setState(() {
          //       pages = _pages;
          //       isReady = true;
          //     });
          //   },
          //   onError: (error) {
          //     print(error.toString());
          //   },
          //   onPageError: (page, error) {
          //     print('$page: ${error.toString()}');
          //   },
          //   onViewCreated: (PDFViewController pdfViewController) {
          //     _controller.complete(pdfViewController);
          //   },
          //   onPageChanged: (int page, int total) {
          //     print('page change: $page/$total');
          //   },
          // ),
          TextButton(
            onPressed: () {
              getData();
            },
            child: Text('Get Data'),
          ),
        ],
      ),
    );
  }
}

getData() async {
  String url = "https://store_dev.smerp.io/smerp/api/sales/receipt";
  var dio = Dio();

  Response response = await dio.post(
    url,
    data: {
      "params": {
        "token": "5b7ed0fc0a1c47afb84f7c04aa1cccfd",
        "sale_order_id": 142
      }
    },
  );

  print('GET DATA -> ${response.data['result']['report_url']}');
  loadPdfFromNetwork(response.data['result']['report_url']);
}

Future<File> loadPdfFromNetwork(String url) async {
  final response = await Dio().get(url);
  String bytes = response.data;
  print('BODY BYTES FROM URL -> $bytes');

  return _storeFile(url, Uint8List.fromList(bytes.codeUnits));
}

Future<File> _storeFile(String url, List<int> bytes) async {
  const filename = 'MyReciept';
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$filename.pdf');
  await file.writeAsBytes(bytes, flush: false);
  Share.shareXFiles([XFile(file.path)], text: 'Great picture');
  return file;
}
