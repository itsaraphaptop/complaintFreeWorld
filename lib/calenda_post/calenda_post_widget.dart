import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../list/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendaPostWidget extends StatefulWidget {
  const CalendaPostWidget({Key key}) : super(key: key);

  @override
  _CalendaPostWidgetState createState() => _CalendaPostWidgetState();
}

class _CalendaPostWidgetState extends State<CalendaPostWidget>
    with TickerProviderStateMixin {
  DateTimeRange calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'calendarOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<JobPostsRecord>>(
      stream: queryJobPostsRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        List<JobPostsRecord> calendaPostJobPostsRecordList = snapshot.data;
        // Return an empty Container when the document does not exist.
        if (snapshot.data.isEmpty) {
          return Container();
        }
        final calendaPostJobPostsRecord =
            calendaPostJobPostsRecordList.isNotEmpty
                ? calendaPostJobPostsRecordList.first
                : null;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 100, 0),
              child: Text(
                'My Complaint',
                style: FlutterFlowTheme.of(context).subtitle1.override(
                      fontFamily: 'Lexend Deca',
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: Color(0xFFF5F5F5),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowCalendar(
                                color: Color(0xFFE53935),
                                weekFormat: false,
                                weekStartsMonday: false,
                                initialDate: FFAppState().calendar,
                                onChange: (DateTimeRange newSelectedDate) {
                                  setState(() =>
                                      calendarSelectedDay = newSelectedDate);
                                },
                                titleStyle: GoogleFonts.getFont(
                                  'Lexend Deca',
                                ),
                                dayOfWeekStyle: GoogleFonts.getFont(
                                  'Lexend Deca',
                                ),
                                dateStyle: GoogleFonts.getFont(
                                  'Lexend Deca',
                                ),
                                selectedDateStyle: GoogleFonts.getFont(
                                  'Lexend Deca',
                                ),
                                inactiveDateStyle: GoogleFonts.getFont(
                                  'Lexend Deca',
                                ),
                              ).animated([
                                animationsMap['calendarOnPageLoadAnimation']
                              ]),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (responsiveVisibility(
                                context: context,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Text(
                                  dateTimeFormat(
                                      'MMMMEEEEd', FFAppState().calendar),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Text(
                                  dateTimeFormat(
                                      'd/M/y', FFAppState().calendar),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                            ],
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() => FFAppState().calendar =
                                  calendarSelectedDay.start);
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 300),
                                  reverseDuration: Duration(milliseconds: 300),
                                  child: ListWidget(
                                    date: dateTimeFormat(
                                        'd/M/y', FFAppState().calendar),
                                  ),
                                ),
                              );
                            },
                            text: 'Load',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                  ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
