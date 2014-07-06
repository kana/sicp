# Exercise 2.76.

> As a large system with generic operations evolves, new types of data
> objects or new operations may be needed. For each of the three strategies
> -- generic operations with explicit dispatch, data-directed style, and
> message-passing-style -- describe the changes that must be made to a system
> in order to add new types or new operations.

* Generic operations with explicit dispatch

    * Whenever new types of data objects are introduced,
      all generic operations have to be updated to support the new types
      by adding more explicit dispatches.  To do this, we have to change the
      existing definitions of all operations.  So that it's not additive.

    * Whenever new operations are introduced,
      the new operations have to include explicit dispatch for all types.
      It's additive, but combersome.

* Data-directed style

    * Whenever new types of data objects are introduced,
      we have to write packages to support the new types to be applicable to
      existing operations.  It's additive and easy to maintain because
      operations for a specific type is put into a single package.

    * Whenever new operations are introduced,
      we have to update existing packages.
      It's not additive, but maintainable.

* Message-passing style

    * Whenever new types of data objects are introduced,
      we have to write data constructors for these types.
      It's additive.

    * Whenever new operations are introduced, we have to change the existing
      data constructors to support the operations.  It's not additive.


> Which organization would be most appropriate for a system in which new
> types must often be added?

Message-passing style is the most appropriate one.  Because we don't have to
change data constructors of existing types whenever new types are added.


> Which would be most appropriate for a system in which new operations must
> often be added?

Explicit dispatch is not additive for both new operations and new types.  But
both data-directed style and message-passing style are not additive for new
operations.  So that it depends on applications.
