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
        configureTextView()
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
    
    func configureTextView(){
        chatTextView.delegate = self
        chatTextView.layer.cornerRadius = 10
        chatTextView.clipsToBounds = true
        chatTextView.tintColor = .darkGray
        chatTextView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        chatTextView.font = .tertiary
    }
    
    func registerKeybordNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            textBottomAnchor.constant = (keyboardSize.height - view.safeAreaInsets.bottom) + 10
        }
    }
    
    @objc func keybordWillHide(_ notification: Notification) {
        textBottomAnchor.constant = 10
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

extension TalkChatViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        // 1. text에 맞는 사이즈를 구하는 함수 sizeThatFits으로 scroll할 범위를 구하기
        // 2. 오토레이아웃 수정을 통해 height값을 변경
        // 3. 3줄 이상되면 늘어나지 않고 스크롤되게 제한함
        if estimatedSize.height > 88 {
            textView.isScrollEnabled = true
            return
        } else {
            textView.isScrollEnabled = false
            
            textView.constraints.forEach { constraint in
                if constraint.firstAttribute == .height{
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}
