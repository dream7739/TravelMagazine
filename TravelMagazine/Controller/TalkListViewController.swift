//
//  TalkListViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 6/1/24.
//

import UIKit

class TalkListViewController: UIViewController {
    
    @IBOutlet var talkTableView: UITableView!
    
    private let list = mockChatList
    
    private var filteredList: [ChatRoom] = []{
        didSet {
            talkTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("TRAVEL TALK")
        configureTableView()
        configureSearchView()
        filteredList = list
    }
    
}

extension TalkListViewController {
    private func configureTableView(){
        talkTableView.delegate = self
        talkTableView.dataSource = self
        talkTableView.rowHeight = 90
        talkTableView.showsVerticalScrollIndicator = false
        talkTableView.keyboardDismissMode = .onDrag
        
        let nib = UINib(nibName: TalkListTableViewCell.reuseIdentifier, bundle: nil)
        talkTableView.register(nib, forCellReuseIdentifier: TalkListTableViewCell.reuseIdentifier)
    }
    
    private func configureSearchView(){
        let searchVC = UISearchController(searchResultsController: nil)
        searchVC.searchBar.placeholder = "친구 이름을 검색해보세요"
        searchVC.searchBar.searchTextField.clearsOnBeginEditing = true
        searchVC.searchBar.searchTextField.tintColor = .darkGray
        searchVC.searchBar.tintColor = .black
        searchVC.searchResultsUpdater = self
        
        navigationItem.searchController = searchVC
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

extension TalkListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TalkListTableViewCell.reuseIdentifier, for: indexPath) as! TalkListTableViewCell
        
        let talkData = filteredList[indexPath.row]
        cell.configureData(talkData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatList = list[indexPath.row]
        
        let chatVC = storyboard?.instantiateViewController(withIdentifier: TalkChatViewController.reuseIdentifier) as! TalkChatViewController
        chatVC.list = chatList
        
        navigationController?.pushViewController(chatVC, animated: true)
    }
}

extension TalkListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let inputText = searchController.searchBar.text!
        
        if !inputText.trimmingCharacters(in: .whitespaces).isEmpty {
            
            filteredList.removeAll()
            
            for listItem in list {
                for chatImage in listItem.chatroomImage {
                    if chatImage.localizedCaseInsensitiveContains(inputText) {
                        filteredList.append(listItem)
                    }
                }
            }
        }else {
            filteredList = list
        }
    }
    
    
    
}
