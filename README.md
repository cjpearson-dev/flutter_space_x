# Flutter Space X

## Introduction

This is a demo Flutter application, centred around displaying data about Space X launches. It consists of four screens; a launch list page with an accompanying details page that can be navigated to by clicking on the respective launch list card and a similarly structured event history list/details pages.

Upon the app loading you will land on the launch list page, from here you can scroll a list of launches arranged in a grid layout. You can navigate to the details page for the respective launch by clicking anywhere on the list card. Data is lazy loaded in as you scroll down the page for better optimisation. Pulling down while at the top of the list will refresh the list; this functionality is present on every page of the app where a data load happens. At the bottom of the screen you will find a tab navigator that will allow you to switch between the launch list and the history list.

On the launch details page you will find some basic information about he launch displayed. An image carousel will be at the top, provided the data contains any. This just uses the standard Material Design 3 ```CarouselView``` widget from Flutter. A set of links appear at the bottom; clicking any of these will use in in-app browser to display this content or potentially sent to another app via a deeplink if they have it installed on their device.

The history list page operates similarly to the launch list page and likewise the history details is a lot like launch details page (I didn't quite realise when starting out that there was going to be so much overlap between the two. With hindsight I would have done more with the rocket endpoint perhaps.) One unique thing on the history details is clicking the flight number here will directly navigate to the respective launch details page.

That about covers it, I hope enjoy trying it out. :)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Before you start, you need to have Flutter and Dart installed on your machine. This project was created with Flutter 3.29.0 & Dart 3.7.0.

### Installation
Clone the repo
```
https://github.com/cjpearson-dev/flutter_space_x.git
```
Install Flutter packages & generate localisations
```
flutter pub get
```
Build other generated files
```
dart run build_runner build --delete-conflicting-outputs
```

### Usage
Run the app
```
flutter run
```

## Design
The app structure follows an MVVM architecture, allowing separation of concerns between data fetching, business logic and UI rendering. I decided to use a combination of ```flutter_bloc``` and ```get_it``` as the tools to accomplish this, both of which I am very familar with.

The services act as wrappers around external dependencies; the goal being to decouple them from the rest of the app, making them much more testable and maintainable in the long run. To that end they will have a abstract class that will then be implemented using the dependency. The implementation will only tend to be used when registering as a singleton within the service locator, with only the abstract referenced elsewhere. This also allows you to make mock versions of your services for unit testing purposes.

The repositories act as the model layer from the aforementioned MVVM pattern. They will use the ```ApiService``` to fetch the relevant data and map the responses to the data models. The repositories may also fetch data from other sources, such as a local database. If you had a ```DatabaseService```, for example, you could preferentially check whether the data you wanted first existed within the database and retrieve it from there if so. If not, you could fetch it using the ```ApiService``` and then store the retrieved data locally using the ```DatabaseService``` for easy access later.

Data models are generated using ```freezed``` and ```json_serializable```. This gives access to very handy factory constructors and methods, such as copyWith and fromJson. It can massively cut down on boilerplate code versus handwriting all these classes, especially as they give exponentially more complex and nested.

```flutter_bloc``` acts as a de facto viewmodel layer. Blocs or cubits classes contain your business logic. During data fetching they will utilize the repositories to fetch data and map it to the accompanying state class. I again use my ```freezed``` here for my state classes, to make use of the copyWith method when emitting updated state. So far I have mostly used cubit classes, for simplicity's sake, to reduce on boilerplate for setting up all the event classes and on event callback declarations, but I would usually make use of both.

I realised as I went along that perhaps focused a little too much on perfecting the data fetching flow and haven't yet demonstrated much in regard to user affected state changes. The first thing I would add going forward would be a sort/filtering menu with various form inputs based around the query parameters available on the endpoints.

In general, I try to keep the view layer as mainly ```StatelessWidget```s and as dumb as possible. Any logic, if at all possible, is extracted to the viewmodel layer. The ```DataLoadingContainer``` is perhaps the star of the show here, seamlessly handling the different stages of data fetching and layouts for each.

The app supports internationalisation out of the box using ```.arb``` files to generate localisation classes for use within the view layer.

```melos``` is another package I would usually use for monorepo support. Again in the interests of keeping things simple I have omitted it. The widgets directory would be a prime example of something to make a separate module, creating a widget/component library of sorts that you could reuse between multiple projects.

## Roadmap
Things I would like to add to the app going forward:

- Add sort/filtering options menu.
- Embed video, where available, on the launch details page.
- A rocket details page, accessible by clicking the rocket name on the launch details page and perhaps a rocket list page also.
- Ability to link to Google Maps to show launch sites or perhaps an embedded map with a map plugin (i.e. ```mapbox_maps_flutter```).
- Create a DatabaseService and cache data locally.
- Favourite/save launches.
- Better theme handling, control of paddings, etc.

## License
Distributed under the MIT License. See LICENSE for more information.

## Contact
Christopher Pearson - cjpearson.dev@gmail.com

Project Link: https://github.com/cjpearson-dev/flutter_space_x

