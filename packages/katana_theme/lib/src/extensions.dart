part of katana_theme;

/// Define a theme extension for [BuildContext].
///
/// [BuildContext]用のテーマエクステンションを定義します。
extension ThemeBuildContextExtensions on BuildContext {
  /// Get [AppThemeData] placed on the widget tree.
  ///
  /// ウィジェットツリー上に配置されている[AppThemeData]を取得します。
  AppThemeData get theme {
    return AppThemeData.of(this);
  }
}

/// Define a theme extension for [Color].
///
/// [Color]用のテーマエクステンションを定義します。
extension ThemeColorExtensions on Color {
  /// Detects [GradientColor] stored in [Color] and creates [LinearGradient].
  ///
  /// If [Color] is not [GradientColor], [Color] will create a single-color [Gradient].
  ///
  /// [begin] determines the start position of the gradient and [end] determines the end position of the gradient.
  ///
  /// [Color]に格納されている[GradientColor]を検出し、[LinearGradient]を作成します。
  ///
  /// [Color]が[GradientColor]出ない場合は、[Color]単色の[Gradient]が作成されます。
  ///
  /// [begin]でグラデーションの開始位置、[end]でグラデーションの終了位置を決定します。
  ///
  /// ```dart
  /// final gradientColor = GradientColor(Colors.red, Colors.white);
  ///
  /// final gradient = gradientColor.toLinearGradient();
  /// ```
  Gradient toLinearGradient({
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    TileMode tileMode = TileMode.clamp,
    List<double>? stops,
    GradientTransform? transform,
  }) {
    final color = this;
    if (color is GradientColor) {
      return LinearGradient(
        colors: color._toGradient(),
        stops: stops,
        transform: transform,
        begin: begin,
        end: end,
        tileMode: tileMode,
      );
    } else {
      return LinearGradient(
        colors: [this],
        stops: stops,
        transform: transform,
        begin: begin,
        end: end,
        tileMode: tileMode,
      );
    }
  }

  /// Returns `true` if [Color] is [GradientColor].
  ///
  /// [Color]が[GradientColor]の場合`true`を返します。
  bool get isGradient {
    return this is GradientColor;
  }

  /// Darkens [Color] by the amount of [amount].
  ///
  /// [Color]を[amount]の分だけより暗くします。
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// Make [Color] brighter by the amount of [amount].
  ///
  /// [Color]を[amount]の分だけより明るくします。
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}

/// Define a theme extension for [TextStyle].
///
/// [TextStyle]用のテーマエクステンションを定義します。
extension ThemeTextStyleExtensions on TextStyle {
  /// Darkens [TextStyle.color] of the text by [amount].
  ///
  /// テキストの[TextStyle.color]を[amount]の分だけより暗くします。
  TextStyle darken([double amount = 0.1]) {
    return copyWith(
      color: color?.darken(amount),
    );
  }

  /// Makes [TextStyle.color] of the text brighter by [amount].
  ///
  /// テキストの[TextStyle.color]を[amount]の分だけより明るくします。
  TextStyle lighten([double amount = 0.1]) {
    return copyWith(
      color: color?.lighten(amount),
    );
  }

  /// Decrease [TextStyle.fontSize] of the text by the amount of [amount].
  ///
  /// テキストの[TextStyle.fontSize]を[amount]の分だけ小さくします。
  TextStyle smallize([double amount = 1]) {
    return copyWith(fontSize: fontSize == null ? null : (fontSize! - amount));
  }

  /// Increase [TextStyle.fontSize] of the text by the amount of [amount].
  ///
  /// テキストの[TextStyle.fontSize]を[amount]の分だけ大きくします。
  TextStyle largize([double amount = 1]) {
    return copyWith(fontSize: fontSize == null ? null : (fontSize! + amount));
  }

  /// Set the transparency of the text's [TextStyle.color] to [opacity].
  ///
  /// Transparency should be set between 0.0 and 1.0.
  ///
  /// テキストの[TextStyle.color]の透過度を[opacity]に設定します。
  ///
  /// 透過度は0.0〜1.0の間で設定してください。
  TextStyle withOpacity(double opacity) {
    return copyWith(color: color?.withOpacity(opacity));
  }

  /// Set [TextStyle.color] to [color] for the text.
  ///
  /// テキストの[TextStyle.color]を[color]に設定します。
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  /// Set [TextStyle.fontWeight] to [fontWeight] for the text.
  ///
  /// By default, [FontWeight.bold] is set.
  ///
  /// テキストの[TextStyle.fontWeight]を[fontWeight]に設定します。
  ///
  /// デフォルトだと[FontWeight.bold]が設定されます。
  TextStyle withBold([FontWeight fontWeight = FontWeight.bold]) {
    return copyWith(fontWeight: fontWeight);
  }

  /// Set [TextStyle.fontSize] to [fontSize] for the text.
  ///
  /// テキストの[TextStyle.fontSize]を[fontSize]に設定します。
  TextStyle withSize(double fontSize) {
    return copyWith(fontSize: fontSize);
  }
}
