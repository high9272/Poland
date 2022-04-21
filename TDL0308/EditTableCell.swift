//
//  EditTableCell.swift
//  TDL0308
//
//  Created by DaWoon Jeong on 2022/03/10.
//

import UIKit

class EditTableCell: UITableViewCell {
    
    var favorited: Bool = false
    
    
    @IBOutlet weak var starBtn: UIButton!
    
    override func layoutSubviews() {
            super.layoutSubviews()

            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10.0, left: 10, bottom: 10, right: 10))
            contentView.layer.cornerRadius = 15
            contentView.clipsToBounds = true
        
        starBtn.tintColor = .white
        }
    


    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    @IBAction func starButton(_ sender: UIButton) {
        if favorited {
            favorited = false
            starBtn.setImage(UIImage(systemName: "star"), for: .normal)
            
        }else{
            favorited = true
            starBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
    
    
}
