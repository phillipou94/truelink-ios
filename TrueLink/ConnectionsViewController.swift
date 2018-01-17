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
        self.nicknameMap = LocalStorageManager.shared.nicknameMap()
        ItayRequest.shared.getItays(success: { (itays) in
            self.itays = itays
            if (self.itays.count < 1) {
                self.showEmptyState(viewType: EmptyView.EmptyViewType.NoITAYs)
            }
            self.tableView.isHidden = self.itays.count < 1
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.emptyView.removeFromSuperview()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ConnectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! ConnectionTableViewCell
        let itay = self.itays[indexPath.row]
        cell.itay = itay
        
        if itay.fromMe {
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
        
        cell.timestampLabel.text = "Sent "+itay.dateString

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
