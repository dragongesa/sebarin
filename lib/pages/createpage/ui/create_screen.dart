import 'package:animations/animations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_quill/models/documents/attribute.dart';
import 'package:flutter_quill/widgets/default_styles.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:get/get.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';
import 'package:sebarin/pages/createpage/controller/create_controller.dart';
import 'package:sebarin/pages/createpage/entities/models/categories_model.dart';
import 'package:sebarin/shared/widget/navbar.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:tuple/tuple.dart';

class CreateScreen extends GetView<CreateController> {
  @override
  Widget build(BuildContext context) {
    if (controller.editorController == null) {
      return const Scaffold(body: Center(child: Text('Loading...')));
    }

    return WillPopScope(
      onWillPop: () async {
        if (controller.currentIndex.value == 1) {
          controller.currentIndex.value = 0;
          return false;
        }
        Get.dialog(
          AlertDialog(
            content:
                Text("Gamau dipublish? Berarti bakalan ilang nih eventnya"),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Get.back(closeOverlays: true);
                  },
                  child: Text("Iya, Gapapa")),
              ElevatedButton(
                  style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
                  onPressed: () => Get.back(),
                  child: Text("Balik")),
            ],
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Obx(
            () => NavBar(
              leading: controller.currentIndex.value == 1
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => controller.currentIndex.value = 0,
                    )
                  : null,
              title: "Buat Event",
              actions: [
                Obx(
                  () => IconButton(
                      icon: controller.isConnecting.value
                          ? CupertinoActivityIndicator()
                          : Icon(Feather.check),
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        // Get.toNamed('/create/test');
                        if (controller.currentIndex.value == 0)
                          controller.currentIndex.value = 1;
                        else {
                          if (controller.isConnecting.value == false)
                            controller.prepareUpload();
                        }
                      }),
                )
              ],
            ),
          ),
        ),
        body: Obx(
          () => PageTransitionSwitcher(
            duration: 200.milliseconds,
            reverse: controller.currentIndex.value ==
                0, // uncomment to see transition in reverse
            transitionBuilder: (
              Widget child,
              Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: IndexedStack(
              key: ValueKey<int>(controller.currentIndex.value),
              index: controller.currentIndex.value,
              children: [
                ProvideDetails(),
                ProvideThumbTime(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProvideThumbTime extends GetWidget<CreateController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: GetBuilder<CreateController>(
                      id: 'poster',
                      builder: (controller) {
                        if (controller.poster?.path != null)
                          return Center(
                            child: Stack(
                              children: [
                                Image.memory(
                                  controller.poster!.bytes!,
                                  fit: BoxFit.contain,
                                  height: 192,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Tooltip(
                                    message: "Hapus Poster",
                                    child: Container(
                                      color: Colors.red,
                                      child: IconButton(
                                        icon: Icon(
                                          Feather.x,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            controller.deletePoster(),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        return GestureDetector(
                          onTap: () => controller.pickPoster(),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8),
                            dashPattern: [8, 5],
                            strokeCap: StrokeCap.round,
                            color: Colors.grey,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        AntDesign.picture,
                                        size: 64,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () => controller.getJadwal(),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color:
                            Get.isDarkMode ? DarkTheme.dpLayer24 : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        // boxShadow: [
                        //   BoxShadow(
                        //       spreadRadius: -10,
                        //       color: Get.isDarkMode ? Colors.black : Colors.grey,
                        //       blurRadius: 15,
                        //       offset: Offset(0, 15))
                        // ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Obx(() => Column(
                              children: [
                                Container(
                                  color: Get.isDarkMode
                                      ? DarkTheme.dpLayer12
                                      : Colors.white,
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "Dilaksanakan pada".toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 90,
                                    child: Divider(
                                      height: 1,
                                      thickness: 2,
                                    )),
                                if (controller.formattedDate.length == 4)
                                  Column(
                                    children: [
                                      Text(
                                        "${controller.formattedDate[0]}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "${controller.formattedDate[1]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 64,
                                        ),
                                      ),
                                      Text(
                                        "${controller.formattedDate[2]} ${controller.formattedDate[3]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text("pukul: " +
                                          controller.formattedTime.value),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )
                                else
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 30),
                                    child: Text(
                                      "Klik Disini",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              ],
                            )),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Obx(
              () => DropdownSearch<Category>(
                emptyBuilder: (context, searchEntry) {
                  return Text(searchEntry.toString());
                },
                dropDownButton: controller.isConnecting.value
                    ? CupertinoActivityIndicator()
                    : null,
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 0,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                ),
                enabled: !controller.isConnecting.value,
                label: "Kategori Event",
                mode: Mode.BOTTOM_SHEET,
                selectedItem: controller.selectedCategory,
                showSearchBox: true,
                onFind: (text) => controller.fetchCategories(),
                onChanged: (value) {
                  print(value!.id);
                  controller.selectedCategory = value;
                },
                itemAsString: (item) => item.name,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProvideDetails extends GetWidget<CreateController> {
  @override
  Widget build(BuildContext context) {
    var quillEditor = QuillEditor(
        controller: controller.editorController!,
        scrollController: ScrollController(),
        scrollable: false,
        minHeight: 200,
        focusNode: controller.focusNode,
        autoFocus: false,
        readOnly: false,
        placeholder:
            'Tambahkan deskripsi yang menarik biar banyak yang hadir! :D',
        expands: false,
        padding: EdgeInsets.symmetric(horizontal: 15),
        customStyles: DefaultStyles(
          h1: DefaultTextBlockStyle(
              const TextStyle(
                fontSize: 32,
                color: Colors.black,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              const Tuple2(16, 0),
              const Tuple2(0, 0),
              null),
          sizeSmall: const TextStyle(fontSize: 9),
        ));

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.data.isControlPressed && event.character == 'b') {
          if (controller.editorController!
              .getSelectionStyle()
              .attributes
              .keys
              .contains('bold')) {
            controller.editorController!
                .formatSelection(Attribute.clone(Attribute.bold, null));
          } else {
            controller.editorController!.formatSelection(Attribute.bold);
          }
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _Field(
                  label: "Judul",
                  field: controller.judulController,
                ),
                _Field(
                  label: "Moderator",
                  field: controller.moderatorController,
                ),
                _Field(
                  label: "Narasumber",
                  field: controller.narasumberController,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.focusNode.unfocus();
                      FocusScope.of(context).autofocus(controller.focusNode);
                      if (FocusScope.of(context).canRequestFocus)
                        FocusScope.of(context)
                            .requestFocus(controller.focusNode);
                    },
                    child: Container(
                      child: StickyHeader(
                        header: QuillToolbar.basic(
                          controller: controller.editorController!,
                          // onImagePickCallback: _onImagePickCallback,
                        ),
                        content: quillEditor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Field extends GetWidget {
  final String? label;
  final TextEditingController? field;
  _Field({this.label, this.field});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          controller: field,
          style: TextStyle(
            fontSize: 22,
          ),
          maxLines: null,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: label ?? "Input",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }
}
