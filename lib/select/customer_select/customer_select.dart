import 'dart:ffi';

import 'package:npit_qr/form/loading_circle.dart';
import 'package:flutter/material.dart';

class CustomerSelect extends StatefulWidget {
  const CustomerSelect({
    super.key,
    this.down,
    required this.label,
    required this.titleDialog,
    this.isLoading,
    required this.onSelect,
    required this.dataController,
  });
  final dynamic down;
  final String label;
  final String titleDialog;
  final dynamic isLoading;
  final void Function()? onSelect;
  final TextEditingController dataController;
  @override
  State<CustomerSelect> createState() => _CustomerSelectState();
}

class _CustomerSelectState extends State<CustomerSelect> {
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
              style: const TextStyle(fontSize: 14, color: Colors.black),
              textScaleFactor: 1.0,
            ),
          ),
          TextFormField(
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
                      onPressed: widget.onSelect,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
