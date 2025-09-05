import 'package:flutter/material.dart';

class DetailRow extends StatefulWidget {
  const DetailRow(
      {super.key,
      required this.title,
      this.row1,
      this.row2,
      this.row3,
      this.rowRight1,
      this.rowRight2,
      this.rowRight3,
      required this.svg,
      this.isRowRight1Icon, this.isRowRight2Icon, this.isRowRight3Icon});

  final String title;
  final String? row1;
  final dynamic rowRight1;
  final dynamic isRowRight1Icon;
  final String? row2;
  final dynamic isRowRight2Icon;

  final dynamic rowRight2;
  final String? row3;
  final dynamic isRowRight3Icon;

  final dynamic rowRight3;
  final dynamic svg;

  @override
  _DetailRowState createState() => _DetailRowState();
}

class _DetailRowState extends State<DetailRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: widget.svg,
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                    textScaleFactor: 1.0
                  ),
                  if (widget.row1 != null) SizedBox(height: 10),
                  if (widget.row1 != null)
                    Row(
                      children: [
                        Expanded(flex: 3, child: Text(widget.row1!, textScaleFactor: 1.0,style: TextStyle(fontSize: 12.5),)),
                        Expanded(
                          flex: 3,
                          child: widget.rowRight1 != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: widget.isRowRight1Icon == true
                                      ? Align(
                                          alignment: Alignment
                                              .centerRight, // Align the icon to the right
                                          child: widget.rowRight1!,
                                        )
                                      : Text(
                                        textScaleFactor: 1.0,
                                        style: TextStyle(fontSize: 12.5),
                                          widget.rowRight1!,
                                          textAlign: TextAlign.right,
                                        ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  if (widget.row2 != null) SizedBox(height: 10),
                  if (widget.row2 != null)
                    Row(
                      children: [
                        Expanded(flex: 3, child: Text(widget.row2!,style: TextStyle(fontSize: 12.5),
                                textScaleFactor: 1.0)),
                        Expanded(
                          flex: 3,
                          child: widget.rowRight2 != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: widget.isRowRight2Icon == true
                                      ? Align(
                                          alignment: Alignment
                                              .centerRight, // Align the icon to the right
                                          child: widget.rowRight2!,
                                        )
                                      : Text(
                                          widget.rowRight2!,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(fontSize: 12.5),
                                          textScaleFactor: 1.0
                                        ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  if (widget.row3 != null) SizedBox(height: 10),
                  if (widget.row3 != null)
                    Row(
                      children: [
                        Expanded(flex: 3, child: Text(widget.row3!, textScaleFactor: 1.0,style: TextStyle(fontSize: 12.5),)),
                        Expanded(
                          flex: 3,
                          child: widget.rowRight3 != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: widget.isRowRight3Icon == true
                                      ? Align(
                                          alignment: Alignment
                                              .centerRight, // Align the icon to the right
                                          child: widget.rowRight3!,
                                        )
                                      : Text(
                                          widget.rowRight3!,
                                          textAlign: TextAlign.right,
                                          textScaleFactor: 1.0,
                                          style: TextStyle(fontSize: 12.5),
                                        ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
