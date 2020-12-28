import 'package:flutter/material.dart';

class App {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}

class Colors {
  Color mainColor(double opacity) {
    return Color(0xFFFFFFFF).withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return Color(0xff005E7B).withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return Color(0xffff005e).withOpacity(opacity);
  }

  Color focusColor(double opacity) {
    return Color(0xff4287da).withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return Color(0xff0e1d32).withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return Color(0xff9e9e9e).withOpacity(opacity);
  }
}
