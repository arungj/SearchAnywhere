# iOS Google search

The app allows users to make searches for locations and present the results in a list, allowing them to be presented in a map view inside the app.  

### Acceptance Criteria:

1. The app should support iOS 9+. The look and feel is the system's default.
1. Text field on the top of the screen for entering search text.
1. Tapping search button makes the search through the call to the Google Maps API.
1. The UI must be responsive while searching through the API call.
1. The results must be listed in the same order as received by the API response. Each item in the list should show the name of the related location.
1. If there is only one result, display only one row in the list.
1. if there are more than one results, show a row for "Display All on Map" in a separated section.
1. Selecting this row would display the map with all results centered.
1. If there is no results, a "No Results" text should be displayed in the view instead of the result rows.
1. Selecting one item in the list should present a map view with all result items annotated. The selected item annotation should be centered. Feel free to set the zoom level.
1. Selecting an item annotation in the map view should present its location name and coordinates.
1. In the Map screen, add a "Save" button to the navigation bar, allowing the user to save the selected result object. This action should save the current object to a Core Data store and the object should be unique in the store.
    * **This is not applicable to the "Display All on Map" option**.
1. Case the object has been previously saved, the "Save" button should become into a "Delete" button. Tapping this button will delete the current object from Core Data, after popping up an alert view confirming the deletion. User should be able to "Cancel" or "Delete" the item from the presented alert view.
    * **This is not applicable to the "Display All on Map" option**.
1. Provide unit tests for models and view controllers, using the XCTest framework.

### Technical Details:

* **Documentation:** [Google Maps API](https://developers.google.com/maps/documentation/geocoding/)
* **API call example:** http://maps.googleapis.com/maps/api/geocode/json?address=Springfield&sensor=false
* **Location name key to be used:** `formatted_address`
* **Location coordinates key path:** `geometry.location`

### Architecture decisions: 

1. The UI of the application is created using a navigation controller with a tableview and a details screen when tapped on each row.
2. The application architecture is MVVM with each ViewController backed by a data source. The data source is the view model that implements the logical decisions based on the data. The views in the application are populated by the data from the view model.
3. Codable protocol for parsing the service response JSON.
3. The search function, web service, Core Data and progress indicator are implemented in separate protocols for reusability across the application.
4. Separate data source and protocols to implement each functionality helps to unit test them easily. There is no tight coupling with the ViewController.
5. The UI is designed using autolayout which will work in devices with different size classes.

### List of third-party libraries:

1. Swiftlint: A command line tool for linting and code styling. It is run as a shell script each time the project is built. Code styling is critical to ensure the same look and feel of the source code throughout the project.


### Improvements that can be done to the project:
1. "All bookmarks" button to view all the saved places.
2. "Save search" option to save all the search results in a single click.
3. "Save" and "Delete" icons in the annotation callout instead of showing them on the navigation bar.
4. View the map in different map types like satellite and hybrid.
5. If the location name is too long, the callout is clipped, it can be adjusted to show completely on the screen.

### Screenshots:

**All results**

![All results](https://github.com/arungj/SearchAnywhere/blob/master/screenshots/1%20All%20results.png)

**All results on map**

![All results](https://github.com/arungj/SearchAnywhere/blob/master/screenshots/2%20All%20results%20on%20map.png)

**No result**

![All results](https://github.com/arungj/SearchAnywhere/blob/master/screenshots/3%20no%20result.png)

**Selected result, save button**

![All results](https://github.com/arungj/SearchAnywhere/blob/master/screenshots/4%20Selected%20result%2C%20save%20button.png)

**Landscape map**

![All results](https://github.com/arungj/SearchAnywhere/blob/master/screenshots/5%20landscape%20map.png)

**Delete location button**

![All results](https://github.com/arungj/SearchAnywhere/blob/master/screenshots/6%20delete%20button.png)