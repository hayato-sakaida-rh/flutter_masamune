// Copyright 2022 mathru. All rights reserved.

/// Package that improvement of routing.
///
/// To use, import `package:katana_router/katana_router.dart`.
///
/// [mathru.net]: https://mathru.net
/// [YouTube]: https://www.youtube.com/c/mathrunetchannel
library katana_router;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katana/katana.dart';
import 'package:url_strategy/url_strategy.dart' as url_strategy;

export 'package:katana/katana.dart';
export 'package:katana_router_annotation/katana_router_annotation.dart';

part "src/extensions.dart";
part "src/page_query.dart";
part 'src/page_query_builder.dart';
part 'src/page_route_query.dart';
part 'src/page_widget.dart';
part 'src/redirect_query.dart';
part "src/route_query.dart";
part 'src/route_query_type.dart';
part 'src/app_router.dart';
part 'src/app_route_information_parser.dart';
part 'src/app_router_delegate.dart';
part 'src/app_route_information_provider.dart';
