//
//  HomePageViewController.swift
//  JZStar
//
//  Created by don on 2020/6/2.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController {
    var viewModel = HomePageVM()
    var bannerModels:[BannerModel]?
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var headIcon: UIButton!
    @IBOutlet weak var profitLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupData()
    }
    
    func setupView(){
        let headView = UIView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 220))
        headView.addSubview(pagerView)
        tableview.tableHeaderView = headView
        tableview.separatorColor = UIColor.init(hexString: "#C3CBD3")
        view.addSubview(typeView)
        typeView.selectBlock = { title in
            self.viewModel.currentName = title
        }
    }
    
    func setupData(){
        Network.request(.userCenterHome(uid: (AppManager.sharedManager.user.uid ?? "")), success: { (json) in
            let model = json["data"].description.kj.model(AppUser.self)
            let jsonstr = json["data"].description
            print("\(jsonstr)")
            AppManager.sharedManager.user.kj_m.convert(from: jsonstr)
            AppManager.sharedManager.user.save()
            let url = URL(string: model?.headimgurl)
            self.headIcon.imageView?.kf.setImage(with: url, placeholder: UIImage.init(named: "defaultHeadIcon_big"))
            self.phoneLabel.text = model?.phone
            self.profitLabel.text = "\(model?.profit ?? "")元"
            self.viewModel.myResumePer = model?.resume_percent
        }) { (err, mess) in

        }
        Network.request(.homeBanner, success: { (json) in
            self.bannerModels = json["data"].arrayObject?.kj.modelArray(BannerModel.self)
            self.pagerView.reloadData()
        }) { (error, message) in

        }
        viewModel.tableViewDataModel.targetTableView(myTableview: tableview)
        viewModel.reloadTypes = { titles in
            self.typeView.setTitles(titles)
        }
        viewModel.vmDelegate = self
        viewModel.setData {
            self.tableview.reloadData()
        }
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.viewModel.loadMoreData()
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
//        view.removesInfiniteLoopForSingleItem = true
        view.automaticSlidingInterval = 3
        return view
    }()
    
    
    lazy var typeView:SelectTypeView = {
        let frame = CGRect.init(x: 0, y: kNavigationH + 220 + 104, width: kScreenWidth, height: 50)
        let view = SelectTypeView(frame: frame)
//        view.backgroundColor = UIColor.red
        return view
    }()
    
    @IBAction func headBtnClick(_ sender: Any) {
        AppManager.sharedManager.mainVc.myViewState = ViewState.kPersonalVc
    }
    
    
}

extension HomePageViewController:FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        self.bannerModels?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if let model = self.bannerModels?[index]{
            let url = URL(string: model.img_url)
            cell.imageView?.kf.setImage(with: url)
        }
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        guard let model = self.bannerModels?[index] else {
            return
        }
        if let url = model.source_url {
            jumpTo(url: url)
        }
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

extension HomePageViewController:HomePageVMDelegate {
    func pushViewController(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

