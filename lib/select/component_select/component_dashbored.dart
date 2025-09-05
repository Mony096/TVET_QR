import 'package:flutter/material.dart';
import 'package:npit_qr/component/button.dart';
import 'package:npit_qr/constant/style.dart';
import 'package:npit_qr/form/input.dart';
import 'package:npit_qr/utilities/dialog/dialog.dart';
import 'package:npit_qr/helper/helper.dart';
import 'package:flutter_svg/svg.dart';

class ComponentDashboardScreen extends StatefulWidget {
  ComponentDashboardScreen(
      {super.key,
      required this.componentList,
      required this.partList,
      this.viewOnly});
  List<dynamic> componentList;
  List<dynamic> partList;
  dynamic viewOnly;
  @override
  State<ComponentDashboardScreen> createState() =>
      _ComponentDashboardScreenState();
}

class _ComponentDashboardScreenState extends State<ComponentDashboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int updateIndexComps = -1;
  int updateIndexParts = -1;
  int isEditComp = -1;
  int isEditPart = -1;
  List<dynamic> componentList = [];
  List<dynamic> partList = [];

  final cCode = TextEditingController();
  final cName = TextEditingController();
  final cPart = TextEditingController();
  final cBrand = TextEditingController();
  final cModel = TextEditingController();

  final pCode = TextEditingController();
  final pName = TextEditingController();
  final pPart = TextEditingController();
  final pBrand = TextEditingController();
  final pModel = TextEditingController();
  final FocusNode cCodeFocusNode = FocusNode();
  final FocusNode pCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    componentList = widget.componentList;
    partList = widget.partList;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onAddComponent({bool force = false}) {
    setState(() {
      print(componentList);
    });
    try {
      List<dynamic> data = [...componentList];

      if (cCode.text == '') {
        throw Exception('Code is missing.');
      }

      if (cName.text == '') {
        throw Exception('Name is missing.');
      }

      final item = {
        "U_ck_comCode": cCode.text,
        "U_U_ck_comName": cName.text,
        "U_ck_partNum": cPart.text,
        "U_ck_brand": cBrand.text,
        "U_ck_model": cModel.text,
      };

      if (isEditComp == -1) {
        // if (!force) {
        //   final exist = items.indexWhere((row) =>
        //       row['ItemCode'] == item['ItemCode'] &&
        //       row['UoMCode'] == item['UoMCode']);

        //   if (exist >= 0) {
        //     throw Exception('${item['ItemCode']} already exist.');
        //   }
        // }

        // throw Exception('${item['ItemCode']} already exist.');

        data.add(item);
      } else {
        data[isEditComp] = item;
        isEditComp = -1;
      }

      // print(item);

      clear();
      setState(() {
        componentList = data;
      });
      FocusScope.of(context).requestFocus(cCodeFocusNode);
    } catch (err) {
      if (err is Exception) {
        MaterialDialog.success(context, title: 'Warning', body: err.toString());
      }
    }
  }

  void onEditComp(dynamic item, int index) {
    if (index < 0) return;
    MaterialDialog.warning(
      context,
      title: 'Component (${item['U_ck_comCode']})',
      confirmLabel: "Edit",
      cancelLabel: "Remove",
      onConfirm: () {
        cCode.text = getDataFromDynamic(item["U_ck_comCode"]);
        cName.text = getDataFromDynamic(item["U_U_ck_comName"]);
        cPart.text = getDataFromDynamic(item["U_ck_partNum"]);
        cBrand.text = getDataFromDynamic(item["U_ck_brand"]);
        cModel.text = getDataFromDynamic(item["U_ck_model"]);

        setState(() {
          isEditComp = index;
        });
      },
      onCancel: () {
        List<dynamic> data = [...componentList];
        data.removeAt(index);
        setState(() {
          componentList = data;
          isEditComp = -1;
        });
      },
    );
  }

  void clear() {
    cCode.text = "";
    cName.text = "";
    cPart.text = "";
    cBrand.text = "";
    cModel.text = "";
  }

//////////////////////
  void onAddParts({bool force = false}) {
    try {
      List<dynamic> data = [...partList];

      if (pCode.text == '') {
        throw Exception('Code is missing.');
      }

      if (pName.text == '') {
        throw Exception('Name is missing.');
      }

      final item = {
        "U_ck_ParthCode": pCode.text,
        "U_U_ck_PartName": pName.text,
        "U_ck_PartNum": pPart.text,
        "U_ck_brand": pBrand.text,
        "U_ck_model": pModel.text,
      };

      if (isEditPart == -1) {
        // if (!force) {
        //   final exist = items.indexWhere((row) =>
        //       row['ItemCode'] == item['ItemCode'] &&
        //       row['UoMCode'] == item['UoMCode']);

        //   if (exist >= 0) {
        //     throw Exception('${item['ItemCode']} already exist.');
        //   }
        // }

        // throw Exception('${item['ItemCode']} already exist.');

        data.add(item);
      } else {
        data[isEditPart] = item;
        isEditPart = -1;
      }

      // print(item);

      clearPart();
      setState(() {
        partList = data;
        print(partList);
      });
      FocusScope.of(context).requestFocus(pCodeFocusNode);
    } catch (err) {
      if (err is Exception) {
        MaterialDialog.success(context, title: 'Warning', body: err.toString());
      }
    }
  }

  void onEditPart(dynamic item, int index) {
    if (index < 0) return;
    MaterialDialog.warning(
      context,
      title: 'Parts (${item['U_ck_ParthCode']})',
      confirmLabel: "Edit",
      cancelLabel: "Remove",
      onConfirm: () {
        pCode.text = getDataFromDynamic(item["U_ck_ParthCode"]);
        pName.text = getDataFromDynamic(item["U_U_ck_PartName"]);
        pPart.text = getDataFromDynamic(item["U_ck_PartNum"]);
        pBrand.text = getDataFromDynamic(item["U_ck_brand"]);
        pModel.text = getDataFromDynamic(item["U_ck_model"]);

        setState(() {
          isEditPart = index;
        });
      },
      onCancel: () {
        List<dynamic> data = [...partList];
        data.removeAt(index);
        setState(() {
          partList = data;
          isEditPart = -1;
        });
      },
    );
  }

  void clearPart() {
    pCode.text = "";
    pName.text = "";
    pPart.text = "";
    pBrand.text = "";
    pModel.text = "";
  }

  void refresh() {
    MaterialDialog.loading(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      componentList = widget.componentList;
      MaterialDialog.close(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 115, 117, 122),
        leading: IconButton(
          icon: widget.viewOnly == true
              ? const Icon(Icons.arrow_back, color: Colors.white)
              : const Icon(Icons.check, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, {"comps": componentList, "parts": partList});
          },
        ),
        title: const Center(
          child: Text(
            'Component',
            style: TextStyle(fontSize: 17),
            textScaleFactor: 1.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Row(
              children: [
                Icon(Icons.refresh_rounded, color: Colors.white),
              ],
            ),
            onPressed: () {
              refresh();
              // Handle scan barcode action
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 182, 180, 180), // Border color
                  width: 0.5, // Border width
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(0);
                    },
                    child: AnimatedContainer(
                      padding: const EdgeInsets.all(17),
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _tabController.index == 0
                                ? const Color.fromARGB(255, 122, 124, 128)
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          textScaleFactor: 1.0,
                          "COMP",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _tabController.index == 0
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(1);
                    },
                    child: AnimatedContainer(
                      padding: const EdgeInsets.all(17),
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _tabController.index == 1
                                ? const Color.fromARGB(255, 122, 124, 128)
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          textScaleFactor: 1.0,
                          "PART",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _tabController.index == 1
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: const Color.fromARGB(255, 236, 237, 240),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.viewOnly == true
                        ? Container()
                        : Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 213, 215, 218),
                                ),
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 232, 234, 236),
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(22, 20, 0, 20),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.edit_document,
                                  size: 20,
                                  color: Color.fromARGB(255, 72, 73, 74),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  textScaleFactor: 1.0,
                                  "Create Component",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 51, 52, 53),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Code',
                            placeholder: 'Code',
                            controller: cCode,
                            focusNode: cCodeFocusNode,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Name',
                            placeholder: 'Name',
                            controller: cName,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Part Number',
                            placeholder: 'Part Number',
                            controller: cPart,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Brand',
                            placeholder: 'Brand',
                            controller: cBrand,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Model',
                            placeholder: 'Model',
                            controller: cModel,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 222, 224, 227),
                                  ),
                                ),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 11.5),
                              height: 65,
                              width: double.infinity,
                              child: Button(
                                bgColor:
                                    const Color.fromARGB(255, 33, 107, 243),
                                onPressed: () {
                                  onAddComponent();
                                },
                                heigth: 48.00,
                                child: Text(
                                  textScaleFactor: 1.0,
                                  isEditComp >= 0 ? "Update" : "Add",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : const SizedBox(height: 22),
                    widget.viewOnly == true
                        ? const SizedBox(height: 6)
                        : Container(),
                    const ContentHeader(),
                    const SizedBox(height: 5),
                    componentList.isEmpty
                        ? const SizedBox(
                            height: 180,
                            child: Center(
                              child: Text(
                                "No records found",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap:
                                true, // Important: allows the ListView to wrap its content
                            physics:
                                const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling separately
                            itemCount: componentList.length,
                            itemBuilder: (context, index) {
                              final item = componentList[index];
                              return GestureDetector(
                                onTap: () {
                                  if (widget.viewOnly == true) return;
                                  onEditComp(item, index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      top: BorderSide(
                                        color: index == 0
                                            ? const Color.fromARGB(
                                                255, 222, 224, 227)
                                            : Colors.white,
                                        width: 1,
                                      ),
                                      bottom: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 222, 224, 227),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 35,
                                          width:
                                              35, // Ensure the width and height are equal for a perfect circle
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 33, 107, 243),
                                            shape: BoxShape
                                                .circle, // Makes the container circular
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255,
                                                  79,
                                                  78,
                                                  78), // Optional: Add a border if needed
                                              width: 1.0, // Border width
                                            ),
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.build,
                                                size: 17,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${getDataFromDynamic(item["U_ck_comCode"])} - ${getDataFromDynamic(item["U_U_ck_comName"])} ", // Show index
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                    textScaleFactor: 1.0),
                                                Row(
                                                  children: [
                                                    const Text("Model : ",
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        textScaleFactor: 1.0),
                                                    Text(
                                                        getDataFromDynamic(
                                                            item["U_ck_model"]),
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                        textScaleFactor: 1.0),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text("Brand : ",
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        textScaleFactor: 1.0),
                                                    Text(
                                                        getDataFromDynamic(
                                                            item["U_ck_brand"]),
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                        textScaleFactor: 1.0),
                                                  ],
                                                ),
                                                Text("No. ${index + 1}",
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                    textScaleFactor: 1.0),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 236, 237, 240),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.viewOnly == true
                        ? Container()
                        : Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 213, 215, 218),
                                ),
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 232, 234, 236),
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(22, 20, 0, 20),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.edit_document,
                                  size: 20,
                                  color: Color.fromARGB(255, 72, 73, 74),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  textScaleFactor: 1.0,
                                  "Create Part",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 51, 52, 53),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Code',
                            placeholder: 'Code',
                            controller: pCode,
                            focusNode: pCodeFocusNode,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Name',
                            placeholder: 'Name',
                            controller: pName,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Part Number',
                            placeholder: 'Part Number',
                            controller: pPart,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Brand',
                            placeholder: 'Brand',
                            controller: pBrand,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Input(
                            label: 'Model',
                            placeholder: 'Model',
                            controller: pModel,
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 222, 224, 227),
                                  ),
                                ),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 11.5),
                              height: 65,
                              width: double.infinity,
                              child: Button(
                                heigth: 48.00,
                                bgColor:
                                    const Color.fromARGB(255, 33, 107, 243),
                                onPressed: () {
                                  onAddParts();
                                },
                                child: Text(
                                  textScaleFactor: 1.0,
                                  isEditPart >= 0 ? "Update" : "Add",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                    widget.viewOnly == true
                        ? Container()
                        : const SizedBox(height: 22),
                    widget.viewOnly == true
                        ? const SizedBox(
                            height: 6,
                          )
                        : Container(),
                    const ContentHeader2(),
                    const SizedBox(height: 5),
                    partList.isEmpty
                        ? const SizedBox(
                            height: 180,
                            child: Center(
                              child: Text(
                                "No records found",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap:
                                true, // Important: allows the ListView to wrap its content
                            physics:
                                const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling separately
                            itemCount: partList.length,
                            itemBuilder: (context, index) {
                              final item = partList[index];
                              return GestureDetector(
                                onTap: () {
                                  if (widget.viewOnly == true) return;

                                  onEditPart(item, index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      top: BorderSide(
                                        color: index == 0
                                            ? const Color.fromARGB(
                                                255, 222, 224, 227)
                                            : Colors.white,
                                        width: 1,
                                      ),
                                      bottom: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 222, 224, 227),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 35,
                                          width:
                                              35, // Ensure the width and height are equal for a perfect circle
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 33, 107, 243),
                                            shape: BoxShape
                                                .circle, // Makes the container circular
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255,
                                                  79,
                                                  78,
                                                  78), // Optional: Add a border if needed
                                              width: 1.0, // Border width
                                            ),
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.build,
                                                size: 17,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${getDataFromDynamic(item["U_ck_ParthCode"])} - ${getDataFromDynamic(item["U_U_ck_PartName"])} ", // Show index
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                    textScaleFactor: 1.0),
                                                Row(
                                                  children: [
                                                    const Text("Model : ",
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        textScaleFactor: 1.0),
                                                    Text(
                                                        getDataFromDynamic(
                                                            item["U_ck_model"]),
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                        textScaleFactor: 1.0),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text("Brand : ",
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        textScaleFactor: 1.0),
                                                    Text(
                                                        getDataFromDynamic(
                                                            item["U_ck_brand"]),
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                        textScaleFactor: 1.0),
                                                  ],
                                                ),
                                                Text("No. ${index + 1}",
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                    textScaleFactor: 1.0),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: size(context).height * 0.08,
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Expanded(
            child: Button(
              heigth: 48.00,
              onPressed: () {
                Navigator.pop(
                    context, {"comps": componentList, "parts": partList});
              },
              bgColor: const Color.fromARGB(255, 33, 107, 243),
              child: const Text(
                textScaleFactor: 1.0,
                'Done',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
          // const SizedBox(width: 12),
          // const Expanded(
          //   child: SizedBox(),
          // ),
          const SizedBox(width: 12),
          Expanded(
            child: Button(
              heigth: 48.00,
              variant: ButtonVariant.outline,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                textScaleFactor: 1.0,
                'Cancel',
                style: TextStyle(
                  fontSize: 14,
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ContentHeader extends StatelessWidget {
  const ContentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border(
          bottom: BorderSide(width: 0.1),
          top: BorderSide(width: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(21, 8, 0, 8),
        child: Row(
          children: [
            SvgPicture.asset(
              'images/svg/desc.svg',
              width: 23,
              height: 23,
              color: const Color.fromARGB(255, 51, 52, 53),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              textScaleFactor: 1.0,
              "Component Lists",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 51, 52, 53)),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentHeader2 extends StatelessWidget {
  const ContentHeader2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border(
          bottom: BorderSide(width: 0.1),
          top: BorderSide(width: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(21, 8, 0, 8),
        child: Row(
          children: [
            SvgPicture.asset(
              'images/svg/desc.svg',
              width: 23,
              height: 23,
              color: const Color.fromARGB(255, 51, 52, 53),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              textScaleFactor: 1.0,
              "Part Lists",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 51, 52, 53)),
            ),
          ],
        ),
      ),
    );
  }
}
