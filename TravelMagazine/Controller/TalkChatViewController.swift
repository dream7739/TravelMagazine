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
        let friendNib = UINib(nibName: FriendChatTableViewCell.reuseIdentifier, bundle: nil)
        chatTableView.register(friendNib, forCellReuseIdentifier: FriendChatTableViewCell.reuseIdentifier)
        
        //내 메시지 cell 등록
        let myNib = UINib(nibName: MyChatTableViewCell.reuseIdentifier, bundle: nil)
        chatTableView.register(myNib, forCellReuseIdentifier: MyChatTableViewCell.reuseIdentifier)

    }

}

extension TalkChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list!.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = list!.chatList[indexPath.row]

        if data.user == User.user {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.reuseIdentifier, for: indexPath) as! MyChatTableViewCell
            
            cell.configureData(data)
            
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendChatTableViewCell.reuseIdentifier, for: indexPath) as! FriendChatTableViewCell
            
            cell.configureData(data)
            
            return cell
        }
  
    }
    
    
}
