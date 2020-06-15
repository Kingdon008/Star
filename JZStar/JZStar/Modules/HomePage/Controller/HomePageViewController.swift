//
//  HomePageViewController.swift
//  JZStar
//
//  Created by don on 2020/6/2.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController {
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    var viewModel = HomePageVM()
    
    @IBOutlet var personalHeadView: UIView!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupData()
    }
    
    func setupView(){
        let headView = UIView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 220))
//        personalHeadView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 82)
//        headView.addSubview(personalHeadView)
        headView.addSubview(pagerView)
        tableview.tableHeaderView = headView
        tableview.separatorColor = UIColor.init(hexString: "#C3CBD3")
        view.addSubview(typeView)
        typeView.selectBlock = { title in
            self.viewModel.currentName = title
        }
    }
    
    func setupData(){
        viewModel.tableViewDataModel.targetTableView(myTableview: tableview)
        viewModel.reloadTypes = { titles in
            self.typeView.setTitles(titles)
        }
        
        viewModel.setData {
            self.tableview.reloadData()
        }
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
//            self.viewModel.loadDetailCells()
            self.tableview.mj_footer?.endRefreshing()
        })
        tableview.rx.contentOffset.subscribe { [weak self] (contentOffset) in
            if let contentOffsetY:CGFloat = contentOffset.element?.y {
                self?.setupTableviewScroll(contentOffsetY: contentOffsetY)
            }
        }.disposed(by: disposeBag)
    }
    
    ///lazy
    lazy var pagerView:FSPagerView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 220)
        let view = FSPagerView(frame: frame)
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        view.dataSource = self
        view.delegate = self
        view.transformer = FSPagerViewTransformer(type: .coverFlow)
        view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        view.itemSize = CGSize(width: 220, height: 170)
        view.decelerationDistance = FSPagerView.automaticDistance
        view.decelerationDistance = 1
        view.isInfinite = true
        view.alwaysBounceHorizontal = true
        view.removesInfiniteLoopForSingleItem = true
        view.automaticSlidingInterval = 3
        return view
    }()
    
    
    lazy var typeView:SelectTypeView = {
        let frame = CGRect.init(x: 0, y: kNavigationH + 220 + 104, width: kScreenWidth, height: 50)
        let view = SelectTypeView(frame: frame)
//        view.backgroundColor = UIColor.red
        return view
    }()

}

extension HomePageViewController:FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
//        self.viewModel.loadDetailCells()
    }
}

extension HomePageViewController{
    func setupTableviewScroll(contentOffsetY:CGFloat){
        if Int(contentOffsetY) < Int(220 + 104){
            typeView.frame.origin.y = kNavigationH + 220 + 104 - contentOffsetY
        }
        else{
            typeView.frame.origin.y = kNavigationH
        }
    }
}
