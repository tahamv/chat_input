import "dart:io";

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'line.dart';


class ChatInput extends StatefulWidget {
  const ChatInput({
    required this.onAttachmentTap,
    required this.onSendTap,
    required this.text,
    required this.focusNode,
    this.style,
    this.backgroundColor,
    this.textColor,

    Key? key,
  }) : super(key: key);
  final Function onAttachmentTap;
  final Function onSendTap;
  final TextEditingController text;
  final FocusNode focusNode;
  final TextStyle? style;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool emojiShowing = false;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: widget.backgroundColor??Theme.of(context).backgroundColor,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    widget.onAttachmentTap();
                  },
                  child: SvgPicture.asset("assets/svg/attachment.svg")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Line(
                  color:  Colors.black12,
                  height: 24,
                  width: 2,
                ),
              ),
              Expanded(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.top,
                    onTap: () {
                      if (emojiShowing) {
                        emojiShowing = false;
                        setState(() {});
                      }
                    },
                    focusNode: widget.focusNode,
                    keyboardAppearance: Brightness.dark,
                    textAlign: TextAlign.start,
                    enabled: true,
                    controller: widget.text,
                    keyboardType: TextInputType.text,
                    style: widget.style ??
                        TextStyle(
                          fontSize: 14,
                          color: widget.textColor,
                          fontWeight: FontWeight.w400,
                          height: 1.7,
                        ),
                    enableInteractiveSelection: true,
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: const EdgeInsetsDirectional.only(start: 0, top: 0, bottom: 0, end: 10),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: widget.textColor,
                        fontWeight: FontWeight.w400,
                        height: 1.7,
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    emojiShowing = !emojiShowing;
                    setState(() {});
                  },
                  child: SvgPicture.asset("assets/svg/emoji.svg")),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16, end: 12),
                child: Line(
                  color: Colors.black12,
                  height: 24,
                  width: 2,
                ),
              ),
              InkWell(
                  onTap: () {
                    widget.onSendTap();
                  },
                  child: SvgPicture.asset("assets/svg/send")),
            ],
          ),
        ),
        Offstage(
          offstage: !emojiShowing,
          child: SizedBox(
            height: 250,
            child: EmojiPicker(
                onEmojiSelected: (Category category, Emoji emoji) {
                  widget.text
                    ..text += emoji.emoji
                    ..selection = TextSelection.fromPosition(TextPosition(offset: widget.text.text.length));
                  setState(() {});
                },
                onBackspacePressed: () {
                  widget.text
                    ..text = widget.text.text.characters.skipLast(1).toString()
                    ..selection = TextSelection.fromPosition(TextPosition(offset: widget.text.text.length));
                  setState(() {});
                },
                config: Config(
                    columns: 7,
                    // Issue: https://github.com/flutter/flutter/issues/28894
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    progressIndicatorColor: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL)),
          ),
        ),
      ],
    );
  }
}
