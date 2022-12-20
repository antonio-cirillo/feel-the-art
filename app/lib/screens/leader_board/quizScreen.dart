import 'package:feel_the_art/utils/theme/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feel_the_art/flutter_flow/flutter_flow_theme.dart';
import 'package:feel_the_art/flutter_flow/flutter_flow_widgets.dart';



import '../../utils/theme/colors.dart';
import '../../components/background.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedAnswer = 0;

  var selectedColor = Colors.green;
  var notSelectedColor = Color(0xFFEEEEEE);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(color: amethystColor.withOpacity(0.8)),
      const BackgroundScreen(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Material(
                color: Colors.transparent,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Domanda del giorno',
                            style: FlutterFlowTheme.of(context).title1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: SizedBox(
                                  width:  MediaQueryDataProportionate.layoutWidth,
                                  child: Text(
                                    'PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPpppppppppppppppppppppppppppppp',
                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: MediaQuery.of(context).getProportionateScreenWidth(18),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GestureDetector(
                                  onTap: () => {
                                    setState(() {
                                      if (selectedAnswer == 1) {
                                        selectedAnswer = 0;
                                      } else {
                                        selectedAnswer = 1;
                                      }
                                    }),
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: selectedAnswer == 1 ? selectedColor : notSelectedColor,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Option1',
                                                style: FlutterFlowTheme.of(context).subtitle1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.red,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    setState(() {
                                      if (selectedAnswer == 2) {
                                        selectedAnswer = 0;
                                      } else {
                                        selectedAnswer = 2;
                                      }
                                    }),
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: selectedAnswer == 2 ? selectedColor: notSelectedColor,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Option1',
                                                style: FlutterFlowTheme.of(context).subtitle1.override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    setState(() {
                                      if (selectedAnswer == 3) {
                                        selectedAnswer = 0;
                                      } else {
                                        selectedAnswer = 3;
                                      }
                                    }),
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: selectedAnswer == 3 ? selectedColor: notSelectedColor,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Option1',
                                                style: FlutterFlowTheme.of(context).subtitle1.override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    setState(() {
                                      if (selectedAnswer == 4) {
                                        selectedAnswer = 0;
                                      } else {
                                        selectedAnswer = 4;
                                      }
                                    }),
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: selectedAnswer == 4 ? Colors.green : Color(0xFFEEEEEE),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Option1',
                                                style: FlutterFlowTheme.of(context).subtitle1.override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {

                            },
                            text: 'Scegli',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 70,
                              color: Colors.lightGreen,
                              textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                              elevation: 4,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
