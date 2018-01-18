//
//  ConnectionsViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class ConnectionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var emptyView = UIView()
    var tableView = UITableView()
    let cellIdentifier = "ConnectionTableViewCell"
    let cellHeight = CGFloat(65.0)
    let sectionHeaderHeight = CGFloat(40.0)
    
    var itays : [Itay] = []
    var nicknameMap : [String:String] = [:]
    var shouldAnimateFirstRow = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.TLOffWhite()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let topMargin = CGFloat(DefaultNavBar.height()+UIApplication.shared.statusBarFrame.height)
        let tableViewFrame = CGRect(x: 0, y: topMargin, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.tableView = UITableView.init(frame: tableViewFrame, style: .grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.backgroundColor = UIColor.TLOffWhite()
        self.view.addSubview(self.tableView)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = self.refreshControl
        } else {
            tableView.addSubview(self.refreshControl)
        }
        self.getItaysFromServer {
            self.tableView.isHidden = self.itays.count < 1
//            self.tableView.reloadData()
        }
    }
    
    func getItaysFromServer(completed:@escaping () -> Void) {
        self.nicknameMap = LocalStorageManager.shared.nicknameMap()
        self.itays = LocalStorageManager.shared.getItays()
        ItayRequest.shared.getItays(success: { (serverItays) in
            if self.itays.count < serverItays.count {
                self.animateNewItay(itay: serverItays[0])
                LocalStorageManager.shared.updateItays(itays: serverItays)
                self.itays = serverItays
            } else {
                self.itays = serverItays
                self.tableView.reloadData()
            }
            
            if (self.itays.count < 1) {
                self.showEmptyState(viewType: EmptyView.EmptyViewType.NoITAYs)
            }
            completed()

        }) { (error) in
            
        }

        
    }
    
    func animateNewItay(itay:Itay) {
        let animationDuration = 0.9
        let easeOutCirc = CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.0, 1)
        
        UIView.beginAnimations("addRow", context: nil)
        UIView.setAnimationDuration(animationDuration)
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(easeOutCirc)
        
        self.tableView.beginUpdates()
        self.itays.insert(itay, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .none)
        shouldAnimateFirstRow = true
        tableView.endUpdates()
        
        CATransaction.commit()
        UIView.commitAnimations()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.emptyView.removeFromSuperview()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.TLLightGrey()
        
        return refreshControl
    }()
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.getItaysFromServer {
            self.tableView.isHidden = self.itays.count < 1
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
        
    }
    
    private func showEmptyState(viewType: EmptyView.EmptyViewType) {
        if !(self.view.subviews.contains(self.emptyView)) {
            self.emptyView = EmptyView(view: self.view, viewType: viewType)
            self.view.addSubview(self.emptyView)
        }
    }
    
    //MARK: TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itays.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableViewHeader = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.sectionHeaderHeight))
        let headerLabelFrame = CGRect(x: 10, y:10, width: tableView.frame.size.width, height:sectionHeaderHeight)

        let headerLabel = UILabel.init(frame: headerLabelFrame)
        headerLabel.text = "Today"
        headerLabel.textColor = UIColor.TLBlack()
        headerLabel.font = UIFont.TLFontOfSize(size: 17)
        tableViewHeader.addSubview(headerLabel)
        tableViewHeader.backgroundColor = UIColor.TLOffWhite()
        return tableViewHeader
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && shouldAnimateFirstRow {
            animateIn(cell: cell, withDelay: 0.7)
            shouldAnimateFirstRow = false
        }
    }
    
    fileprivate func animateIn(cell: UITableViewCell, withDelay delay: TimeInterval) {
        let initialScale: CGFloat = 1.2
        let duration: TimeInterval = 0.5
        
        cell.alpha = 0.0
        cell.layer.transform = CATransform3DMakeScale(initialScale, initialScale, 1)
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ConnectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! ConnectionTableViewCell
        let itay = self.itays[indexPath.row]
        cell.selectionStyle = .none
        cell.itay = itay
        
        if itay.fromMe! {
            cell.connectionTypeLabel.text = "Sent"
            cell.connectionTypeLabel.textColor = UIColor.TLOrange()
            cell.connectionTypeImageView.image = UIImage(named: "FullHeartOrange")
            let name = self.nicknameMap[itay.recipientId]
            cell.nameLabel.text = name
        } else {
            cell.connectionTypeLabel.text = "Sent You Love"
            cell.connectionTypeLabel.textColor = UIColor.TLBlack()
            cell.connectionTypeImageView.image = UIImage(named: "HomeIconBlack")
            let name = self.nicknameMap[itay.senderId]
            cell.nameLabel.text = name
        }
        
        if let name = cell.nameLabel.text {
            cell.logoLabel.text = name[0]
        }
        
        if let dateString = itay.dateString == nil ? "Just Now" : itay.dateString {
            cell.timestampLabel.text = "Sent "+dateString
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
