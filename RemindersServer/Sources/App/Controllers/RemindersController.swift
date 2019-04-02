import Vapor
import RemindersCore
import FluentSQLite
import Foundation

struct RemindersController: RouteCollection {
    func boot(router: Router) throws {
        let remindersGroup = router.grouped("api", "reminders")
        
    }
    
    // Create
    
    // Get all
    
    // Get single
}

