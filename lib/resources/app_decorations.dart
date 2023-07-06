
import 'package:flutter/material.dart';
import 'package:transactions_app/resources/app_colors.dart';
import 'package:transactions_app/resources/styles_manager.dart';

// ignore: avoid_classes_with_only_static_members
class AppDecorations {
  static final borderRadius4 = BorderRadius.circular(4);

  static final textFieldBorder = OutlineInputBorder(
    borderRadius: AppDecorations.borderRadius4,
    borderSide: const BorderSide(color: AppColors.lightGreyText, width: 2),
  );

  static final textFieldBorder3 = OutlineInputBorder(
    borderRadius: AppDecorations.borderRadius4,
    borderSide: const BorderSide(color: AppColors.darkBlue, width: 2),
  );

  static final booksFieldBorder = OutlineInputBorder(
    borderRadius: AppDecorations.borderRadius4,
    borderSide: const BorderSide(color: AppColors.darkBlue, width: 2),
  );

  static final textFieldBorder2 = OutlineInputBorder(
    borderRadius: AppDecorations.borderRadius4,
    borderSide: const BorderSide(color: AppColors.lightGreyText, width: 2),
  );

  static final textFieldBorderBlack = OutlineInputBorder(
    borderRadius: AppDecorations.borderRadius4,
    borderSide: const BorderSide(color: AppColors.lightGreyText, width: 4),
  );

  static final textFieldDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: StylesManager.body(AppColors.darkGreyText, 20),
    focusedBorder: AppDecorations.textFieldBorder,
    border: AppDecorations.textFieldBorder,
    enabledBorder: AppDecorations.textFieldBorder,
  );

  static final textFieldDecoration2 = InputDecoration(
    errorMaxLines: 3,
    filled: true,
    fillColor: AppColors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: StylesManager.body(AppColors.darkGreyText, 20),
    focusedBorder: AppDecorations.textFieldBorder,
    border: AppDecorations.textFieldBorder,
    enabledBorder: AppDecorations.textFieldBorder2,
  );

  static final textFieldDecoration3 = InputDecoration(
    filled: true,
    fillColor: AppColors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: StylesManager.body(AppColors.darkBlue, 20),
    focusedBorder: AppDecorations.textFieldBorder,
    border: AppDecorations.textFieldBorder3,
    enabledBorder: AppDecorations.textFieldBorder3,
  );

  static final textFieldDecorationBlack = InputDecoration(
    filled: true,
    fillColor: AppColors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: StylesManager.regular(AppColors.darkBlue, 16),
    focusedBorder: AppDecorations.textFieldBorder,
    border: AppDecorations.textFieldBorderBlack,
    enabledBorder: AppDecorations.textFieldBorder,
  );
}
