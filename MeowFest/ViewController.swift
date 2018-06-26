//
//  ViewController.swift
//  MeowFest
//
//  Created by Douglas Hewitt on 3/22/18.
//  Copyright © 2018 TaleKickAppLLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static let cellHeight: CGFloat = 500

    @IBOutlet weak var tableView: UITableView!

    let network = Network.sharedInstance
    let data = DataManager.sharedInstance
    var shuffledNames: [String]!


    var randomNames: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.estimatedRowHeight = ViewController.cellHeight
        tableView?.rowHeight = UITableViewAutomaticDimension

        data.tableView = tableView
        shuffledNames = data.studentNames.shuffled()

        network.getCatsForStudents()

    }

    func getRandomName(namesLeft: inout [String]) -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(namesLeft.count)))
        let randomName = namesLeft[randomIndex]
        //shrink array
        if namesLeft.count > 1 {
            namesLeft.remove(at: randomIndex)
        }
        return randomName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Datasource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.cats?.count)
        return data.cats?.count ?? 0
    }


    // MARK: Delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewController.cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatTableViewCell.identifier, for: indexPath) as! CatTableViewCell


        guard let cats = data.cats else { return cell }
        let aCat = cats[indexPath.row]

        // MARK: START HERE

        //lets have the cats say hello

//        let aName = "Hello World"
        let aName = shuffledNames[indexPath.row]

        cell.configure(cat: aCat, studentName: aName)

        return cell

    }

}

