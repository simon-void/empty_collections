// Copyright (c) 2016, Stephan Schröder. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be found
// in the LICENSE file.

/// The package empty_collections contains const implementations for several
/// collection classes that allow access to there remove-functionality:
/// [EmptyIterator], [EmptyIterable], [EmptySet], [EmptyMap], [EmptyList],
/// [EmptyLinkedList] and [EmptyQueue].
/// All these classes have been implemented as permanently empty collection
/// class which are instanciable by a const constructor.
/// This makes these classes quite efficient and e.g.
/// usefull as default arguments for optional parameters.
/// The difference from other unmodifiable implementations
/// (e.g. const [], const {}, const UnmodifiableSetView.empty() from the
/// collection package) is that these classes don't adhere to the
/// unmodifiable convention that disallows both adding methodes
/// (like add(...), insert(...), putIfAbsent(...), []=, ...) and
/// removing methodes (like remove(...), clear(), retainWhere(...), ...).
/// The thing is for empty collections the normal remove semantic doesn't
/// change the state of the collection! E.g. a call to emptySet.clear() does
/// nothing on an empty set, a call to emptyList.remove(o) will just return
/// false, because o wasn't an element of the empty list to start with.
/// So there is no harm in allowing remove-functionality
/// while the adding-functionlity is still of limits.

library empty_collections;

export 'src/empty_collections_base.dart';
