[![Build Status](https://app.bitrise.io/app/38259925b6bfe2bd/status.svg?token=7Q0InN8BEzmzxC0GPoddUg&branch=develop)](https://app.bitrise.io/app/38259925b6bfe2bd)

A minor Flutter base-source

### [Getting Started](#getting-started)

* Flutter (Channel stable, 2.10.4)
* Dart 2.16.2

### [Articles](#articles)
* https://itnext.io/flutter-x-graphql-a2dea05e6564
* https://dubydu.medium.com/web3dart-and-ethereum-blockchain-850aba77e692

### [Main Packages](#main-packages)
* [Provider](https://pub.dev/packages/provider) & [BLoC](https://pub.dev/packages/flutter_bloc): State management package.
* [graphql_flutter](https://pub.dev/packages/graphql_flutter): A GraphQL client for Flutter.
* [web3dart](https://github.com/simolus3/web3dart): Connect to interact with the Ethereum blockchain.

### [Usage](#usage)

#### Run App with a specific environment.
* Development: `flutter run -t lib/main_dev.dart`
* Production: `flutter run -t lib/main_prod.dart`

#### Common steps to add a new page
* Create a new `A_widget`.
* If you want to use Provider. Then create a new `A_provider` class that `extends` from `ChangeNotifierSafety` abstract class .
* Otherwise, if you want to use BLoC. Then create a new `A_bloc` class that `extends` from `Bloc` abstract class.
* Define the `A_widget's route` in [`app_route.dart`](https://github.com/dubydu/fluttour/blob/master/lib/app_define/app_route.dart).
* Exposing a new A_Provider object in [`myMain()`](https://github.com/dubydu/fluttour/blob/master/lib/my_app.dart) function.

#### How to add assets

[1. Icon](https://github.com/dubydu/fluttour/tree/master/assets/app/icons)

* Generate an icon into 1x, 2x and 3x, then add these icons into (assets/app/icons/…) folders.
* Remember that, these icons located in a different folder (2.0x, 3.0x,...) but their name must be same.

[2. Font]()

* Add custom fonts into assets/app/font
* Inside the [`pubspec.yaml`](https://github.com/dubydu/fluttour/blob/develop/pubspec.yaml) file, add these scripts under the `assets`. 
```
  fonts:
  - family: Font name
    fonts: 
      - asset: assets/app/fonts/{font_folder/font_name.ttf}
        weight: 100
      - asset: assets/app/fonts/{font_folder/font_name_italic.ttf}
        style: italic
        weight: 100
      # add any styles here follow above rule
```

### [Fall in Luv with GraphQL](#fall-in-luv-with-graphql)
There is plenty of supported server and client [`libraries`](https://graphql.org/code/#services) for GraphQL. In scope of this project, I am using the [`GraphCMS`](https://graphcms.com/).
* First of all, GraphQLClient requires both a endpoint and a token to be initialized. This stuff was available on this repo, you can take a look at [`this`](https://github.com/dubydu/fluttour/blob/458a873be898ad446fc73ab4e24a68d3b68aa83b/lib/data/api/api_client.dart#L12). 
* Then, create a new request class (1) that `extends` from [`GraphQLAPIClient`](https://github.com/dubydu/fluttour/blob/master/lib/data/api/api_client.dart) class.
* Exposing this class (1) object in [`myMain()`](https://github.com/dubydu/fluttour/blob/master/lib/my_app.dart) function.
* Write a `Future` function inside the request class (1), this function must return the value.
* Inside the `A_Provider` class, write a `Future` function, the main responsibility of this function is call the `Future` function inside the request class (1), then handle the Response (parse data, request status code...).
* About GraphQL APIs, such as `Query`, `Mutation`,... you can reference this [`document`](https://graphcms.com/docs/content-api/queries)

### [Local Storage](#local-storage)
*  [localstorage](https://pub.dev/packages/localstorage): Simple json file-based storage for flutter.
#### How to use
* This recipe cover how to save and get the object from local disk using [localstorage](https://pub.dev/packages/localstorage).
* ```e.g
  Future<String> getToken() async {
    if (await storage.ready == true) {
        return storage.getItem('custom_key');
    }
    return null;
  }

  Future<void> saveToken(String value) async {
      if (await storage.ready == true) {
        storage.setItem('custom_key');
      }
  }
  ```
* Inside the [`Credential`](https://github.com/dubydu/fluttour/blob/master/lib/app_define/app_credential.dart) class, create `set { }` `get { }` functions that you want to set and get the target object.

### [Pitfalls](#pitfalls)
- Make sure `flutter pub get` before you run the app.
### [WIP...](#wip)

---

> This repository took inspiration from [`nhancv/nft`](https://github.com/nhancv/nft), I really appreciate it.