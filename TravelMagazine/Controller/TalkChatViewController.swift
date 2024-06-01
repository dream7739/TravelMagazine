//
//  TalkChatViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 6/1/24.
//

import UIKit

class TalkChatViewController: UIViewController {

    @IBOutlet var chatTableView: UITableView!
    
    var list : ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let chatData = list else { return }
        configureView(chatData.chatroomName)
        configureNavItem(style: .pop)
        configureTableView()
    }
    
}

extension TalkChatViewController {
    func configureTableView(){
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.separatorStyle = .none
        
        //친구 메시지 cell 등록
        let nib = UINib(nibName: FriendChatTableViewCell.reuseIdentifier, bundle: nil)
        chatTableView.register(nib, forCellReuseIdentifier: FriendChatTableViewCell.reuseIdentifier)
    }

}

extension TalkChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list!.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendChatTableViewCell.reuseIdentifier, for: indexPath) as! FriendChatTableViewCell
        
        let data = list!.chatList[indexPath.row]
        
        cell.configureData(data)
        
        return cell
    }
    
    
}
