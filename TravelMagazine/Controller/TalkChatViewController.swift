//
//  TalkChatViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 6/1/24.
//

import UIKit

class TalkChatViewController: UIViewController {
    
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var chatTextView: UITextView!
    @IBOutlet var textBottomAnchor: NSLayoutConstraint!
    var list : ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let chatData = list else { return }
        configureView(chatData.chatroomName)
        configureNavItem(style: .pop)
        configureTableView()
        registerKeybordNotification()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        chatTableView.scrollToRow(at: IndexPath(row: list!.chatList.count-1, section: 0), at: .bottom, animated: false)
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object:  nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification,  object: nil)
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
    
    func registerKeybordNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize.height - view.safeAreaInsets.bottom)
            textBottomAnchor.constant = keyboardSize.height - view.safeAreaInsets.bottom
        }
    }
    
    @objc func keybordWillHide(_ notification: Notification) {
        textBottomAnchor.constant = 0
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
