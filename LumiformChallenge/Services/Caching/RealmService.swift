//
//  RealmService.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 09/04/2025.
//

import Foundation
import RealmSwift

@MainActor
class RealmService: ObservableObject {
    static let shared = RealmService()
    
    private let realm: Realm
    
    /// The collection of page items from Realm database
    @ObservedResults(RealmItem.self) var page
    
    init() {
        do {
            let config = Realm.Configuration(
                schemaVersion: 2,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 2 {
                        migration.create("repeated")
                    }
                },
                deleteRealmIfMigrationNeeded: true
            )
            
            realm = try Realm(configuration: config)
        } catch {
            fatalError("Realm initialization failed: \(error)")
        }
    }
    
    func overwrite(item: RealmItem) async {
        do {
            try realm.write {
                realm.deleteAll()
                realm.add(item)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeAll() async {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getRealmItems() -> Results<RealmItem> {
        realm.objects(RealmItem.self).freeze()
    }
}
