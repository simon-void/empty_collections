# empty_collections

The package empty_collections contains **const implementations** for several **collection classes that allow access
to there remove-functionality**:

`const EmptyIterator`, `const EmptyIterable`, `const EmptySet`, `const EmptyMap`, `const EmptyList`,
`const EmptyLinkedList` and `const EmptyQueue`.

All these classes have been **implemented as permanently empty collection classes with a const constructor**.
This makes these classes highly efficient and e.g. usable as default arguments for optional parameters.
The difference from other unmodifiable implementations (e.g. `const []`, `const {}`, `const UnmodifiableSetView.empty()`
from the *collection package*) is that these **classes don't adhere to the unmodifiable convention** that disallows
both: adding methodes (like add(...), insert(...), putIfAbsent(...), []=, ...) and 
removing methodes (like remove(...), clear(), retainWhere(...), ...).
The thing is **for empty collections the normal remove semantic doesn't change the state of the collection**!
E.g. a call to `emptySet.clear()` does nothing on an empty set,
a call to `emptyList.remove(o)` will just return `false`, because o wasn't an element of the empty list to start with.

**So there is no harm in allowing remove-functionality** while the adding-functionlity is still of limits.

## Usage

A simple usage example:

    import 'package:empty_collections/empty_collections.dart';

    main() {
      // use empty collection as default values
      var args = const EmptyList();
      if(userProvidesArgs()) {
        args = getUserProvidedArgs();
      }
      // remove-functionality doesn't throw exceptions!
      // in this specific case remove returns false
      // because "stupid option" wasn't an element of the empty list to start with
      args.remove("stupid option");
      
      // if you want to make sure you can add elements at some point, use toList(growable: true)
       args = args.toList(growable: true);
       args.add("important option");
       ...
    }
    
    // use empty collections as default values for optional parameters
    void someMethodeWithOptionParameter([Map<String, String> environmentVariables = const EmptyMap, bool ignoreEnv = true]) {
      if(ignoreEnv) {
        // empty collections can be cleared without problems (because they are already empty to start with)
        environmentVariables.clear();
      }
      ...
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/simon-void/empty_collections/issues).
