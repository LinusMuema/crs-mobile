# crs
A car rental system.

### Architecture
The application follows a simple MVC pattern powered by the [GetX](https://pub.dev/packages/get) library and [Json serializable](https://pub.dev/packages/json_serializable) package from google.
* **[Models]():** these are the classes holding the data in the application. They represent the data structures used in the application. Json serializable converts data from JSON to dart classes. For local persistence, like the user profile, we are using [Hive](https://pub.dev/packages/hive) which is a lightweight NoSql db.
* **Controllers:** these classes represent the state of the pages and views. They handle the business logic and state management in the application. They use the various [Services](#services) in the application to fetch data and update the UI. Leveraging the GetX smart management, we are able to create and dispose the controllers whenever needed.
* **Views:** these form the UI representation of our application. They hold the widgets that the user interacts with. They also display the data from controllers.

### Services
These are classes that are available everywhere in the application. They are created once the application starts and are available in the applications lifecycle scope.
* **[NetworkService]():** this class extends the [GetConnect]() class for networking purposes. It is responsible for setting the jwt token in all the outgoing network requests. Since it extends GetConnect, all the methods in GetConnect are available in the NetworkService class.
* **[HiveService]():** this class is used to access Hive's capabilities. It has two methods for reading and writing to Hive. It also registers adapters for our custom classes.
*

### Environment
The application uses cloudinary and Google maps so you know there are API keys involved. In as much as I'm a generous person, there are some API keys I can't share. Get your own because these strings cost money lol 😂.
* **Google maps**: Set the Google maps API key in the `google.maps.key` field in the local.properties file.
* **Cloudinary**: Then create a `secrets.dart` file and add an abstract class of the same name in the file. Add the cloudinary api key in the `CLOUDINARY_API` variable and the api secret in the `CLOUDINARY_SECRET` variable.

With those two, you are good to go.

### Themes
Colors:   
Font : Dongle