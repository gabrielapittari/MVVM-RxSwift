## Premier

Premier is a tiny, demo iOS application.

It presents a list of top movies according to [The Movie Database](https://www.themoviedb.org), by querying their API. The full details of the API can be found in [The Movie Database API documentation](http://docs.themoviedb.apiary.io/#).

### Getting started

Xcode 8 is needed to build and run the apps. The projects is built against iOS 10, targeting iOS 9.3 and uses Swift 3.


The project’s structure could be improved in many ways:

Strings
- The strings shouldn’t be hardcoded, instead, Localisation could be implemented in this way it could be easier to change texts through the app and even support multiple languages.
- The API endpoints and Keys should be written in a separate file in order to make easier to change environments.
Model and Data Handling
- A class model should be created to map the JSON responses instead of mapping the JSON on the go. There are many third party libraries that could be used for the mapping this can also be done without using a third party library.
- If required, the data could be cached in this way the app could show movies results without the need of being online (once it has already downloaded data before).
API calls
- A separate class should be the one making the API calls instead of implementing it directly in the view controller.
- A library could be used to make the API calls in a simpler way, this will also simplify the download of images.
Dependency injection
- The main view controller is being instantiated from the App delegate which can be helpful for injecting dependencies, other approach as assigning the initial view controller from the Storyboard could be used but will not allow dependency injection.
- We could use dependency injection when assigning the movie title to the table view instead of directly write the value of the JSON response, this will bring as advantage the UI to be updated automatically when having a change in the data.
Styles
- The UIKit+PremierStyles class is helping to define the theme of the app. This is very useful as its use will help us keep consistency across the app.
TDD
- Test Driven Development hasn’t been implemented. It’s implementation its recommended as it will allow us to understand if there’s something unexpected and will cover different scenarios that might not be in mind during coding.


Proposed changes

I will change the project structure to the following

1. Design pattern: I will implement MVVM (Model View View Model) with dependency injection in order to make easier to update data in the UI and to make more scalable and testable the app in a future. If I keep the current pattern, I will end up with a massive view controller class which is going to be very difficult to test as there is no separation of roles in the methods.

2. Package manager: for installing third party libraries I will use Cocoapods it’s my favourite package manager, it’s very straightforward and if I need to use an old framework it’s going to be more probable to find it in Cocoapods.

3. Third party libraries
- Moya: I have chosen this library for managing the network calls.
- ObjectMapper: this library will simplify the mapping of the JSON to a model without the need of write manually the properties keys as strings.
- RxSwift: RxSwift will help me with the dependency injection.

4. Paging: I will add paging to the tableview, in this way I will be able to load more results once the user scrolls to the end of the table view.


Further recommended developments
If I would have had more time I would have implemented this:
- Cache data: the API has cache control public, max-age=21600 which means that once the client downloads the data, if uses a specific cache configuration, it will only need to pull data once and, if it doesn’t change, it will not need to pull it again for the next 6 hours.  for caching data we could use Core Data or third party libraries like Realm.
- Show the user a detail of each movie: when clicking on the cell of the table view, a new view will be presented showing more details of the selected movie. The structure of this new feature will be very similar to the existing one.

