import '../utils/imports.dart';

class CachedImage extends StatelessWidget {
  final String vanueImage;
  final double height;
  final double width;

  const CachedImage({
    super.key,
    required this.vanueImage,
    this.height = 44,
    this.width = 44,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: '$AppUrl$vanueImage',
        height: height.h,
        width: width.w,
        fit: BoxFit.cover, // Ensure the image covers the clip area
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.white12,
          highlightColor: Colors.white,
          child: Image.network(
            "https://www.haliburtonforest.com/wp-content/uploads/2017/08/placeholder-square.jpg",
            fit: BoxFit.cover,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
