import 'package:Deal_Connect/model/user_business_service.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ListServiceCard extends StatelessWidget {
  UserBusinessService item;
  String storeName;

  ListServiceCard({required this.storeName, required this.item, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider serviceImage;

    if (item != null && item!.has_image != null) {
      serviceImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(item!.has_image!),
      );
    } else {
      serviceImage = AssetImage('assets/images/no-image.png');
    }

    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/business/service/info',
              arguments: { 'businessServiceId': item.id, 'storeName': storeName});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: serviceImage,
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
