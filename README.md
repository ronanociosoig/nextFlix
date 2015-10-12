# nextFlix
A sample application developed as an exercise for a company interview process.

The application user interface consists of 2 screens, a table view with the titles and popular score, and a movie details view where the poster is displayed along with the category (if available), the year it was released, and a description (if available).



## Requirements: 

Using the JSON data provided by The Movie DB (https://api.themoviedb.org/3/movie/), 
create an app that will extract out the current list of popular movies in a list, and show some of the details. 

The app must use AFNetworking. Use Unit testing with asynchronous tests. 


## Discussion: 

The class structure separates the data fetching from the view controllers by creating a layer that encapsulates all the network requests. 

SONMovieAPIWrapper class is the only class that has knowledge of the functionality of the API, with a small exception of extracting some data for the configuration of image URLs in the SONAppController.

The SONAppController manages all the requests to the API, and notifies the view controllers when changes occur. 

This clean separation ensures that it is simple to extend and maintain. 

## Future Work

The application does not maintain state, so a cache of previous movies would be beneficial to performance. 

Currently the application only loads the first page of what are many pages of new movies. This could be easily extended to load the full data available on the server. 

There are background images in some cases and these could be presented behind the poster image. 

There are a lot more data fields available in the JSON data provided by the server such as the film / production studio, languages, alternative names for the movie, and more. 

It would be interesting to be be able to add ratings to these movies by allowing the creation of a user account, and to list favourites. 

Social media integrations would also enhance the user experience by allowing a user to share a movie they like (or want to see) on their Facebook timeline for example. 


## 3rd Party Libraries 

The project uses CocoaPods for dependency management. 

### [AFNetworking](https://github.com/AFNetworking/AFNetworking)

AFNetworking was included here only because it was set as a project requirement. In the current application it is sufficient to use NSURLSession instead, as the application does not use any special feature for AFNetworking. 

### [Haneke](https://github.com/Haneke/Haneke)

Haneke is an excellent and simple to use image cache and was developed by one of my former colleagues. I have used it in all applications since it was in early development more than a year ago. 

### [Motis](https://github.com/mobilejazz/Motis)

Motis is a JSON object mapping tool developed by another one of my former colleagues. It simplifies the mapping of JSON object names to values in Objective C objects, performs validations and checking. This is especially useful for complex JSON responses where some of the parameters may be nil, and thus it checks the values and prevents crashes. 

### MBProgressHUD

This is a simple loading overlay that I have used in many projects. The way it is used in this project is less than optimal in that it is added to the tableViewController instead of being a subview of the UIWindow class - thus placing it on top of all the user views. 
 
  
