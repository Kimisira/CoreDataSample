//
//  Person+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by Kimisira on 2016/03/28.
//  Copyright © 2016年 Kimisira. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var name: String?
    @NSManaged var address: Address?

}
