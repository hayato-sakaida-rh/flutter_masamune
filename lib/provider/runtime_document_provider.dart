part of masamune;

/// Base class for holding and manipulating data from a runtime database as a document of [T].
///
/// The [load()] method retrieves the value from the local database and
/// the [save()] method saves the value to the local database.
///
/// The local database is a Json database.
/// Specify a path to specify the location of the contents.
///
/// In addition, since it can be used as [Map],
/// it is possible to operate the content as it is.
final runtimeDocumentProvider =
    ChangeNotifierProvider.family<RuntimeDynamicDocumentModel, String>(
  (_, path) => RuntimeDynamicDocumentModel(path),
);
