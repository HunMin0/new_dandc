class InputImage extends StatefulWidget {
  List<ImagePickerItem> imageList;
  bool isAddable = true;
  bool isOnlyImage = true;

  const InputImage({super.key});

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
