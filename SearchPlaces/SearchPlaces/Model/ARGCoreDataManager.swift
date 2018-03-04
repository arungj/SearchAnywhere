//
//  ARGCoreDataManager.swift
//  SearchPlaces
//
//  Created by Arun George on 3/4/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import CoreData

/**
 This class initializes a shared instance of CoreData to be used in the application. For iOS 9 support, it uses NSPersistentStoreCoordinator. For OS versions 10 and above, it uses NSPersistentContainer.
 */

class ARGCoreDataManager {
    static let shared = ARGCoreDataManager()
    
    // Prevent external initialization of CoreDataManager.
    private init() {
    }
    
    // MARK: - CoreData stack for iOS 10.
    @available(iOS 10.0, *)
    lazy private(set) var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SearchPlaces")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: CoreData setup prior to iOS 10.
    lazy private var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "SearchPlaces", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy private var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let applicationDocumentsDirectory = urls[urls.count-1]
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent("SearchPlaces.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            coordinator = nil
            // Report any error we got.
            var errorInfo = [String: Any]()
            errorInfo[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            errorInfo[NSLocalizedFailureReasonErrorKey] = failureReason
            errorInfo[NSUnderlyingErrorKey] = error
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(String(describing: error)), \(errorInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy private var storeManagedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        // Use main queue concurrency since the read write operations are controlled from the main / UI thread.
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    var context: NSManagedObjectContext? {
        if #available(iOS 10.0, *) {
            return persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            return self.storeManagedObjectContext
        }
    }
    
    func saveContext () {
        guard let mainContext = context else {
            print("Context not initialized")
            return
        }
        
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
