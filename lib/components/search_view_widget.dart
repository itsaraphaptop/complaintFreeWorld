import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchViewWidget extends StatefulWidget {
  const SearchViewWidget({Key key}) : super(key: key);

  @override
  _SearchViewWidgetState createState() => _SearchViewWidgetState();
}

class _SearchViewWidgetState extends State<SearchViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      children: [
        Text(
          'Hello World',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
      ],
    );
  }
}
