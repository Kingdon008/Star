//
//  SelectDetailCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/3.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class SelectDetailCell: UITableViewCell {

    @IBOutlet weak var tableview: UITableView!
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("SelectDetailCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableview.delegate = self
        tableview.dataSource = self
    }
}

extension SelectDetailCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
