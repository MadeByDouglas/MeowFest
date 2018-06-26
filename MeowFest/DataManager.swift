//
//  DataManager.swift
//  MeowFest
//
//  Created by Douglas Hewitt on 3/22/18.
//  Copyright © 2018 TaleKickAppLLC. All rights reserved.
//

import UIKit

struct Cat: Codable {
    let title: String
    let description: String
    let timestamp: String
    let image_url: String
    var studentName: String?

    //TODO: implement more robust coding decoding for better swift types

//    enum CodingKeys: String, CodingKey {
//        case imageURL = "image_url"
//        case date = "timestamp"
//    }

}

class DataManager: NSObject {

    static let sharedInstance = DataManager()

    var studentNames = ["Adam", "Destinee", "Diana", "Douglas", "JC", "Kristen", "Leah", "Liz", "Manusha", "Niyati", "Roxann", "Sara", "Shalom", "Sharon", "Camille", "Dave", "Garrick", "Jamil", "Jiyoon", "Lauren", "Megan", "Ruslan"]

    weak var tableView: UITableView?

    var cats: [Cat]? {
        didSet {
            tableView?.reloadData()
        }
    }
}
