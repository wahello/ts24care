import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24BottomScrollWithBackgroundWidget/ts24_bottom_scroll_with_background_widget_viewmodel.dart';

class TS24BottomScrollWithBackgroundWidget extends StatefulWidget {
  final Widget child;
  final Widget background;
  final String title;
  final bool shadow;

  const TS24BottomScrollWithBackgroundWidget(
      {Key key, this.background, this.title, this.shadow = true, this.child})
      : super(key: key);

  @override
  _TS24BottomScrollWithBackgroundWidgetState createState() =>
      _TS24BottomScrollWithBackgroundWidgetState();
}

class _TS24BottomScrollWithBackgroundWidgetState
    extends State<TS24BottomScrollWithBackgroundWidget> {
  TS24BottomScrollWithBackgroundWidgetViewModel viewModel =
      TS24BottomScrollWithBackgroundWidgetViewModel();
  GlobalKey _key = GlobalKey();
  Offset _position = Offset(0.0, 0.0);
  _getSizeAndPosition() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    _position = renderBox.localToGlobal(Offset.zero);
    if (viewModel.currentOffset != _position.dy)
      viewModel.getHeightImageBackground(_position.dy);
    viewModel.currentOffset = _position.dy;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          final RenderBox renderBox = _key.currentContext.findRenderObject();
          _position = renderBox.localToGlobal(Offset.zero);
          viewModel.heightViewBackground =
              _position.dy - viewModel.heightAppbar;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _body() {
      Widget __background() {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black54,
          child: Stack(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(microseconds: 1),
                curve: Curves.linear,
                height: viewModel.heightImageBackgroundCurrent,
                width: MediaQuery.of(context).size.width,
                child: widget.background,
              ),
              widget.shadow
                  ?
              Positioned(
                      top: viewModel.heightImageBackgroundCurrent-70,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 10,
                                  blurRadius: 20,
                                  offset: Offset(10, -30)),
                              BoxShadow(
                                  color: Colors.black54,
                                  spreadRadius: 15,
                                  blurRadius: 50,
                                  offset: Offset(0, 0)),
                            ]),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        );
      }

      Widget __content(ScrollController scrollController) {
        return Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: ThemePrimary.backgroundColor,
                ),
                child: Column(
                  children: <Widget>[
                    (widget.title != null)?
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        widget.title,
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                    ):SizedBox(height: 23,),
                    widget.child
                  ],
                ),
              )
            ],
          ),
        );
      }

      return Stack(
        children: <Widget>[
          __background(),
          DraggableScrollableSheet(
//            expand: false,
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 1,
            builder: (context, scrollController) {
              viewModel.controller = scrollController;

              Future.delayed((Duration(milliseconds: 1))).then((_) {
                if (scrollController.offset < 1) {
                  _getSizeAndPosition();
                  print(scrollController.offset);
                }
              });

              return Container(
                key: _key,
                child: SingleChildScrollView(
                  controller: viewModel.controller,
                  child: __content(viewModel.controller),
                ),
              );
            },
          )
        ],
      );
    }

//EasyWebView(src: "https://web.ts24.com.vn/en_US/csrt",webAllowFullScreen: true,)
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return _body();
        },
      ),
    );
  }
}
