# README
### Architecture decisions: 

1. The UI of the application is created using a navigation controller with a tableview and details screen when tapped on each row.
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

