import 'package:npit_qr/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/business_partner_cubit.dart';
import '/constant/style.dart';

class BusinessPartnerPage extends StatefulWidget {
  const BusinessPartnerPage({super.key});

  @override
  State<BusinessPartnerPage> createState() => _BusinessPartnerPageState();
}

class _BusinessPartnerPageState extends State<BusinessPartnerPage> {
  final ScrollController _scrollController = ScrollController();

  String query = "?\$top=10&\$skip=0";

  int check = 1;
  TextEditingController filter = TextEditingController();
  List<dynamic> data = [];
  late BusinessPartnerCubit _bloc;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _bloc = context.read<BusinessPartnerCubit>();
      final state = context.read<BusinessPartnerCubit>().state;

      if (state is BusinessPartnerData) {
        data = state.entities;
      }

      if (data.isEmpty) {
        _bloc.get("$query&\$filter=CardType eq 'cCustomer'").then((value) {
          setState(() => data = value);
          _bloc.set(value);
        });
      }

      setState(() {
        data;
      });

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          final state = BlocProvider.of<BusinessPartnerCubit>(context).state;
          if (state is BusinessPartnerData && data.isNotEmpty) {
            _bloc
                .next(
                    "?\$top=10&\$skip=${data.length}&\$filter=CardType eq 'cCustomer' and contains(CardCode,'${filter.text}')")
                .then((value) {
              if (!mounted) return;
              _bloc.set([...data, ...value]);
              setState(() => data = [...data, ...value]);
            });
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    filter.dispose();

    super.dispose();
  }

  void onFilter() async {
    setState(() {
      data = [];
    });
    _bloc
        .get(
            "$query&\$filter=CardType eq 'cCustomer' and contains(CardCode, '${filter.text}')")
        .then((value) {
      if (!mounted) return;

      setState(() => data = value);
    });
  }

  void onPressed(dynamic bp) {
    Navigator.pop(context, bp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 115, 117, 122),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Business Partner Lists',
              style: TextStyle(fontSize: 17), textScaleFactor: 1.0)),

      // bottomNavigationBar: MyBottomSheet(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 243, 243, 243),
        child: Column(
          children: [
            // Container(
            //   padding:
            //       const EdgeInsets.only(left: 14, right: 14, bottom: 6, top: 4),
            //   width: double.infinity,
            //   decoration: BoxDecoration(color: Colors.white),
            //   child: TextFormField(
            //     controller: filter,
            //     decoration: InputDecoration(
            //       enabledBorder: UnderlineInputBorder(
            //           borderSide: BorderSide(color: Colors.transparent)),
            //       focusedBorder: UnderlineInputBorder(
            //           borderSide: BorderSide(color: Colors.transparent)),
            //       contentPadding: const EdgeInsets.only(top: 15),
            //       hintText: 'BusinessPartner Code...',
            //       suffixIcon: IconButton(
            //         icon: Icon(
            //           Icons.search,
            //           color: PRIMARY_COLOR,
            //         ),
            //         onPressed: onFilter,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 7,
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextFormField(
                controller: filter,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 123, 125, 126), width: 1.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: const EdgeInsets.only(top: 12),
                  hintText: 'BP Code...',
                  hintStyle: const TextStyle(
                    fontSize: 14.0, // Placeholder font size
                    color: Colors.grey,
                    // Placeholder text color
                  ),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.list,
                    ),
                    onPressed: onFilter,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            // const Divider(thickness: 0.1, height: 15),
            Expanded(
              child: BlocConsumer<BusinessPartnerCubit, BusinessPartnerState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingBusinessPartner) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    controller: _scrollController,
                    children: [
                      ...data.map(
                        (bp) => GestureDetector(
                          onTap: () => onPressed(bp),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getDataFromDynamic(bp['CardCode']),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  getDataFromDynamic(bp['CardName']),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (state is RequestingPaginationBusinessPartner)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
