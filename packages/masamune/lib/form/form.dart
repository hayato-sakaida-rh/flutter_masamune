part of '/masamune.dart';

/// Create an extension method for [RefHasPage] to handle Query for form.
///
/// フォーム用のQueryを処理するための[RefHasPage]の拡張メソッドを作成します。
extension MasamuneFormRefHasPageExtensions on RefHasPage {
  /// [FormController] is obtained by passing [FormControllerQueryBase] for the form generated by the builder.
  ///
  /// The state is always saved in page scope.
  ///
  /// ビルダーによりコード生成されたフォーム用の[FormControllerQueryBase]を渡すことにより状態を保持された[FormController]を取得します。
  ///
  /// かならずページスコープで状態が保存されます。
  ///
  /// ```dart
  /// final userController = ref.form(UserFormController.query()); // Get the user form controller.
  /// ```
  FormController<TModel> form<TModel>(
    FormControllerQueryBase<TModel> query,
  ) {
    // ignore: invalid_use_of_protected_member
    return page.query(query);
  }
}

/// Extension methods for [ControllerQueryBase<FormController>].
///
/// [ControllerQueryBase<FormController>]の拡張メソッドです。
extension FormControllerQueryBaseExtensions<TModel>
    on FormControllerQueryBase<TModel> {
  /// Get [FormController<TModel>] while monitoring it with the widget associated with [ref] in the same way as `ref.page.controller`.
  ///
  /// `ref.page.controller`と同じように[ref]に関連するウィジェットで監視を行いつつ[FormController<TModel>]を取得します。
  FormController<TModel> watch(RefHasPage ref) {
    return ref.form(this);
  }
}

/// Base class for creating state-to-state usage queries for [FormController] that are code-generated by the builder.
///
/// Basically, you can get a class that inherits from [ChangeNotifier].
///
/// ビルダーによりコード生成する[FormController]の状態間利用クエリを作成するためのベースクラス。
///
/// 基本的には[ChangeNotifier]を継承したクラスを取得することが出来ます。
abstract class FormControllerQueryBase<TModel>
    extends ControllerQueryBase<FormController<TModel>> {
  /// Base class for creating state-to-state usage queries for [FormController] that are code-generated by the builder.
  ///
  /// Basically, you can get a class that inherits from [ChangeNotifier].
  ///
  /// ビルダーによりコード生成する[FormController]の状態間利用クエリを作成するためのベースクラス。
  ///
  /// 基本的には[ChangeNotifier]を継承したクラスを取得することが出来ます。
  const FormControllerQueryBase();
}
