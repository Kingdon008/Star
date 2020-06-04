//
//  HomePageViewController.swift
//  JZStar
//
//  Created by don on 2020/6/2.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit
//{"status":1,"data":[{"type":"is_recommend","name":"\u63a8\u8350","id":1,"data":[{"id":"3","title":"\u4e0a\u6d77\u8001\u4f5b\u7237\u767e\u8d27\u5730\u644a\u517c\u804c\u62db\u52df","company_name":"\u91d1\u5e97\u6709\u9650\u516c\u53f8","salary_describe":"8\u5143\/\u5355"},{"id":"2","title":"\u5728\u5bb6\u517c\u804c[\u514d\u8d39\uff0c\u6b63\u89c4\uff0c\u7b80\u5355]","company_name":"\u5fb7\u7c73\u79fb\u52a8\u79d1\u6280","salary_describe":"300\/\u5929"}]},{"type":"is_fulltime","name":"\u5168\u804c","id":1,"data":[{"id":"5","title":"\u5feb\u9012\u914d\u9001","company_name":"\u554a\u554a\u7269\u6d41\u516c\u53f8","salary_describe":"200-500\/\u5929"},{"id":"4","title":"\u7f8e\u5bb9\u7f8e\u53d1","company_name":"\u963f\u7d22\u8d38\u6613\u6709\u9650\u516c\u53f8","salary_describe":"\u5e95\u85aa+\u63d0\u6210"},{"id":"3","title":"\u4e0a\u6d77\u8001\u4f5b\u7237\u767e\u8d27\u5730\u644a\u517c\u804c\u62db\u52df","company_name":"\u91d1\u5e97\u6709\u9650\u516c\u53f8","salary_describe":"8\u5143\/\u5355"},{"id":"2","title":"\u5728\u5bb6\u517c\u804c[\u514d\u8d39\uff0c\u6b63\u89c4\uff0c\u7b80\u5355]","company_name":"\u5fb7\u7c73\u79fb\u52a8\u79d1\u6280","salary_describe":"300\/\u5929"}]},{"type":"is_parttime","name":"\u517c\u804c","id":1,"data":[{"id":"6","title":"\u89c6\u9891\u4e3b\u64ad","company_name":"\u56db\u56db\u6295\u8d44\u6709\u9650\u516c\u53f8","salary_describe":"150-300\/\u5929+\u989d\u5916"},{"id":"5","title":"\u5feb\u9012\u914d\u9001","company_name":"\u554a\u554a\u7269\u6d41\u516c\u53f8","salary_describe":"200-500\/\u5929"},{"id":"4","title":"\u7f8e\u5bb9\u7f8e\u53d1","company_name":"\u963f\u7d22\u8d38\u6613\u6709\u9650\u516c\u53f8","salary_describe":"\u5e95\u85aa+\u63d0\u6210"},{"id":"3","title":"\u4e0a\u6d77\u8001\u4f5b\u7237\u767e\u8d27\u5730\u644a\u517c\u804c\u62db\u52df","company_name":"\u91d1\u5e97\u6709\u9650\u516c\u53f8","salary_describe":"8\u5143\/\u5355"},{"id":"2","title":"\u5728\u5bb6\u517c\u804c[\u514d\u8d39\uff0c\u6b63\u89c4\uff0c\u7b80\u5355]","company_name":"\u5fb7\u7c73\u79fb\u52a8\u79d1\u6280","salary_describe":"300\/\u5929"}]},{"type":"is_tag_type","name":"\u730e\u5934\u63a8\u8350","id":"3","data":[{"id":"2","title":"\u5728\u5bb6\u517c\u804c[\u514d\u8d39\uff0c\u6b63\u89c4\uff0c\u7b80\u5355]","company_name":"\u5fb7\u7c73\u79fb\u52a8\u79d1\u6280","salary_describe":"300\/\u5929"}]},{"type":"is_tag_type","name":"\u4f18\u9009\u804c\u4f4d","id":"2","data":[{"id":"3","title":"\u4e0a\u6d77\u8001\u4f5b\u7237\u767e\u8d27\u5730\u644a\u517c\u804c\u62db\u52df","company_name":"\u91d1\u5e97\u6709\u9650\u516c\u53f8","salary_describe":"8\u5143\/\u5355"}]},{"type":"is_tag_type","name":"\u70ed\u95e8\u804c\u4f4d","id":"1","data":[{"id":"4","title":"\u7f8e\u5bb9\u7f8e\u53d1","company_name":"\u963f\u7d22\u8d38\u6613\u6709\u9650\u516c\u53f8","salary_describe":"\u5e95\u85aa+\u63d0\u6210"}]}]}
/*
{"status":1,"data":[{"id":"2","img_url":"https:\/\/mmbiz.qpic.cn\/mmbiz_jpg\/H15QTibmqGKclLZ2ibP3OhY0JKphjCj9ibyoy9uyKp8BTnovwFM4LE0I0P6vStdxgnU6oAVm7tohiaIxhwulVrNzuQ\/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1","source_url":"https:\/\/mp.weixin.qq.com\/s\/UvsUOQq3gSioJL94fz636g"},{"id":"1","img_url":"https:\/\/mmbiz.qpic.cn\/mmbiz_png\/H15QTibmqGKeeYe4m0NtAJnUcaXt3MYQy1EiawKRib1dq5hflGibxDFCrqInPSXw61RpwxHByupMeIVjaE0NnvvVvA\/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1","source_url":"https:\/\/mp.weixin.qq.com\/s\/Z42Qfz29f9FVPdHv2bVjKw"}]}
*/
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
        let headView = UIView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 280))
        headView.addSubview(pagerView)
        personalHeadView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 60)
        headView.addSubview(personalHeadView)
        tableview.tableHeaderView = headView
    }
    
    func setupData(){
        viewModel.tableViewDataModel.targetTableView(myTableview: tableview)
        viewModel.setData {
            self.tableview.reloadData()
        }
    }
    
    ///lazy
    lazy var pagerView:FSPagerView = {
        let frame = CGRect.init(x: 0, y: 60, width: kScreenWidth, height: 220)
        let view = FSPagerView(frame: frame)
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
    }
}
