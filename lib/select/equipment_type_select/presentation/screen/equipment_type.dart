import 'dart:ffi';

import 'package:npit_qr/form/loading_circle.dart';
import 'package:flutter/material.dart';

class EquipmentTypeSelect extends StatefulWidget {
  const EquipmentTypeSelect({
    super.key,
    this.down,
    required this.label,
    required this.titleDialog,
    this.isLoading,
    required this.onSelect,
    required this.dataController,
    this.foucs,
  });
  final dynamic down;
  final String label;
  final String titleDialog;
  final dynamic isLoading;
  final dynamic foucs;

  final void Function()? onSelect;
  final TextEditingController dataController;
  @override
  State<EquipmentTypeSelect> createState() => _EquipmentTypeSelectState();
}

class _EquipmentTypeSelectState extends State<EquipmentTypeSelect> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.5),
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 14),
              textScaleFactor: 1.0,
            ),
          ),
          TextFormField(
            focusNode: widget.foucs,
            controller: widget.dataController,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 123, 125, 126),
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(5, 18, 0, 0),
              suffixIcon: widget.down == true
                  ? IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 27,
                      ),
                      onPressed: widget.onSelect,
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_right,
                        size: 27,
                      ),
                      onPressed: () {},
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
