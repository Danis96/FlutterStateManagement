# kpiProvider

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

Flutter project where I created one small application using Provider state management.

By using provider instead of manually writing InheritedWidget, you get:

-simplified allocation/disposal of resources
-lazy-loading
-a largely reduced boilerplate over making a new class every time
-devtools friendly
-a common way to consume these InheritedWidgets (See Provider.of/Consumer/Selector)
-increased scalability for classes with a listening mechanism that grows exponentially in complexity (such as ChangeNotifier, which is O(N²) for dispatching notifications).