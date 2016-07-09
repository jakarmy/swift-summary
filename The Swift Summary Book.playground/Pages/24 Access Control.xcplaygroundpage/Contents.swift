
// |=------------------------------------------------------=|
//  Copyright (c) 2016 Juan Antonio Karmy.
//  Licensed under MIT License
//
//  See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ for Swift Language Reference
//
//  See Juan Antonio Karmy - http://karmy.co | http://twitter.com/jkarmy
//
// |=------------------------------------------------------=|


import UIKit

/*
 ==============
 Access Control
 ==============
 */

/*
 Access control restricts access to parts of your code from code in other source files and modules.
 This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.
 
 You can assign specific access levels to individual types (classes, structures, and enumerations),
 as well as to properties, methods, initializers, and subscripts belonging to those types.
 Protocols can be restricted to a certain context, as can global constants, variables, and functions.
 
 In addition to offering various levels of access control, Swift reduces the need to specify explicit access control levels
 by providing default access levels for typical scenarios. Indeed, if you are writing a single-target app,
 you may not need to specify explicit access control levels at all.
 
 NOTE
 
 The various aspects of your code that can have access control applied to them (properties, types, functions, and so on)
 are referred to as “entities” in the sections below, for brevity.
 */


/*
 Access control restricts access to parts of your code from code in other source files and modules.
 This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.
 
 You can assign specific access levels to individual types (classes, structures, and enumerations),
 as well as to properties, methods, initializers, and subscripts belonging to those types.
 Protocols can be restricted to a certain context, as can global constants, variables, and functions.
 
 In addition to offering various levels of access control, Swift reduces the need to specify explicit access control levels
 by providing default access levels for typical scenarios. Indeed, if you are writing a single-target app,
 you may not need to specify explicit access control levels at all.
 
 NOTE
 
 The various aspects of your code that can have access control applied to them (properties, types, functions, and so on)
 are referred to as “entities” in the sections below, for brevity.
 */


/*
 Swift provides three different access levels for entities within your code.
 These access levels are relative to the source file in which an entity is defined, and also relative to the module that source file belongs to.
 
 • Public access enables entities to be used within any source file from their defining module,
 and also in a source file from another module that imports the defining module.
 You typically use public access when specifying the public interface to a framework.
 
 • Internal access enables entities to be used within any source file from their defining module,
 but not in any source file outside of that module.
 You typically use internal access when defining an app’s or a framework’s internal structure.
 
 • Private access restricts the use of an entity to its own defining source file.
 Use private access to hide the implementation details of a specific piece of functionality.
 
 Public access is the highest (least restrictive) access level and private access is the lowest (or most restrictive) access level.
 
 NOTE
 
 Private access in Swift differs from private access in most other languages,
 as it’s scoped to the enclosing source file rather than to the enclosing declaration.
 This means that a type can access any private entities that are defined in the same source file as itself,
 but an extension cannot access that type’s private members if it’s defined in a separate source file.
 */


/*
 ==================================
 Guiding Principle of Access Levels
 ==================================
 */

/*
 Access levels in Swift follow an overall guiding principle:
 No entity can be defined in terms of another entity that has a lower (more restrictive) access level.
 */

/*
 Default Access Levels
 ---------------------
 
 All entities in your code (with a few specific exceptions, as described later in this chapter)
 have a default access level of internal if you do not specify an explicit access level yourself.
 As a result, in many cases you do not need to specify an explicit access level in your code.
 
 Access Levels for Single-Target Apps
 ------------------------------------
 
 When you write a simple single-target app, the code in your app is typically self-contained within
 the app and does not need to be made available outside of the app’s module.
 The default access level of internal already matches this requirement.
 Therefore, you do not need to specify a custom access level.
 You may, however, want to mark some parts of your code as private
 in order to hide their implementation details from other code within the app’s module.
 
 Access Levels for Frameworks
 ----------------------------
 
 When you develop a framework, mark the public-facing interface to that framework as public
 so that it can be viewed and accessed by other modules, such as an app that imports the framework.
 This public-facing interface is the application programming interface (or API) for the framework.
 */


/*
 =====================
 Access Control Syntax
 =====================
 */

public class SomePublicClass {}
internal class SomeInternalClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
private func somePrivateFunction() {}


/*
 ============
 Custom Types
 ============
 */

/*
 If you want to specify an explicit access level for a custom type, do so at the point that you define the type.
 The new type can then be used wherever its access level permits.
 For example, if you define a private class, that class can only be used as the type of a property,
 or as a function parameter or return type, in the source file in which the private class is defined.
 
 The access control level of a type also affects the default access level of that type’s members
 (its properties, methods, initializers, and subscripts). If you define a type’s access level as private,
 the default access level of its members will also be private. If you define a type’s access level as internal or public
 (or use the default access level of internal without specifying an access level explicitly),
 the default access level of the type’s members will be internal.
 
 NOTE
 
 As mentioned above, a public type defaults to having internal members, not public members.
 If you want a type member to be public, you must explicitly mark it as such.
 This requirement ensures that the public-facing API for a type is something you opt in to publishing,
 and avoids presenting the internal workings of a type as public API by mistake.
 */

public class SomeOtherPublicClass {          // explicitly public class
    public var somePublicProperty = 0    // explicitly public class member
    var someInternalProperty = 0         // implicitly internal class member
    private func somePrivateMethod() {}  // explicitly private class member
}

class SomeOtherInternalClass {               // implicitly internal class
    var someInternalProperty = 0         // implicitly internal class member
    private func somePrivateMethod() {}  // explicitly private class member
}

private class SomeOtherPrivateClass {        // explicitly private class
    var somePrivateProperty = 0          // implicitly private class member
    func somePrivateMethod() {}          // implicitly private class member
}


/*
 Tuple Types
 -----------
 
 The access level for a tuple type is the most restrictive access level of all types used in that tuple.
 For example, if you compose a tuple from two different types, one with internal access and one with private access,
 the access level for that compound tuple type will be private.
 
 NOTE
 
 Tuple types do not have a standalone definition in the way that classes, structures, enumerations, and functions do.
 A tuple type’s access level is deduced automatically when the tuple type is used, and cannot be specified explicitly.
 */

/*
 Function Types
 --------------
 
 The access level for a function type is calculated as the most restrictive access level of the function’s parameter types and return type.
 You must specify the access level explicitly as part of the function’s definition
 if the function’s calculated access level does not match the contextual default.
 
 The function’s return type is a tuple type composed from two of the custom classes defined above in Custom Types.
 One of these classes was defined as “internal”, and the other was defined as “private”.
 Therefore, the overall access level of the compound tuple type is “private” (the minimum access level of the tuple’s constituent types).
 
 Because the function’s return type is private, you must mark the function’s overall access level with the private modifier for the function declaration to be valid:
 */

private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
    return (SomeInternalClass(), SomePrivateClass())
}

/*
 Enumeration Types
 -----------------
 
 The individual cases of an enumeration automatically receive the same access level as the enumeration they belong to.
 You cannot specify a different access level for individual enumeration cases.
 */

/*
 ==========
 Subclasses
 ==========
 */

/*
 You can subclass any class that can be accessed in the current access context.
 A subclass cannot have a higher access level than its superclass—for example,
 you cannot write a public subclass of an internal superclass.
 
 In addition, you can override any class member (method, property, initializer, or subscript) that is visible in a certain access context.
 An override can make an inherited class member more accessible than its superclass version.
 
 It is even valid for a subclass member to call a superclass member that has lower access permissions than the subclass member,
 as long as the call to the superclass’s member takes place within an allowed access level context
 */

public class A {
    private func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

// Because superclass A and subclass B are defined in the same source file,
// it is valid for the B implementation of someMethod() to call super.someMethod().


/*
 ================================================
 Constants, Variables, Properties, and Subscripts
 ================================================
 */

// A constant, variable, or property cannot be more public than its type.
// It is not valid to write a public property with a private type, for example.
// Similarly, a subscript cannot be more public than either its index type or return type.

/* Getters and Setters
 -------------------
 
 Getters and setters for constants, variables, properties,
 and subscripts automatically receive the same access level as the
 constant, variable, property, or subscript they belong to.
 
 You can give a setter a lower access level than its corresponding getter,
 to restrict the read-write scope of that variable, property, or subscript.
 You assign a lower access level by writing private(set) or internal(set) before the var or subscript introducer.
 */

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

/*
 The access level for the numberOfEdits property is marked with a private(set) modifier
 to indicate that the property should be settable only from within the same source file
 as the TrackedString structure’s definition. The property’s getter still has the default access level of internal,
 but its setter is now private to the source file in which TrackedString is defined.
 This enables TrackedString to modify the numberOfEdits property internally,
 but to present the property as a read-only property when it is used by other source files within the same module.
 
 You can make the structure’s numberOfEdits property getter public, and its property setter private,
 by combining the public and private(set) access level modifiers:
 */

public private(set) var numberOfEdits = 0


/*
 ============
 Initializers
 ============
 */

/*
 Custom initializers can be assigned an access level less than or equal to the type that they initialize.
 As with function and method parameters, the types of an initializer’s parameters cannot be
 more private than the initializer’s own access level.
 */

/*
 Default Initializers
 --------------------
 
 A default initializer has the same access level as the type it initializes,
 unless that type is defined as public. For a type that is defined as public,
 the default initializer is considered internal.
 If you want a public type to be initializable with a no-argument initializer when used in another module,
 you must explicitly provide a public no-argument initializer yourself as part of the type’s definition.
 */


/*
 =========
 Protocols
 =========
 */

/*
 If you want to assign an explicit access level to a protocol type, do so at the point that you define the protocol.
 This enables you to create protocols that can only be adopted within a certain access context.
 
 The access level of each requirement within a protocol definition is automatically set to the same access level as the protocol.
 You cannot set a protocol requirement to a different access level than the protocol it supports.
 This ensures that all of the protocol’s requirements will be visible on any type that adopts the protocol.
 */

/*
 Protocol Inheritance
 --------------------
 
 If you define a new protocol that inherits from an existing protocol,
 the new protocol can have at most the same access level as the protocol it inherits from.
 You cannot write a public protocol that inherits from an internal protocol, for example.
 */

/*
 Protocol Conformance
 --------------------
 
 When you write or extend a type to conform to a protocol, you must ensure that the type’s implementation of each protocol requirement
 has at least the same access level as the type’s conformance to that protocol.
 For example, if a public type conforms to an internal protocol, the type’s implementation of each protocol requirement must be at least “internal”.
 */


/*
 ==========
 Extensions
 ==========
 */

/*
 Any type members added in an extension have the same default access level as type members declared in the original type being extended.
 If you extend a public or internal type, any new type members you add will have a default access level of internal.
 If you extend a private type, any new type members you add will have a default access level of private.
 
 Alternatively, you can mark an extension with an explicit access level modifier (for example, private extension)
 to set a new default access level for all members defined within the extension.
 This new default can still be overridden within the extension for individual type members.
 */

/*
 Adding Protocol Conformance with an Extension
 ---------------------------------------------
 
 The protocol’s own access level is used to provide the default access level for each protocol requirement implementation within the extension.
 */


/*
 ==========
 Extensions
 ==========
 */

/*
 The access level for a generic type or generic function is the minimum of the access level
 of the generic type or function itself and the access level of any type constraints on its type parameters.
 */


/*
 ============
 Type Aliases
 ============
 */

/*
 A type alias can have an access level less than or equal to the access level of the type it aliases.
 For example, a private type alias can alias a private, internal, or public type,
 but a public type alias cannot alias an internal or private type.
 */
