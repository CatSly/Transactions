import 'package:flutter/material.dart';
import 'package:transactions_app/resources/resources.dart';

class BgScreen extends StatefulWidget {
  const BgScreen({
    required this.child,
    required this.title,
    required this.leadingButton,
    required this.actionButton,
    this.howManyBooks = 0,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final String title;
  final Widget? leadingButton;
  final Widget? actionButton;
  final int howManyBooks;

  @override
  State<BgScreen> createState() => _BgScreenState();
}

class _BgScreenState extends State<BgScreen> {
  Widget get _background => Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.grayBg1,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          leading: widget.leadingButton,
          backgroundColor: AppColors.white,
          title: Text(
            widget.title + _howManyBooksChunk(widget.howManyBooks),
            style: StylesManager.header6(AppColors.darkBlue, 24),
          ),
          actions: [widget.actionButton ?? const SizedBox()],
          elevation: 1,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _background,
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(child: widget.child)],
            ),
          ),
        ],
      ),
    );
  }

  String _howManyBooksChunk(int howMany) {
    var wholeChunk = '';
    if (howMany > 0) {
      wholeChunk = ' (${widget.howManyBooks})';
    }
    return wholeChunk;
  }
}
