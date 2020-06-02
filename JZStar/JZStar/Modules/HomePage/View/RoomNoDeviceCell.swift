//
//  RoomNoDeviceCell.swift
//  StellarHomeIOS
//
//  Created by 刘燃 on 2020/4/14.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class RoomNoDeviceCell: UITableViewCell {
    
    @IBOutlet weak var mTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mTitleLabel.text = StellarLocalizedString("SCENE_ROOM_EMPTY_DEVICE")
    }
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("RoomNoDeviceCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
