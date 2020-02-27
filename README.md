# Flutter Reactive Architecture with MVI and BLOC
Flutter is relatively new and searching for best practices can be a hard work of researching for good references and choosing to adopt what makes more sense.

First I started by using Redux in some side projects and at work as well. But as long as I was getting more comfortable with Flutter and its resources, felt that I needed another step. I wasn't happy with my unit testing and how the things were coupled and missed some aspects familiar to me from Android development world using a more Clean approach where I could be sure that each layer is independent and testable and having the code coverage looking more green 😄 And also wanted to get familiar with Dart Streams. Having the codebase more independent on platform and third parties libraries also became one goal thinking about possibilities to share code between different platforms.

I started studying BLOC and used some good references as [these recommended from the official documentation](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#bloc--rx).

In this post I will go through one solution that I could come up with and will explain step by step the core implementation.
With BLOC the concepts of inputs and outputs come in handy when we can ally with MVI that is orchestrated by intentions. So in the solution that will be presented there are Intentions as Inputs and Outputs that are the corresponding state that will dictate how the UI will behave.

## Partial State
Represents the Intentions that can be user inputs in the View.

## View State
Represents the recipe on how the UI must behave, given a processing of an intention.

## Presenter/ BLOC
Presenter holds StreamController that orchestrate the data being streamed between the UI and the business logic behind. Will play with action and reaction.

## View
The view holds an initial state and all the possible triggers that can start a processing, then emit the results through the stream to update the UI state.
StreamBuilder to render the states in the UI and recreate the Widgets on each state emitted
StreamBuilder listen to the presenter stream and rebuild the widgets in case there is a new state emission.
