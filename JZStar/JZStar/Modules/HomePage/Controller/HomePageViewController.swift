//
//  HomePageViewController.swift
//  JZStar
//
//  Created by don on 2020/6/2.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit
/*
{"status":1,"data":[{"id":"2","img_url":"https:\/\/mmbiz.qpic.cn\/mmbiz_jpg\/H15QTibmqGKclLZ2ibP3OhY0JKphjCj9ibyoy9uyKp8BTnovwFM4LE0I0P6vStdxgnU6oAVm7tohiaIxhwulVrNzuQ\/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1","source_url":"https:\/\/mp.weixin.qq.com\/s\/UvsUOQq3gSioJL94fz636g"},{"id":"1","img_url":"https:\/\/mmbiz.qpic.cn\/mmbiz_png\/H15QTibmqGKeeYe4m0NtAJnUcaXt3MYQy1EiawKRib1dq5hflGibxDFCrqInPSXw61RpwxHByupMeIVjaE0NnvvVvA\/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1","source_url":"https:\/\/mp.weixin.qq.com\/s\/Z42Qfz29f9FVPdHv2bVjKw"}]}
 {"status":1,"data":[{"view":"44","title":"\u8585\u7f8a\u6bdb\u4e0d\u5982\u52aa\u529b\u517c\u804c\uff0c\u5728\u7b80\u76f4\u4e2d\u4f60\u53ef\u4ee5\u6536\u83b7\u66f4\u591a","content":"\u622a\u81f36\u67084\u65e58\u65f6\uff0c\u9655\u897f\u7701\u7d2f\u8ba1\u62a5\u544a\u672c\u571f\u786e\u8bca\u75c5\u4f8b245\u4f8b\uff08\u56fd\u5185\u8f93\u5165\u75c5\u4f8b116\u4f8b\uff0c\u672c\u5730\u75c5\u4f8b129\u4f8b\uff09\uff0c\u51fa\u9662242\u4f8b\uff0c\u6b7b\u4ea13\u4f8b\uff0c\u6cbb\u6108\u738798.78%\u3002\u7d2f\u8ba1\u62a5\u544a\u65e0\u75c7\u72b6\u611f\u67d3\u800531\u4f8b\uff08\u8f6c\u4e3a\u786e\u8bca\u75c5\u4f8b1\u4f8b\uff0c\u5df2\u89e3\u9664\u9694\u79bb30\u4f8b\uff09\u3002\r\n\r\n\u5883\u5916\u8f93\u5165\u75ab\u60c5\uff1a2020\u5e746\u67083\u65e58\u65f6\u81f36\u67084\u65e58\u65f6\uff0c\u9655\u897f\u65e0\u65b0\u589e\u5883\u5916\u8f93\u5165\u65b0\u51a0\u80ba\u708e\u786e\u8bca\u75c5\u4f8b\u3002\u622a\u81f36\u67084\u65e58\u65f6\uff0c\u9655\u897f\u7d2f\u8ba1\u62a5\u544a\u5883\u5916\u8f93\u5165\u65b0\u51a0\u80ba\u708e\u786e\u8bca\u75c5\u4f8b64\u4f8b\uff08\u6cbb\u6108\u51fa\u966263\u4f8b\uff0c\u65e0\u6b7b\u4ea1\u75c5\u4f8b\uff09\uff0c\u73b0\u67091\u4f8b\u3002\u65b0\u589e\u65e0\u75c7\u72b6\u611f\u67d3\u80051\u4f8b\uff0c\u7d2f\u8ba1\u62a5\u544a\u65e0\u75c7\u72b6\u611f\u67d3\u800517\u4f8b\uff08\u8f6c\u4e3a\u786e\u8bca\u75c5\u4f8b1\u4f8b\uff0c\u5df2\u89e3\u9664\u9694\u79bb14\u4f8b\uff09\uff0c\u73b0\u67092\u4f8b\u3002\r\n\r\n\u9655\u897f\u65b0\u589e1\u4f8b\u65e0\u75c7\u72b6\u611f\u67d3\u8005\uff0c\u4e3a5\u670822\u65e5\u56fd\u9645\u5305\u673a\u65c5\u5ba2\uff0c\u843d\u5730\u540e\u5747\u843d\u5b9e\u6d77\u5173\u68c0\u75ab\u3001\u6838\u9178\u68c0\u6d4b\u3001\u70b9\u5bf9\u70b9\u8f6c\u8fd0\u3001\u9694\u79bb\u533b\u5b66\u89c2\u5bdf\u7b49\u95ed\u73af\u7ba1\u7406\u63aa\u65bd\uff0c\u65e0\u9655\u897f\u7701\u5185\u81ea\u884c\u6d3b\u52a8\u8f68\u8ff9\u30026\u67083\u65e5\uff0c\u8be5\u5305\u673a1\u540d\u65c5\u5ba2\u5728\u9694\u79bb\u671f\u95f4\uff0c\u7ecf\u5b9a\u70b9\u533b\u7597\u673a\u6784\u3001\u897f\u5b89\u5e02\u75be\u63a7\u4e2d\u5fc3\u53ca\u6d77\u5173\u6838\u9178\u68c0\u6d4b\u590d\u68c0\u5448\u9633\u6027\uff0c\u65e0\u53d1\u70ed\u7b49\u75c7\u72b6\uff0c\u80f8\u90e8CT\u65e0\u5f02\u5e38\u3002\u7ecf\u7701\u7ea7\u4e13\u5bb6\u7ec4\u4f1a\u8bca\uff0c\u7ed3\u5408\u60a3\u8005\u4e34\u5e8a\u75c7\u72b6\u3001\u5f71\u50cf\u68c0\u67e5\u7ed3\u679c\u3001\u6838\u9178\u68c0\u6d4b\u7ed3\u679c\uff0c\u8bca\u65ad\u4e3a\u65b0\u51a0\u80ba\u708e\u65e0\u75c7\u72b6\u611f\u67d3\u8005\u3002\u76ee\u524d\u7ee7\u7eed\u5728\u5b9a\u70b9\u533b\u7597\u673a\u6784\u9694\u79bb\u533b\u5b66\u89c2\u5bdf\u3002\u540c\u822a\u73ed\u5176\u4ed69\u540d","updatedAt":"2020-06-04 17:14:11"}]}
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
        tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.tableview.mj_header?.endRefreshing()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.viewModel.loadDetailCells()
            self.tableview.mj_footer?.endRefreshing()
        })
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
        self.viewModel.loadDetailCells()
    }
}
