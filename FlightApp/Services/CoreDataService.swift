//
//  CoreDataService.swift
//  FlightApp
//
//  Created by user202286 on 11/30/21.
//

import Foundation
import CoreData

class CoreDataService {
    
    static var shared : CoreDataService = CoreDataService()
    
    func addUser(firstName: String , lastName: String, userName: String , password: String){
        let user = User(context: persistentContainer.viewContext)
        user.firstname = firstName
        user.lastname = lastName
        user.username = userName
        user.password = password
        saveContext()
    }
    func getUser(username: String , password: String)-> User?{
        let fetch : NSFetchRequest<User> = User.fetchRequest()
        fetch.predicate = NSPredicate(format: "(username == %@) AND (password == %@)", argumentArray: [username , password])
        do{
            let result = try persistentContainer.viewContext.fetch(fetch) as [User]?
            if result?.count == 0 {
                return nil
            }else{
                return result?[0]
            }
        }catch{}
        return nil
    }
    func addMatchToUser(homeTeamName: String, awayTeamName: String, homeTeamScore: Int, awayTeamScore: Int, homeImage: String, awayImage: String, username: String) {
        let fetch : NSFetchRequest<User> = User.fetchRequest()
        fetch.predicate = NSPredicate(format: "username == %@ ", argumentArray: [username])
        do{
            let result = try persistentContainer.viewContext.fetch(fetch)
            let newFav = Favorites(context: persistentContainer.viewContext)
            newFav.awayTeamScore = "\(awayTeamScore)"
            newFav.homeTeamScore = "\(homeTeamScore)"
            newFav.awayTeamName = awayTeamName
            newFav.homeTeamName = homeTeamName
            newFav.awayTeamImg = awayImage
            newFav.homeTeamImg = homeImage
            result[0].addToFavorites(newFav)
            saveContext()
                  
        }catch{}
    }
    func deleteMatchFromUser(homeTeamName: String, awayTeamName: String, homeTeamScore: String, awayTeamScore: String, username: String) {
        let fetch : NSFetchRequest<User> = User.fetchRequest()
        fetch.predicate = NSPredicate(format: "username == %@ ", argumentArray: [username])
        do{
            let result = try persistentContainer.viewContext.fetch(fetch)
            for fav in result[0].favorites?.allObjects as! [Favorites]{
                if fav.awayTeamName == awayTeamName && fav.homeTeamName == homeTeamName && fav.homeTeamScore == homeTeamScore && fav.awayTeamScore == awayTeamScore{
                    result[0].removeFromFavorites(fav)
                }
            }
            saveContext()
        }catch{}
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FlightApp")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
