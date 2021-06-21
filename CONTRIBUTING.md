# Contributing to MSAL.js for Dart
Thank you for taking the time to contribute!

Please read on to learn about how you can help out.


## Contents
- [Wrapping MSAL](#wrapping-msal)
    - [Steps for wrapping an API](#steps-for-wrapping-an-api)
- [Style Guide](#style-guide)
- [Opening a Pull Request](#opening-a-pull-request)
- [Resources](#resources)


## Wrapping MSAL
Wrapping any JavaScript code in Dart is fairly straight-forward, but comes with a set of quirks. This is especially true with MSAL.js since it was written in TypeScript. You will find that many language features don't cross over very well and you may need to get a little creative to solve this issue.

Here's a list of some common problems and solutions:
- Dart doesn't have a `Promise` type.
    - **solution**: Use normal Dart `Future`s for public APIs, and convert between the two using utility functions such as `promiseToFuture` when crossing the Dart-JavaScript boundary.
- Dart doesn't have an `undefined` type.
    - **solution**: This one is a bit tricky. In cases where the JavaScript code uses `undefined` to decide whether to use a default value, the Dart code will need to be written in a way where a client can avoid passing the value altogether. When no value is explicitly passed from Dart to JavaScript, it will remain `undefined`. You can see this pattern done very frequently in this package (ex. the request and configuration objects use setters instead of a constructor).
- Dart enums can't have explicit values.
    - **solution 1**: Still use an enum in Dart, but convert between the Dart enum and a value (such as string or int) when passing to/from the JavaScript API.
    - **solution 2**: Create a Dart class that only contains `static` `const` members for each enum value.
- Dart `Map`s and `List`s cannot be directly passed to/from JavaScript.
    - **solution**: This package comes with a set of utilities called "JS proxies" to solve this problem by implementing `Map` and `List` using an underlying JavaScript object. See `js_proxies/js_proxies.dart` for more info.
- Dart does not have union types (unlike TypeScript).
    - **solution**: This is another tricky one. Sometimes, you can mimic union types in Dart using mixins but this is limited by `package:js` since `@JS` annotated classes cannot use mixins at all. Another option is to create an abstract class for the union type and have all of the types that would be unioned implement the abstract class. This approach also requires some custom code to create the correct type at runtime (`EventPayload` is one example of this).

> If you come across a scenario that you're not sure how to address, consider [opening up a discussion in the GitHub repository](https://github.com/Francessco121/msal-js-dart/discussions).

### Steps for wrapping an API

#### 1. Find the API's source
Once you are ready to wrap an MSAL API, you'll ideally want to find its source code in the [microsoft-authentication-library-for-js](https://github.com/AzureAD/microsoft-authentication-library-for-js) repository. Often, the MSAL examples and docs will not use full and accurate definitions for types and methods, so having the source code handy is very helpful for correctly wrapping the API.

Relavent APIs for MSAL 2.x can be found under the `lib/msal-browser` and `lib/msal-common` folders.

> Be sure not to get confused with the `lib/msal-core` APIs (MSAL 1.x) as they often look very similar!

#### 2. Write the interop layer
This package wraps MSAL APIs in two places:
- The private `@JS` annotated classes under the `src/interop/` folder.
- The public classes found directly under the `src/` folder.

The first step for adding any API is to add its interop type/property/method/etc. This is done using [package:js](https://pub.dev/packages/js) `@JS` annotations which wrap the API the closest to the actual JavaScript API. This is the initial bridge between Dart and JavaScript, so there isn't any room for extra quality-of-life here.

Please read the [package:js documentation](https://pub.dev/packages/js) very carefully, most types cannot be used here and must be substituted with `dynamic` for now. Be careful to also not use generics (e.g. use `List` instead of `List<String>`).

#### 3. Write the public layer
Now that the interop layer is done, the public Dart API can be written. This is often done by creating a file under `src/` with the same name as the interop file under `src/interop/`. The type names between the two will also generally be the same (conflicts are handled by the `interop.` prefix from the `import as` in `msal_js.dart`).

Each of the public layer classes should have its corresponding interop class as a private variable named `_jsObject`. 

All that's left is to then write the public methods/properties that simply forward to the interop methods/properties. This involves converting between public/interop types (ex. `RedirectRequest` <-> `interop.RedirectRequest`), wrapping callbacks in [allowInterop](https://api.dart.dev/stable/dart-js/allowInterop.html), converting between `Promise`s and `Future`s, and handling errors thrown from JavaScript.

> Please use existing code as a reference for solving many of these problems. Utility functions exists such as `_callJsMethod` and `_convertMsalPromise` for dealing with exceptions and promise conversions.

#### 4. Document the public layer
The final step is to document any public classes, methods, properties, etc. At a minimum, this should include the doc comments straight from MSAL. Feel free to clean up any documentation copied from MSAL by adding some Markdown and fixing grammar.

If the MSAL API does not contain a doc comment, consider using [MSAL's documentation articles](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-browser/docs) to write a sentence or two for the API. This isn't strictly necessary, but it makes the library nicer to use for everyone.


## Style Guide
This package follows the official [recommended Dart rules](https://pub.dev/packages/lints) (along with some additional rules found in `analysis_options.yaml`) and uses the standard Dart formatter for styling.

Before pushing code changes, please run:
- `dart format .`
- `dart analyze`

From the root of the repository to fix formatting and analyze the code for any lint warnings/errors.


## Opening a Pull Request
Before opening a pull request, please make sure that:

1. All code changes follow the package's [style guide](#style-guide).
2. Code does not have any lint warnings or errors.

Style and lint issues don't need to be perfect **if you're submitting a draft PR**.


## Resources
- [AzureAD/microsoft-authentication-library-for-js](https://github.com/AzureAD/microsoft-authentication-library-for-js) - The source code of MSAL.js.
- [package:js](https://pub.dev/packages/js) - The official Dart package used for wrapping JavaScript APIs.
- [msal-js-dart Discussion Board](https://github.com/Francessco121/msal-js-dart/discussions) - For any questions or discussion about this package and help with contributions.
