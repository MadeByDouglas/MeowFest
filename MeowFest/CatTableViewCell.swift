//
//  CatTableViewCell.swift
//  MeowFest
//
//  Created by Douglas Hewitt on 3/22/18.
//  Copyright © 2018 TaleKickAppLLC. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {

    static let identifier = "Cat"

    @IBOutlet weak var studentNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var catImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!

    var blurredEffectView: UIVisualEffectView!
    let blurEffect = UIBlurEffect(style: .regular)


    func configure(cat: Cat, studentName: String) {

        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = studentNameLabel.frame
        contentView.insertSubview(blurredEffectView, belowSubview: studentNameLabel)

        let formatter = DateFormatter()
        formatter.dateFormat = "/MM/dd/yy"
        // TODO: finish date parsing
//        let dateText = formatter.string(from: cat.timestamp!)
//        dateLabel.text = dateText

        dateLabel.text = cat.timestamp

        getImageForCat(urlString: cat.image_url)

        nameLabel.text = cat.title
        descriptionLabel.text = cat.description

        studentNameLabel.text = studentName
    }

    func getImageForCat(urlString: String) {

        let url = URL(string: urlString)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.catImageView?.image = UIImage(data: data!)
            }
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        blurredEffectView.removeFromSuperview()
        blurredEffectView = nil
        catImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
