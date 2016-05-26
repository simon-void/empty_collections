// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:empty_collections/empty_collections.dart';

main() {
  // so basically the EmptyCollection classes work as expected as long
  // as you don't try to add stuff.
  // If that's the case they are more efficient than normal empty collection
  // instances (e.g. []), because there exists only one compile-time singelton
  // instance and which you can't use as default parameter values.
  // At the same time they are more permissive than unmodifiable versions
  // (e.g. const []) in that they allow remove-functionality to be invoked.
  bool wantEnemies = false;
  Set<String> enemyNames = getEnemiesNames();

  if(!wantEnemies) {
    // wouldn't work with an "unmodifiable"-style set
    enemyNames.clear();
  }

  print("all my enemies: $enemyNames");
}

// use of a const EmptyMap as default argument
Set<String> getEnemiesNames({Map<String, String> env: const EmptyMap()}) {
  // Throw away one optinal parameter. [env] may or may not contain it.
  // This wouldn't work with a const {} which by adhering to
  // the "unmodifiable"-contract would throw an exception.
  String deprecatedValue = env.remove("deprecatedOption");

  if(env.containsKey("serverUrl")) {
    return getEnemiesNamesFromServer(env["serverUrl"]);
  }
  return const EmptySet();
}

Set<String> getEnemiesNamesFromServer(String serverUrl) {
  // simulate a server request
  return ["Derek", "Ben", "Gillian"].toSet();
}