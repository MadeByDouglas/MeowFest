//
//  Network.swift
//  MeowFest
//
//  Created by Douglas Hewitt on 3/22/18.
//  Copyright © 2018 TaleKickAppLLC. All rights reserved.
//

import UIKit

class Network: NSObject {

    static let sharedInstance = Network()

    func getCatsForStudents() {
        getCats(page: "0")
        getCats(page: "1")
        getCats(page: "2")
    }

    private func getCats(page: String) {

        //Implementing URLSession
        let urlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=\(page)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {

                do {

                    let catData = try JSONDecoder().decode([Cat].self, from: data)

                    DispatchQueue.main.async {

                        guard let cats = DataManager.sharedInstance.cats else {
                            DataManager.sharedInstance.cats = catData
                            return
                        }

                        if cats.count >= 20 {
                            let reducedData = catData.prefix(upTo: 2)
                            DataManager.sharedInstance.cats?.append(contentsOf: reducedData)
                        } else {
                            DataManager.sharedInstance.cats?.append(contentsOf: catData)
                        }

                    }

                } catch let jsonError {
                    print(jsonError)
                }

            }


            }.resume()
        //End implementing URLSession
    }

    // TODO: add pull to refresh to get more cats
}
