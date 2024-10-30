import 'package:gif/gif.dart';
import 'package:scanguard/utils/imports.dart';

class GifScreen extends StatefulWidget {
  const GifScreen({super.key});

  @override
  _GifScreenState createState() => _GifScreenState();
}

class _GifScreenState extends State<GifScreen> with TickerProviderStateMixin {
  late GifController _gifController;

  @override
  void initState() {
    super.initState();
    // Initialize the GifController without specific frame range
    _gifController = GifController(vsync: this);
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Thank You')),
      ),
      body: Column(
        children: [
          'Hey Bella Terima kasih kerana sudi menerima saya sebagai kawan kamu ):'
              .toText(
                  maxLine: 3,
                  textAlign: TextAlign.center,
                  textStyle: MyTextStyles.semiBold()),
          20.heightBox,
          Center(
            child: Gif(
              image: const NetworkImage(
                  "https://media1.tenor.com/m/F1lX2zWAi2EAAAAC/tonton-friends.gif"),
              controller: _gifController,
              autostart: Autostart.loop,
              placeholder: (context) =>
                  const CircularProgressIndicator(), // Shows a loader while fetching
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: GifScreen()));
}
