import 'package:fixit/ui_screens/auth/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../change_language/choose_language_controller.dart';

class LanguageExpansionTile extends StatefulWidget {
  final List<LanguagePenal> items;
  final List<String> items2;

  const LanguageExpansionTile({Key? key, required this.items, required this.items2}) : super(key: key);

  @override
  LanguageExpansionTileState createState() => LanguageExpansionTileState();
}

class LanguageExpansionTileState extends State<LanguageExpansionTile> {
  ChooseLanguageController controller = Get.put(ChooseLanguageController());
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double containerHeight = _isExpanded ? calculateContainerHeight() : 0;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
            width: 85,
            decoration: BoxDecoration(
              borderRadius:_isExpanded? const BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              ):BorderRadius.circular(5),
              color: const Color(0xffDDDDDD),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                  height: 12,
                  child: SvgPicture.asset(
                    'assets/images/${controller.selectedLanguage.value}.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                 Text(controller.selectedLanguage.value.toUpperCase(), style: TextStyle(color: Colors.black)),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            color: Color(0xffDDDDDD),
          ),
          duration: const Duration(milliseconds: 150),
          height: containerHeight,
          width: 85,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(widget.items.length, (index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                    controller.selectedLanguage.value = widget.items[index].code;
                    Get.updateLocale(Locale(controller.selectedLanguage.value));
                    controller.setLanguage(controller.selectedLanguage.value);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 12,
                          child: SvgPicture.asset(
                            widget.items2[index],
                            fit: BoxFit.fill,
                            placeholderBuilder: (BuildContext context) => Container(
                              padding: const EdgeInsets.all(10.0),
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(widget.items[index].name, style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  double calculateContainerHeight() {
    int numberOfItems = widget.items.length;
    return numberOfItems * 34;
  }
}