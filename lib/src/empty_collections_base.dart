// Copyright (c) 2016, Stephan Schröder. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be found
// in the LICENSE file.

import 'dart:collection';
import 'dart:core';
import 'dart:math';

//adding some helper functions for throwing common errors
/// Throws an [UnsupportedError];
/// because adding-operations are not allowed for empty collections.
_throwNoAddingOps() {
  throw new UnsupportedError(
      "Cannot call add operations on a const empty collection.");
}

/// Throws a [RangeError];
/// error msg contains [index] as debug info.
_throwIndexOutOfBounds(int index) {
  throw new RangeError(
      "Invalid index [$index]: an empty collection has no elements.");
}

/// Throws a [RangeError];
/// error msg contains [start] and [end] as debug info.
_throwRangeOutOfBounds(int start, int end) {
  throw new RangeError(
      "Invalid range [$start, $end]: an empty collection has no elements. "
      "Only the empty range start:0, end:0 is allowed.");
}

/// Throws a [StateError];
/// some methods assume that there is at least one elemet present.
_throwNoSuchElement() {
  throw new StateError("no element in empty collection");
}

/// Throws a RangeError if [i] is negative.
_assertNotNegative(int i, String name) {
  RangeError.checkNotNegative(i, name, "mustn't be negative but is");
}

class EmptyIterator<E> implements Iterator<E> {
  /// Always returns null.
  @override
  get current => null;

  const EmptyIterator();

  /// Always returns false.
  @override
  bool moveNext() {
    return false;
  }

  @override
  String toString() => "()";
}

class EmptyIterable<E> implements Iterable<E> {
  const EmptyIterable();

  /// Returns an empty iterator.
  @override
  Iterator<E> get iterator => const EmptyIterator();

  @override
  bool any(bool f(E element)) => false;

  /// Returns itself; because this is already an empty iterable.
  @override
  Iterable<R> cast<R>() => this as Iterable<R>;

  @override
  bool contains(Object element) => false;

  /// Throws a RangeError.
  @override
  E elementAt(int index) => _throwIndexOutOfBounds(index);

  /// Returns true; because an empty iterable doesn't have an element for
  /// which the predicate could return false.
  @override
  bool every(bool f(E element)) => true;

  /// Returns itself; because this is already an empty iterable.
  /// So there is nothing to expand.
  @override
  Iterable<T> expand<T>(Iterable<T> f(E element)) => this as Iterable<T>;

  /// Throws a [StateError];
  /// because there is no such element.
  @override
  E get first => _throwNoSuchElement();

  /// Returns the result of [orElse] if such a function is provided.
  /// Throws an StateError otherwise.
  @override
  E firstWhere(bool test(E element), {E orElse()}) {
    if (orElse == null) {
      _throwNoSuchElement();
    }
    return orElse();
  }

  /// Returns [initialValue]; because there is nothing to combine.
  @override
  T fold<T>(T initialValue, T combine(T previousValue, E element)) => initialValue;

  /// Returns other; because this Iterator is empty.
  @override
  Iterable<E> followedBy(Iterable<E> other) => other;

  // Does nothing.
  @override
  void forEach(void f(E element)) {}

  @override
  bool get isEmpty => true;

  @override
  bool get isNotEmpty => false;

  /// Returns an empty string.
  @override
  String join([String separator = ""]) => "";

  /// Throws a [StateError];
  /// because there is no such element.
  @override
  E get last => _throwNoSuchElement();

  /// Returns the result of [orElse] if such a function is provided.
  /// Throws an StateError otherwise.
  @override
  E lastWhere(bool test(E element), {E orElse()}) {
    if (orElse == null) {
      _throwNoSuchElement();
    }
    return orElse();
  }

  /// Returns 0.
  @override
  int get length => 0;

  /// Returns itself; because an empty iterable is an empty iterable
  /// and i can't create type information with a const constructor anyway.
  @override
  Iterable<T> map<T>(T f(E e)) => EmptyIterable<T>();

  /// Throws a [StateError];
  /// because there is no element available.
  @override
  E reduce(E combine(E value, E element)) => _throwNoSuchElement();

  /// Throws a [StateError];
  /// because there is no such element.
  @override
  E get single => _throwNoSuchElement();

  /// Throws a [StateError];
  /// because there is no such element.
  @override
  E singleWhere(bool test(E element), {E orElse()}) => _throwNoSuchElement();

  /// Throws a RangeError if count is negative.
  /// Returns itself otherwise; because this is already an empty iterable.
  @override
  Iterable<E> skip(int count) {
    _assertNotNegative(count, "count");
    return this;
  }

  /// Returns itself; because this is already an empty iterable.
  @override
  Iterable<E> skipWhile(bool test(E value)) => this;

  /// Throws a RangeError if count is negative.
  /// Returns itself otherwise; because this is already an empty iterable.
  @override
  Iterable<E> take(int count) {
    _assertNotNegative(count, "count");
    return this;
  }

  /// Returns itself; because this is already an empty iterable.
  @override
  Iterable<E> takeWhile(bool test(E value)) => this;

  /// If [growable] is true (which is the default)
  /// new List.from(this, growable: true) is returned,
  /// otherwise an const EmptyList() which is more efficient than new List(0)
  @override
  List<E> toList({bool growable: true}) {
    if (growable) {
      return new List.from(this, growable: true);
    }
    return const EmptyList();
  }

  /// The documentation says nothing about the behaviour of the resulting set,
  /// so an empty  standard set is returned (new Set()) to which new elements
  /// can be added.
  @override
  Set<E> toSet() => new Set();

  @override
  String toString() => "()";

  /// Returns itself; because this is already an empty iterable.
  @override
  Iterable<E> where(bool f(E element)) => this;

  /// Returns itself; because this is already an empty iterable.
  @override
  Iterable<T> whereType<T>() => this as Iterable<T>;
}

/// An empty set that doesn't allow adding-operations.
/// Removing-operations (like [remove], [clear], [retainWhere], ...) are ok,
/// because the don't modify the contents of an empty set.
class EmptySet<E> extends EmptyIterable<E> implements Set<E> {
  const EmptySet();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  bool add(E value) => _throwNoAddingOps();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void addAll(Iterable<E> elements) => _throwNoAddingOps();

  /// returns itself because an empty Sets can switch its containee's type.
  Set<R> cast<R>() => this as Set<R>;

  /// Empty set is already empty. Has no effect.
  @override
  void clear() {}

  /// Returns if true if [other] is empty, false otherwise.
  @override
  bool containsAll(Iterable<Object> other) => other.isEmpty;

  /// Returns always null;
  /// The empty set doesn't contain any elements and therefore returns null.
  @override
  E lookup(Object element) => null;

  /// Always returns false because the empty set didn't contain the element.
  @override
  bool remove(Object element) => false;

  /// Empty set is already empty. Has no effect.
  @override
  void removeAll(Iterable<Object> elements) {}

  /// Empty set is already empty. Has no effect.
  @override
  void removeWhere(bool test(E element)) {}

  /// Does nothing.
  /// The empty set doesn't contain any elements and therefore can't remove one.
  @override
  void retainWhere(bool test(E element)) {}

  /// Doesn't do anything;
  /// An optional remove on an empty set changes nothing.
  @override
  void retainAll(Iterable<Object> elements) {}

  /// Returns a copy of other;
  /// union with an empty set leads to a copy.
  @override
  Set<E> union(Set<E> other) => new Set.from(other);

  /// Returns an empty set;
  /// there are no elements in this (empty) set that are also in other.
  @override
  Set<E> intersection(Set<Object> other) => new Set();

  /// Returns an empty set;
  /// there are no elements in this (empty) set that aren't in other.
  @override
  Set<E> difference(Set<Object> other) => new Set();
}

/// An empty map that doesn't allow adding-operations
/// (like [putIfAbsent] or the []=operator).
/// Removing-operations ([remove] and [clear]) are ok,
/// because the don't modify the contents of an empty map.
class EmptyMap<K, V> implements Map<K, V> {

  @override
  Iterable<MapEntry<K, V>> get entries => const EmptyIterable();

  @override
  bool get isEmpty => true;

  @override
  bool get isNotEmpty => false;

  @override
  Iterable<K> get keys => const EmptyIterable();

  @override
  int get length => 0;

  @override
  Iterable<V> get values => const EmptyIterable();

  const EmptyMap();

  /// Always returns null because no key is in the empty map
  @override
  V operator [](Object key) {
    return null;
  }

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void operator []=(K key, V value) {
    _throwNoAddingOps();
  }

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void addAll(Map<K, V> other) {
    _throwNoAddingOps();
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    _throwNoAddingOps();
  }

  @override
  Map<RK, RV> cast<RK, RV>() => this as Map<RK, RV>;

  /// empty map is empty, so nothing needs to change
  @override
  void clear() {}

  @override
  bool containsKey(Object key) => false;

  @override
  bool containsValue(Object value) => false;

  @override
  void forEach(void f(K key, V value)) {}

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) f) => this as Map<K2, V2>;

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  putIfAbsent(K key, V ifAbsent()) {
    _throwNoAddingOps();
  }

  /// Always returns false;
  /// because [value] is guaranteed not to be contained in an empty collection.
  @override
  V remove(Object key) => null;

  @override
  void removeWhere(bool Function(K key, V value) predicate) {}

  @override
  String toString() => "{}";

  @override
  update(K key, V Function(V value) update, {V Function() ifAbsent}) {
    _throwNoAddingOps();
  }

  @override
  void updateAll(V Function(K key, V value) update) {}
}

/// An empty list that doesn't allow adding-operations.
/// Removing-operations (like [remove], [clear], [retainWhere], ...) are ok,
/// because the don't modify the contents of an empty list.
class EmptyList<E> extends EmptyIterable<E> implements List<E> {
  const EmptyList();

  @override
  operator [](int index) {
    _throwIndexOutOfBounds(index);
  }

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void operator []=(int index, E value) {
    _throwNoAddingOps();
  }

  @override
  List<E> operator +(List<E> other) => new List.from(other);

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void add(E value) {
    _throwNoAddingOps();
  }

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void addAll(Iterable<E> iterable) {
    _throwNoAddingOps();
  }

  /// According to the documentation of Map.asMap the resulting map
  /// has to be unmodifiable so a const {} is returned.
  /// This is choosen over a const EmptyMap() because the word "unmodifiable"
  /// is linked to the expectation that remove-operations (and such) will
  /// fail instead of be handled gracefully.
  @override
  Map<int, E> asMap() => const {};

  List<R> cast<R>() => this as List<R>;

  /// Does nothing; because this collection is already empty.
  @override
  void clear() {}

  /// Throws an exception if start and end don't define the empty range
  /// (are both 0).
  @override
  void fillRange(int start, int end, [E fillValue]) {
    if (start != 0 || end != 0) {
      _throwNoAddingOps();
    }
  }

  @override
  set first(E value) {
    _throwNoAddingOps();
  }

  /// Returns an empty iterable if start and end define the empty range
  /// (are both 0).
  /// Throws a RangeError elsewise.
  @override
  Iterable<E> getRange(int start, int end) {
    if (start != 0 || end != 0) {
      _throwRangeOutOfBounds(start, end);
    }
    return const EmptyIterable();
  }

  @override
  int indexOf(E element, [int start = 0]) => -1;

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) => -1;

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void insert(int index, E element) {
    _throwNoAddingOps();
  }

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void insertAll(int index, Iterable<E> iterable) {
    _throwNoAddingOps();
  }

  @override
  set last(E value) {
    _throwNoAddingOps();
  }

  @override
  int lastIndexOf(E element, [int start]) => -1;

  @override
  int lastIndexWhere(bool Function(E element) test, [int start]) => -1;

  /// Throws an [UnsupportedError] because this list is fixed length (to 0).
  @override
  set length(int newLength) {
    if(newLength!=0) {
      throw new UnsupportedError("Cannot change the size of an empty list");
    }
  }

  /// Always returns false;
  /// because [value] is guaranteed not to be contained in an empty collection.
  @override
  bool remove(Object value) => false;

  /// Throws an [RangeError]; because this list is empty.
  @override
  removeAt(int index) {
    _throwIndexOutOfBounds(index);
  }

  /// [].removeLast() throws a RangeError so
  /// this implementation throws a RangeError.
  @override
  removeLast() {
    _throwNoSuchElement();
  }

  /// Throws an exception if start and end don't define the empty range
  /// (are both 0).
  @override
  void removeRange(int start, int end) {
    if(start!=0 || end!=0) {
      _throwRangeOutOfBounds(start, end);
    }
  }

  /// Changes nothing because this list is already empty.
  @override
  void removeWhere(bool test(E element)) {}

  /// Throws an exception if start and end don't define the empty range
  /// (are both 0).
  @override
  void replaceRange(int start, int end, Iterable<E> replacement) {
    if(start!=0 || end!=0) {
      _throwRangeOutOfBounds(start, end);
    }
  }

  @override
  void retainWhere(bool test(E element)) {}

  @override
  Iterable<E> get reversed => const EmptyIterable();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void setAll(int index, Iterable<E> iterable) {
    _throwNoAddingOps();
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    if(start!=0 || end!=0) {
      _throwRangeOutOfBounds(start, end);
    }
  }

  @override
  void shuffle([Random random]) {}

  @override
  void sort([int compare(E a, E b)]) {}

  @override
  List<E> sublist(int start, [int end]) {
    if(end==null) {
      end = 0;
    }
    if(start!=0 || end!=0) {
      _throwRangeOutOfBounds(start, end);
    }
    return this;
  }
}

/// An empty linked list that doesn't allow adding-operations (like [add]).
/// Removing-operations (like [remove] and [clear]) are ok,
/// because the don't modify the contents of an empty linked list.
class EmptyLinkedList<E extends LinkedListEntry<E>> extends EmptyIterable<E>
    implements LinkedList<E> {

  const EmptyLinkedList();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void add(E entry) => _throwNoAddingOps();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void addAll(Iterable<E> entries) => _throwNoAddingOps();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void addFirst(E entry) => _throwNoAddingOps();

  /// Does nothing; because this collection is already empty.
  @override
  void clear() {}

  /// Always returns false;
  /// because [value] is guaranteed not to be contained in an empty collection.
  @override
  bool remove(E entry) => false;
}

/// An empty queue that doesn't allow adding-operations (like [add]).
/// Removing-operations (like [remove] and [clear]) are ok,
/// because the don't modify the contents of an empty queue.
class EmptyQueue<E> extends EmptyIterable<E> implements Queue<E> {

  const EmptyQueue();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void add(E value) => _throwNoAddingOps();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void addAll(Iterable<E> iterable) => _throwNoAddingOps();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void addFirst(E value) => _throwNoAddingOps();

  /// Throws an [UnsupportedError];
  /// operations that add to the collection are disallowed.
  @override
  void addLast(E value) => _throwNoAddingOps();

  Queue<R> cast<R>()=> this as Queue<R>;

  /// Does nothing; because this collection is already empty.
  @override
  void clear() {}

  /// Always returns false;
  /// because [value] is guaranteed not to be contained in an empty collection.
  @override
  bool remove(Object value) => false;

  /// Throws a [StateError];
  /// because there is no such element.
  @override
  E removeFirst() => _throwNoSuchElement();

  /// Throws a [StateError];
  /// because there is no such element.
  @override
  E removeLast() => _throwNoSuchElement();

  @override
  void removeWhere(bool test(E element)) {}

  @override
  void retainWhere(bool test(E element)) {}
}