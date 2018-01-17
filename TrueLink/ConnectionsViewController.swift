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
    let sectionHeaderHeight = CGFloat(20.0)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.TLOffWhite()

        let topMargin = CGFloat(DefaultNavBar.height()+UIApplication.shared.statusBarFrame.height)
        let tableViewFrame = CGRect(x: 0, y: topMargin, width: self.view.frame.size.width, height: self.view.frame.size.height-topMargin)
        self.tableView = UITableView.init(frame: tableViewFrame, style: .grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.backgroundColor = UIColor.TLOffWhite()
        self.view.addSubview(self.tableView)
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
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableViewHeader = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.sectionHeaderHeight))
        let headerLabelFrame = CGRect(x: 10, y:0, width: tableView.frame.size.width, height:sectionHeaderHeight)

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
