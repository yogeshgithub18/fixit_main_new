import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/bottomSubPages/notifications.dart';
class NewAppHeader extends StatefulWidget {
  final bool showBackIcon;
  final bool? isBackIcon;
  final String title;

  const NewAppHeader({Key? key, required this.showBackIcon,required this.title,this.isBackIcon=false}) : super(key: key);

  @override
  State<NewAppHeader> createState() => _NewAppHeaderState();
}

class _NewAppHeaderState extends State<NewAppHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.primaryColor,
      title: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: addText(widget.title,
            getHeadingTextFontSIze()+3,
            ColorConstants.headerTextDark,FontWeight.w600,fontFamily: 'Aeonik',letterSpacing: 1),
      ),
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
      actions:  [
        GestureDetector(
          onTap: (){
            Get.to(()=>Notifications());
          },
          child: Padding(
            padding: const EdgeInsets.only(right:16,left: 16),
            child: SizedBox(
                height: 25,
                width: 18,
                child: SvgPicture.asset('assets/images/noti.svg',fit: BoxFit.fill,)),
          ),
        )
      ],
      leading: widget.showBackIcon
          ? Center(
          child: IconButton(
            icon: Icon(widget.isBackIcon!?Icons.close_sharp:Icons.arrow_back_rounded, color:ColorConstants.headerTextDark,size: getLargeTextFontSIze() * 1,),
            onPressed: () => Navigator.of(context).pop(true),
          ))
          : const SizedBox.shrink(),
    );
  }
}
