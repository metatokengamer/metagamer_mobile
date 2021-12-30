import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:metagamer/current_route.dart';

import 'appbar.dart';
import 'bottom_nav.dart';

class BoadPage extends StatefulWidget {
  const BoadPage({Key? key}) : super(key: key);

  @override
  _BoadPageState createState() => _BoadPageState();
}

class _BoadPageState extends State<BoadPage> {
  DateTime pre_backpress = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    setRoute(5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            final snack = SnackBar(
                content: Text("한번더눌러서종료"), duration: Duration(seconds: 2));
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppbar(),
                Boad(),
                KeyboardVisibilityProvider(child: BottomNav())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Boad extends StatefulWidget {
  const Boad({Key? key}) : super(key: key);

  @override
  _BoadState createState() => _BoadState();
}

class _BoadState extends State<Boad> {
  HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: controller,
      htmlEditorOptions: HtmlEditorOptions(
        hint: "Your text here...",
      ),
      htmlToolbarOptions: HtmlToolbarOptions(
        defaultToolbarButtons: [
          FontButtons(),
          ColorButtons(),
          InsertButtons(
              video: false,
              audio: false,
              table: false,
              hr: false,
              otherFile: false)
        ],
        mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
          print(file.name); //filename
          print(file.size); //size in bytes
          print(file.extension); //file extension (eg jpeg or mp4)
          return true;
        },
      ),


      // callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
      //   print('html before change is $currentHtml');
      // }, onChangeContent: (String? changed) {
      //   print('content changed to $changed');
      // }, onChangeCodeview: (String? changed) {
      //   print('code changed to $changed');
      // }, onChangeSelection: (EditorSettings settings) {
      //   print('parent element is ${settings.parentElement}');
      //   print('font name is ${settings.fontName}');
      // }, onDialogShown: () {
      //   print('dialog shown');
      // }, onEnter: () {
      //   print('enter/return pressed');
      // }, onFocus: () {
      //   print('editor focused');
      // }, onBlur: () {
      //   print('editor unfocused');
      // }, onBlurCodeview: () {
      //   print('codeview either focused or unfocused');
      // }, onInit: () {
      //   print('init');
      // },
      //     //this is commented because it overrides the default Summernote handlers
      //     /*onImageLinkInsert: (String? url) {
      //               print(url ?? "unknown url");
      //             },
      //             onImageUpload: (FileUpload file) async {
      //               print(file.name);
      //               print(file.size);
      //               print(file.type);
      //               print(file.base64);
      //             },*/
      //     onKeyDown: (int? keyCode) {
      //   print('$keyCode key downed');
      //   print('current character count: ${controller.characterCount}');
      // }, onKeyUp: (int? keyCode) {
      //   print('$keyCode key released');
      // }, onMouseDown: () {
      //   print('mouse downed');
      // }, onMouseUp: () {
      //   print('mouse released');
      // }, onNavigationRequestMobile: (String url) {
      //   print(url);
      //   return NavigationActionPolicy.ALLOW;
      // }, onPaste: () {
      //   print('pasted into editor');
      // }, onScroll: () {
      //   print('editor scrolled');
      // }),
      // plugins: [
      //   SummernoteAtMention(
      //       getSuggestionsMobile: (String value) {
      //         var mentions = <String>['test1', 'test2', 'test3'];
      //         return mentions
      //             .where((element) => element.contains(value))
      //             .toList();
      //       },
      //       mentionsWeb: ['test1', 'test2', 'test3'],
      //       onSelect: (String value) {
      //         print(value);
      //       }),
      // ],



    );
  }
}
