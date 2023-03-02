part of masamune;

const _kLeadingWidth = kToolbarHeight;

/// Create an AppBar to provide a consistent UI across web, desktop, and mobile.
///
/// [UniversalScaffold] can be used with [UniversalAppBar] and [UniversalListView] to create a responsive modern UI.
///
/// Basically, it is used in the same way as [AppBar].
///
/// It is responsive, and [title] moves according to the set screen size by [breakpoint] of [UniversalScaffold].
///
/// By specifying [subtitle], a subtitle can be displayed below [title].
///
/// Webとデスクトップ、モバイルで一貫したUIを提供するためのAppBarを作成します。
///
/// [UniversalScaffold]は、[UniversalAppBar]と[UniversalListView]などを使用して、UIを構築するとレスポンシブ対応なモダンUIが作成可能です。
///
/// 基本的には[AppBar]と同じように使用します。
///
/// レスポンシブ対応しており、[UniversalScaffold]の[breakpoint]によって、設定された画面サイズに応じて、[title]が移動します。
///
/// [subtitle]を指定することで、[title]の下にサブタイトルを表示することができます。
class UniversalAppBar extends StatelessWidget {
  /// Create an AppBar to provide a consistent UI across web, desktop, and mobile.
  ///
  /// [UniversalScaffold] can be used with [UniversalAppBar] and [UniversalListView] to create a responsive modern UI.
  ///
  /// Basically, it is used in the same way as [AppBar].
  ///
  /// It is responsive, and [title] moves according to the set screen size by [breakpoint] of [UniversalScaffold].
  ///
  /// By specifying [subtitle], a subtitle can be displayed below [title].
  ///
  /// Webとデスクトップ、モバイルで一貫したUIを提供するためのAppBarを作成します。
  ///
  /// [UniversalScaffold]は、[UniversalAppBar]と[UniversalListView]などを使用して、UIを構築するとレスポンシブ対応なモダンUIが作成可能です。
  ///
  /// 基本的には[AppBar]と同じように使用します。
  ///
  /// レスポンシブ対応しており、[UniversalScaffold]の[breakpoint]によって、設定された画面サイズに応じて、[title]が移動します。
  ///
  /// [subtitle]を指定することで、[title]の下にサブタイトルを表示することができます。
  const UniversalAppBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.subtitle,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle = false,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.titlePadding = EdgeInsets.zero,
    this.collapsedHeight,
    this.expandedHeight,
    this.shape,
    this.toolbarHeight = kToolbarHeight + 1,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.background,
    this.breakpoint,
    this.scrolledUnderElevation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.surfaceTintColor,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  })  : floating = true,
        pinned = false,
        snap = false,
        stretch = false,
        sliver = false,
        stretchTriggerOffset = 100.0,
        onStretchTrigger = null,
        titlePosition = UniversalAppBarTitlePosition.flexible,
        scrollStyle = UniversalAppBarScrollStyle.pinned,
        assert(
          collapsedHeight == null || collapsedHeight >= toolbarHeight,
          'The "collapsedHeight" argument has to be larger than or equal to [toolbarHeight].',
        );

  const UniversalAppBar._({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.subtitle,
    this.actions,
    this.flexibleSpace,
    this.titlePosition = UniversalAppBarTitlePosition.flexible,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle = false,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.titlePadding = EdgeInsets.zero,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = true,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.shape,
    this.toolbarHeight = kToolbarHeight + 1,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.sliver = true,
    this.background,
    this.scrollStyle = UniversalAppBarScrollStyle.pinned,
    this.breakpoint,
    this.scrolledUnderElevation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.surfaceTintColor,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  })  : assert(
          floating || !snap,
          'The "snap" argument only makes sense for floating app bars.',
        ),
        assert(stretchTriggerOffset > 0.0),
        assert(
          collapsedHeight == null || collapsedHeight >= toolbarHeight,
          'The "collapsedHeight" argument has to be larger than or equal to [toolbarHeight].',
        );

  /// If [sliver] is enabled, specifies the position of [title] and [subtitle].
  ///
  /// [sliver]が有効な場合、[title]および[subtitle]の位置を指定します。
  final UniversalAppBarTitlePosition titlePosition;

  /// You can specify the breakpoint at which the UI will change to a mobile-oriented UI.
  ///
  /// UIがモバイル向けのUIに変化するブレークポイントを指定できます。
  final ResponsiveBreakpoint? breakpoint;

  /// If this is enabled, it will appear as a sliver scroll view.
  ///
  /// これが有効な場合、スライバースクロールビューとして表示されます。
  final bool sliver;

  /// Specify the background widget for [AppBar].
  ///
  /// [AppBar]の背景ウィジェットを指定します。
  final Widget? background;

  /// If [sliver] is enabled, specifies the scrolling style.
  ///
  /// [sliver]が有効な場合、スクロールのスタイルを指定します。
  final UniversalAppBarScrollStyle scrollStyle;

  /// Specify padding for [title] and [subtitle].
  ///
  /// [title]および[subtitle]のパディングを指定します。
  final EdgeInsetsGeometry titlePadding;

  /// {@macro flutter.material.appbar.leading}
  final Widget? leading;

  /// {@macro flutter.material.appbar.automaticallyImplyLeading}
  final bool automaticallyImplyLeading;

  /// {@macro flutter.material.appbar.title}
  final Widget? title;

  /// {@macro flutter.material.appbar.actions}
  final List<Widget>? actions;

  /// {@macro flutter.material.appbar.flexibleSpace}
  final Widget? flexibleSpace;

  /// {@macro flutter.material.appbar.bottom}
  final PreferredSizeWidget? bottom;

  /// {@macro flutter.material.appbar.elevation}
  final double? elevation;

  /// {@macro flutter.material.appbar.scrolledUnderElevation}
  final double? scrolledUnderElevation;

  /// {@macro flutter.material.appbar.notificationPredicate}
  final bool Function(ScrollNotification) notificationPredicate;

  /// {@macro flutter.material.appbar.shadowColor}
  final Color? shadowColor;

  /// {@macro flutter.material.appbar.surfaceTintColor}
  final Color? surfaceTintColor;

  /// {@macro flutter.material.appbar.shape}
  final ShapeBorder? shape;

  /// {@macro flutter.material.appbar.backgroundColor}
  final Color? backgroundColor;

  /// {@macro flutter.material.appbar.foregroundColor}
  final Color? foregroundColor;

  /// {@macro flutter.material.appbar.iconTheme}
  final IconThemeData? iconTheme;

  /// {@macro flutter.material.appbar.actionsIconTheme}
  final IconThemeData? actionsIconTheme;

  /// {@macro flutter.material.appbar.primary}
  final bool primary;

  /// {@macro flutter.material.appbar.centerTitle}
  final bool centerTitle;

  /// {@macro flutter.material.appbar.excludeHeaderSemantics}
  final bool excludeHeaderSemantics;

  /// {@macro flutter.material.appbar.titleSpacing}
  final double? titleSpacing;

  /// {@macro flutter.material.appbar.toolbarOpacity}
  final double toolbarOpacity;

  /// {@macro flutter.material.appbar.bottomOpacity}
  final double bottomOpacity;

  /// {@macro flutter.material.appbar.toolbarHeight}
  final double toolbarHeight;

  /// {@macro flutter.material.appbar.leadingWidth}
  final double? leadingWidth;

  /// {@macro flutter.material.appbar.toolbarTextStyle}
  final TextStyle? toolbarTextStyle;

  /// {@macro flutter.material.appbar.titleTextStyle}
  final TextStyle? titleTextStyle;

  /// {@macro flutter.material.appbar.systemOverlayStyle}
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Specify the subtitle to be displayed under [title].
  ///
  /// [title]の下に表示するサブタイトルを指定します。
  final Widget? subtitle;

  /// Specify the height of the collapsed state.
  ///
  /// 折りたたまれた状態の高さを指定します。
  final double? collapsedHeight;

  /// Specify the height of the expanded state.
  ///
  /// 展開された状態の高さを指定します。
  final double? expandedHeight;

  /// Whether the app bar should become visible as soon as the user scrolls
  /// towards the app bar.
  ///
  /// Otherwise, the user will need to scroll near the top of the scroll view to
  /// reveal the app bar.
  ///
  /// If [snap] is true then a scroll that exposes the app bar will trigger an
  /// animation that slides the entire app bar into view. Similarly if a scroll
  /// dismisses the app bar, the animation will slide it completely out of view.
  ///
  /// ユーザーがアプリバーに向かってスクロールするとすぐにアプリバーが表示されるかどうかを指定します。
  ///
  /// そうでない場合、ユーザーはスクロールビューの上部に近づく必要があります。
  ///
  /// [snap]がtrueの場合、アプリバーを表示するスクロールは、アプリバー全体を表示するアニメーションをトリガーします。
  /// 同様に、アプリバーを非表示にするスクロールは、アプリバーを完全に非表示にするアニメーションをトリガーします。
  final bool floating;

  /// Whether the app bar should remain visible at the start of the scroll view.
  ///
  /// The app bar can still expand and contract as the user scrolls, but it will
  /// remain visible rather than being scrolled out of view.
  ///
  /// スクロールビューの開始時にアプリバーが表示されるかどうかを指定します。
  ///
  /// ユーザーがスクロールすると、アプリバーは拡大または縮小できますが、スクロールビューからスクロールされる代わりに表示されます。
  final bool pinned;

  /// If [snap] and [floating] are true then the floating app bar will "snap"
  /// into view.
  ///
  /// If [snap] is true then a scroll that exposes the floating app bar will
  /// trigger an animation that slides the entire app bar into view. Similarly
  /// if a scroll dismisses the app bar, the animation will slide the app bar
  /// completely out of view. Additionally, setting [snap] to true will fully
  /// expand the floating app bar when the framework tries to reveal the
  /// contents of the app bar by calling [RenderObject.showOnScreen]. For
  /// example, when a [TextField] in the floating app bar gains focus, if [snap]
  /// is true, the framework will always fully expand the floating app bar, in
  /// order to reveal the focused [TextField].
  ///
  /// Snapping only applies when the app bar is floating, not when the app bar
  /// appears at the top of its scroll view.
  ///
  /// [snap]と[floating]がtrueの場合、浮遊アプリバーは「スナップ」して表示されます。
  ///
  /// [snap]がtrueの場合、浮遊アプリバーを表示するスクロールは、アプリバー全体を表示するアニメーションをトリガーします。
  /// 同様に、アプリバーを非表示にするスクロールは、アプリバーを完全に非表示にするアニメーションをトリガーします。
  /// さらに、[snap]をtrueに設定すると、フレームワークが[RenderObject.showOnScreen]を呼び出してアプリバーのコンテンツを表示しようとするときに、浮遊アプリバーを完全に展開します。
  /// たとえば、浮遊アプリバーの[TextField]がフォーカスを受け取ると、[snap]がtrueの場合、フレームワークは常に浮遊アプリバーを完全に展開して、フォーカスを受け取った[TextField]を表示します。
  ///
  /// スナッピングは、アプリバーが浮遊している場合にのみ適用され、アプリバーがスクロールビューの上部に表示される場合は適用されません。
  final bool snap;

  /// Whether the app bar should stretch to fill the over-scroll area.
  ///
  /// The app bar can still expand and contract as the user scrolls, but it will
  /// also stretch when the user over-scrolls.
  ///
  /// アプリバーがオーバースクロールエリアにフィットするように伸縮するかどうかを指定します。
  ///
  /// ユーザーがスクロールすると、アプリバーは拡大または縮小できますが、ユーザーがオーバースクロールすると伸縮します。
  final bool stretch;

  /// The amount of over-scroll required before the app bar will start to
  /// stretch.
  ///
  /// アプリバーが伸縮を開始する前に必要なオーバースクロールの量。
  final double stretchTriggerOffset;

  /// Called when the app bar has started to stretch.
  ///
  /// アプリバーが伸縮を開始したときに呼び出されます。
  final AsyncCallback? onStretchTrigger;

  @override
  Widget build(BuildContext context) {
    final centerTitle = this.centerTitle;
    final mergedTitle = subtitle == null
        ? title
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: centerTitle
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              if (title != null) title!,
              DefaultTextStyle(
                style:
                    Theme.of(context).textTheme.labelSmall ?? const TextStyle(),
                child: subtitle!,
              ),
            ],
          );
    if (!sliver) {
      return ResponsiveAppBar(
        key: key,
        breakpoint: breakpoint,
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: mergedTitle,
        actions: actions,
        flexibleSpace: flexibleSpace,
        bottom: bottom,
        elevation: elevation,
        shadowColor: shadowColor,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        iconTheme: iconTheme,
        actionsIconTheme: actionsIconTheme,
        primary: primary,
        centerTitle: centerTitle,
        excludeHeaderSemantics: excludeHeaderSemantics,
        titleSpacing: titleSpacing,
        shape: shape,
        toolbarHeight: toolbarHeight,
        leadingWidth: leadingWidth,
        toolbarTextStyle: toolbarTextStyle,
        titleTextStyle: titleTextStyle,
        systemOverlayStyle: systemOverlayStyle,
        scrolledUnderElevation: scrolledUnderElevation,
        notificationPredicate: notificationPredicate,
        surfaceTintColor: surfaceTintColor,
        toolbarOpacity: toolbarOpacity,
        bottomOpacity: bottomOpacity,
      );
    } else {
      final bottomHeight = bottom?.preferredSize.height ?? 0;
      final height =
          max(context.mediaQuery.size.height / 5, 120.0) + bottomHeight;
      final padding = titlePadding.resolve(TextDirection.ltr);
      final scaffold = Scaffold.maybeOf(context);
      final parentRoute = ModalRoute.of(context);
      final hasDrawer = scaffold?.hasDrawer ?? false;
      final hasEndDrawer = scaffold?.hasEndDrawer ?? false;
      final canPop = parentRoute?.canPop ?? false;
      final hasLeading = (automaticallyImplyLeading &&
              (hasDrawer || (!hasEndDrawer && canPop))) ||
          leading != null;
      final showLeading = leading != null ||
          hasDrawer ||
          (!hasEndDrawer && canPop) ||
          (parentRoute?.impliesAppBarDismissal ?? false);
      final titleSpacing = _leadingSpace(context, showLeading);
      final trailingSpacing = _trailingSpace(context, showLeading);
      final optimizedTitlePadding = EdgeInsets.fromLTRB(
        padding.left +
            (hasLeading ? (leadingWidth ?? _kLeadingWidth) : 0) +
            (titleSpacing ?? NavigationToolbar.kMiddleSpacing),
        padding.top,
        padding.right,
        padding.bottom + (subtitle != null ? 8 : 16) + bottomHeight,
      );
      return SliverAppBar(
        key: key,
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: _titlePosition == UniversalAppBarTitlePosition.top
            ? mergedTitle
            : null,
        actions: actions.isNotEmpty
            ? [...actions!, SizedBox(width: trailingSpacing)]
            : null,
        flexibleSpace: flexibleSpace ??
            (_titlePosition == UniversalAppBarTitlePosition.bottom
                ? FlexibleSpaceBar(
                    title: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: centerTitle
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            DefaultTextStyle(
                              style: Theme.of(context).textTheme.titleLarge ??
                                  const TextStyle(),
                              child: title!,
                            ),
                          if (subtitle != null)
                            DefaultTextStyle(
                              style: Theme.of(context).textTheme.labelSmall ??
                                  const TextStyle(),
                              child: subtitle!,
                            ),
                        ],
                      ),
                    ),
                    background: background,
                    titlePadding: optimizedTitlePadding,
                    centerTitle: centerTitle,
                  )
                : null),
        bottom: bottom,
        elevation: elevation,
        shadowColor: shadowColor,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        iconTheme: iconTheme,
        actionsIconTheme: actionsIconTheme,
        primary: primary,
        centerTitle: centerTitle,
        excludeHeaderSemantics: excludeHeaderSemantics,
        titleSpacing: this.titleSpacing ?? titleSpacing,
        collapsedHeight: _collapsedHeightFromStyle,
        expandedHeight: expandedHeight ?? height,
        floating: _floatingFromStyle,
        pinned: _pinnedFromStyle,
        snap: snap,
        stretch: stretch,
        stretchTriggerOffset: stretchTriggerOffset,
        onStretchTrigger: onStretchTrigger,
        shape: shape,
        toolbarHeight: toolbarHeight,
        leadingWidth: leadingWidth,
        toolbarTextStyle: toolbarTextStyle,
        titleTextStyle: titleTextStyle,
        systemOverlayStyle: systemOverlayStyle,
        scrolledUnderElevation: scrolledUnderElevation,
        surfaceTintColor: surfaceTintColor,
      );
    }
  }

  UniversalAppBarTitlePosition get _titlePosition {
    if (titlePosition != UniversalAppBarTitlePosition.flexible) {
      return titlePosition;
    }
    if (!(UniversalPlatform.isDesktop || UniversalPlatform.isWeb)) {
      return UniversalAppBarTitlePosition.bottom;
    }
    return UniversalAppBarTitlePosition.top;
  }

  bool get _floatingFromStyle {
    switch (scrollStyle) {
      case UniversalAppBarScrollStyle.floating:
        return true;
      case UniversalAppBarScrollStyle.hidden:
      case UniversalAppBarScrollStyle.pinned:
        return false;
      default:
        return floating;
    }
  }

  bool get _pinnedFromStyle {
    switch (scrollStyle) {
      case UniversalAppBarScrollStyle.pinned:
        return true;
      case UniversalAppBarScrollStyle.hidden:
      case UniversalAppBarScrollStyle.floating:
        return false;
      default:
        return pinned;
    }
  }

  double? get _collapsedHeightFromStyle {
    switch (scrollStyle) {
      case UniversalAppBarScrollStyle.pinned:
        return kToolbarHeight + 1;
      case UniversalAppBarScrollStyle.hidden:
      case UniversalAppBarScrollStyle.floating:
        return null;
      default:
        return collapsedHeight;
    }
  }

  bool _useSliverAppBar(BuildContext context) {
    return sliver;
  }

  double? _leadingSpace(BuildContext context, bool showLeading) {
    if (titleSpacing != null) {
      return titleSpacing;
    }
    final width = MediaQuery.of(context).size.width;
    final breakpoint =
        this.breakpoint ?? ResponsiveScaffold.of(context)?.breakpoint;
    if (breakpoint == null) {
      return null;
    }
    double spacing = (width - breakpoint.width(context)) / 2.0;
    if (showLeading) {
      spacing -= leadingWidth ?? _kLeadingWidth;
    } else {
      spacing = spacing.limitLow(NavigationToolbar.kMiddleSpacing * 2.0);
    }
    return spacing.limitLow(NavigationToolbar.kMiddleSpacing);
  }

  double? _trailingSpace(BuildContext context, bool showLeading) {
    if (actions.isEmpty) {
      return 0.0;
    }
    final width = MediaQuery.of(context).size.width;
    final breakpoint =
        this.breakpoint ?? ResponsiveScaffold.of(context)?.breakpoint;
    if (breakpoint == null) {
      return null;
    }
    double spacing = (width - breakpoint.width(context)) / 2.0;
    return spacing.limitLow(0.0);
  }

  PreferredSizeWidget _buildUnsliverAppBar(BuildContext context) {
    return ResponsiveAppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: _mobileAppBarTitle(
        context,
        title: title,
        subtitle: subtitle,
        centerTitle: centerTitle,
      ),
      elevation: elevation,
      shadowColor: shadowColor,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      shape: shape,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  Widget? _mobileAppBarTitle(
    BuildContext context, {
    Widget? title,
    Widget? subtitle,
    bool centerTitle = false,
  }) {
    return subtitle == null
        ? title
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: centerTitle
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              if (title != null) title,
              DefaultTextStyle(
                style:
                    Theme.of(context).textTheme.labelSmall ?? const TextStyle(),
                child: subtitle,
              ),
            ],
          );
  }
}

/// Create an AppBar to provide a consistent UI across web, desktop, and mobile.
///
/// Unlike [UniversalAppBar], it creates a Sliver-like listing.
///
/// [UniversalScaffold] can be used with [UniversalAppBar] and [UniversalListView] to create a responsive modern UI.
///
/// Basically, it is used in the same way as [AppBar].
///
/// It is responsive, and [title] moves according to the set screen size by [breakpoint] of [UniversalScaffold].
///
/// By specifying [subtitle], a subtitle can be displayed below [title].
///
/// You can change the position of [title] and [subtitle] by specifying [titlePosition].
///
/// You can change the scrolling method by specifying [scrollStyle].
///
/// Webとデスクトップ、モバイルで一貫したUIを提供するためのAppBarを作成します。
///
/// [UniversalAppBar]と違い、Sliverなリストを作成します。
///
/// [UniversalScaffold]は、[UniversalAppBar]と[UniversalListView]などを使用して、UIを構築するとレスポンシブ対応なモダンUIが作成可能です。
///
/// 基本的には[AppBar]と同じように使用します。
///
/// レスポンシブ対応しており、[UniversalScaffold]の[breakpoint]によって、設定された画面サイズに応じて、[title]が移動します。
///
/// [subtitle]を指定することで、[title]の下にサブタイトルを表示することができます。
///
/// [titlePosition]を指定して、[title]および[subtitle]の位置を変更することができます。
///
/// [scrollStyle]を指定することでスクロールの方法を変更することができます。
class UniversalSliverAppBar extends UniversalAppBar {
  /// Create an AppBar to provide a consistent UI across web, desktop, and mobile.
  ///
  /// Unlike [UniversalAppBar], it creates a Sliver-like listing.
  ///
  /// [UniversalScaffold] can be used with [UniversalAppBar] and [UniversalListView] to create a responsive modern UI.
  ///
  /// Basically, it is used in the same way as [AppBar].
  ///
  /// It is responsive, and [title] moves according to the set screen size by [breakpoint] of [UniversalScaffold].
  ///
  /// By specifying [subtitle], a subtitle can be displayed below [title].
  ///
  /// You can change the position of [title] and [subtitle] by specifying [titlePosition].
  ///
  /// You can change the scrolling method by specifying [scrollStyle].
  ///
  /// Webとデスクトップ、モバイルで一貫したUIを提供するためのAppBarを作成します。
  ///
  /// [UniversalAppBar]と違い、Sliverなリストを作成します。
  ///
  /// [UniversalScaffold]は、[UniversalAppBar]と[UniversalListView]などを使用して、UIを構築するとレスポンシブ対応なモダンUIが作成可能です。
  ///
  /// 基本的には[AppBar]と同じように使用します。
  ///
  /// レスポンシブ対応しており、[UniversalScaffold]の[breakpoint]によって、設定された画面サイズに応じて、[title]が移動します。
  ///
  /// [subtitle]を指定することで、[title]の下にサブタイトルを表示することができます。
  ///
  /// [titlePosition]を指定して、[title]および[subtitle]の位置を変更することができます。
  ///
  /// [scrollStyle]を指定することでスクロールの方法を変更することができます。
  const UniversalSliverAppBar({
    super.key,
    super.leading,
    super.automaticallyImplyLeading = true,
    super.title,
    super.subtitle,
    super.actions,
    super.flexibleSpace,
    super.titlePosition = UniversalAppBarTitlePosition.flexible,
    super.bottom,
    super.elevation,
    super.shadowColor,
    super.backgroundColor,
    super.foregroundColor,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary = true,
    super.centerTitle = false,
    super.excludeHeaderSemantics = false,
    super.titleSpacing,
    super.titlePadding = EdgeInsets.zero,
    super.collapsedHeight,
    super.expandedHeight,
    super.floating = true,
    super.pinned = false,
    super.snap = false,
    super.stretch = false,
    super.stretchTriggerOffset = 100.0,
    super.onStretchTrigger,
    super.shape,
    super.toolbarHeight = kToolbarHeight + 1,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.background,
    super.scrollStyle = UniversalAppBarScrollStyle.pinned,
    super.breakpoint,
  }) : super._(sliver: true);
}

/// [AppBar] background widget available in [UniversalAppBar].
///
/// Pass to [UniversalAppBar.background].
///
/// Specify [image] to set the background image.
///
/// [filterColor] allows you to apply a filter to the background image.
///
/// [UniversalAppBar]で利用可能な[AppBar]の背景ウィジェット。
///
/// [UniversalAppBar.background]に渡します。
///
/// [image]を指定して、背景画像を設定します。
///
/// [filterColor]で、背景画像にフィルターをかけることができます。
class UniversalAppBarBackground extends StatelessWidget {
  /// [AppBar] background widget available in [UniversalAppBar].
  ///
  /// Pass to [UniversalAppBar.background].
  ///
  /// Specify [image] to set the background image.
  ///
  /// [filterColor] allows you to apply a filter to the background image.
  ///
  /// [UniversalAppBar]で利用可能な[AppBar]の背景ウィジェット。
  ///
  /// [UniversalAppBar.background]に渡します。
  ///
  /// [image]を指定して、背景画像を設定します。
  ///
  /// [filterColor]で、背景画像にフィルターをかけることができます。
  const UniversalAppBarBackground(
    this.image, {
    super.key,
    this.filterColor = Colors.black87,
    this.fit = BoxFit.cover,
  });

  /// Specifies a background image.
  ///
  /// 背景画像を指定します。
  final ImageProvider image;

  /// Specifies how the image is scaled.
  ///
  /// 画像の拡大縮小方法を指定します。
  final BoxFit fit;

  /// Specifies a filter color.
  ///
  /// フィルターの色を指定します。
  final Color filterColor;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      fit: fit,
      color: filterColor,
      colorBlendMode: BlendMode.multiply,
    );
  }
}

/// Specify the position of the title to be used in [UniversalSliverAppBar].
///
/// If [flexible] is specified, the position of [UniversalSliverAppBar.title] and [UniversalSliverAppBar.subtitle] will change according to the platform.
///
/// For mobile, [UniversalSliverAppBar.title] and [UniversalSliverAppBar.subtitle] will appear below.
///
/// For web and desktop, [UniversalSliverAppBar.title] and [UniversalSliverAppBar.subtitle] will appear on top.
///
/// [UniversalSliverAppBar]で利用するタイトルの位置を指定します。
///
/// [flexible]を指定すると、プラットフォームに応じて[UniversalSliverAppBar.title]と[UniversalSliverAppBar.subtitle]の位置が変わります。
///
/// モバイルの場合は、[UniversalSliverAppBar.title]と[UniversalSliverAppBar.subtitle]が下に表示されます。
///
/// Webやデスクトップの場合は、[UniversalSliverAppBar.title]と[UniversalSliverAppBar.subtitle]が上に表示されます。
enum UniversalAppBarTitlePosition {
  /// The position of [UniversalSliverAppBar.title] and [UniversalSliverAppBar.subtitle] changes depending on the platform.
  ///
  /// For mobile, [UniversalSliverAppBar.title] and [UniversalSliverAppBar.subtitle] will appear below.
  ///
  /// For web and desktop, [UniversalSliverAppBar.title] and [UniversalSliverAppBar.subtitle] will appear on top.
  ///
  /// プラットフォームに応じて[UniversalSliverAppBar.title]と[UniversalSliverAppBar.subtitle]の位置が変わります。
  ///
  /// モバイルの場合は、[UniversalSliverAppBar.title]と[UniversalSliverAppBar.subtitle]が下に表示されます。
  ///
  /// Webやデスクトップの場合は、[UniversalSliverAppBar.title]と[UniversalSliverAppBar.subtitle]が上に表示されます。
  flexible,

  /// [UniversalSliverAppBar.title] and [UniversalSliverAppBar.subtitle] will appear on top.
  ///
  /// [UniversalSliverAppBar.title]と[UniversalSliverAppBar.subtitle]が上に表示されます。
  top,

  /// [UniversalSliverAppBar.title] and [UniversalSliverAppBar.subtitle] will appear below.
  ///
  /// [UniversalSliverAppBar.title]と[UniversalSliverAppBar.subtitle]が下に表示されます。
  bottom,
}

/// Specify the scrolling method in [UniversalSliverAppBar].
///
/// If [inherit], the values of [UniversalSliverAppBar.floating] and [UniversalSliverAppBar.pinned] are used.
///
/// When [hidden], [AppBar] is hidden when scrolling.
///
/// When [floating], [AppBar] will appear above the background when scrolling.
///
/// If [pinned], [AppBar] will be fixed at the top of the screen when scrolling.
///
/// [UniversalSliverAppBar]でのスクロール方法を指定します。
///
/// [inherit]の場合、[UniversalSliverAppBar.floating]と[UniversalSliverAppBar.pinned]の値を利用します。
///
/// [hidden]の場合、[AppBar]がスクロール時に隠れます。
///
/// [floating]の場合、スクロール時に背景の上に[AppBar]が表示されるようになります。
///
/// [pinned]の場合、スクロール時に画面の一番上に[AppBar]が固定されるようになります。
enum UniversalAppBarScrollStyle {
  /// [UniversalSliverAppBar.floating] and [UniversalSliverAppBar.pinned].
  ///
  /// [UniversalSliverAppBar.floating]と[UniversalSliverAppBar.pinned]の値を利用します。
  inherit,

  /// [AppBar] is hidden when scrolling.
  ///
  /// [AppBar]がスクロール時に隠れます。
  hidden,

  /// [AppBar] will appear above the background when scrolling.
  ///
  /// スクロール時に背景の上に[AppBar]が表示されるようになります。
  floating,

  /// [AppBar] will be fixed at the top of the screen when scrolling.
  ///
  /// スクロール時に画面の一番上に[AppBar]が固定されるようになります。
  pinned,
}
