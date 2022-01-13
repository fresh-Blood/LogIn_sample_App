import Foundation
import UIKit


typealias EntryPoint = ViewController

protocol UserAssemblyer {
    var entry: EntryPoint? { get }
    static func start() -> UserAssemblyer
}

final class Assemblyer: UserAssemblyer {
    
    var entry: EntryPoint?
    
    static func start() -> UserAssemblyer {
        
        let assemblyer = Assemblyer()
        let view = ViewController()
        assemblyer.entry = view as EntryPoint
        return assemblyer
    }
}
