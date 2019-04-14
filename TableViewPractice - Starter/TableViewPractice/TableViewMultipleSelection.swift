//
//  TableViewMultipleSelection.swift
//  TableViewPractice
//
//  Created by 이봉원 on 10/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

  /***************************************************
   [ 실습 - TableViewRefresh 기능을 이어서 수행 ]
 
   1) 처음 화면에 띄워질 목록은 1부터 지정한 숫자까지의 숫자들을 출력
   2) 이후 갱신할 때마다 임의의 숫자들이 출력되도록 할 것
      랜덤 숫자의 범위는 출력할 숫자 개수의 +50 이며, 모든 숫자는 겹치지 않아야 함.
      (여기까지 TableViewRefresh 실습 내용과 동일)
   3) 특정 테이블뷰셀을 선택하고 갱신하면 해당 셀에 있던 숫자는 유지되고 나머지 숫자들만 랜덤하게 갱신되도록 처리
      (셀을 선택한 순서에 따라 그대로 다음 갱신 목록에 출력)
      e.g. 20, 10 두 개의 숫자를 선택하고 갱신하면, 다음 숫자 목록은 (20, 10, random, random...)
   4) 위 3번에서 숫자를 선택할 때 그 숫자가 7보다 작은 셀은 선택이 되지 않도록 처리.
 
   < 힌트 >
   키워드 - willSelectRow, selectedRow, multipleSelection
   ***************************************************/


import UIKit

final class TableViewMultipleSelection: UIViewController {
  
  override var description: String {
    return "Task 1 - MultipleSelection"
  }
  
    // MARK: - Properties
  let tableView = UITableView()
    let maxCount = 20
    let maxRange = 50
    lazy var data = Array(1...maxCount)

  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()    // setup table view 실행
  }
    
    // MARK: - table view option setting 및 refresh control option setting
    func setupTableView () {
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        tableView.allowsMultipleSelection = true
        view.addSubview(tableView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Now Loading...")
        tableView.refreshControl = refreshControl
    }
    
    @objc func reloadData() {
        let selectedNumber = data
        data.removeAll()    // data 전체 삭제
        
        for selected in tableView.indexPathsForSelectedRows! {
            data.append(selectedNumber[selected.row])
            print(selectedNumber[selected.row])     // 값 확인용
        }
        
        generateRandomNumber()
        tableView.refreshControl?.endRefreshing()   // refresh control이 구동중이면 멈춘다
        tableView.reloadData()
    }
    
    
    func generateRandomNumber() {
        #if swift(>=4.2)
        let randomNumber = (1...(maxCount + maxRange)).randomElement()
        #else
        let randomNumber = Int(arc4random_uniform(UInt32(maxCount + maxRange)))
        #endif
        
        guard !data.contains(randomNumber!) else { return generateRandomNumber() }
        data.append(randomNumber!)
        guard data.count >= 20 else { return generateRandomNumber() }
    }
}

// MARK: - UITableViewDataSource

extension TableViewMultipleSelection: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    cell.textLabel?.text = "\(data[indexPath.row])"
    return cell
  }
}

// MARK: - 7이하 숫자를 선택못하게 하는 table view delegate 지정
extension TableViewMultipleSelection: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let clickableNumber = Int(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? ""), clickableNumber > 7 else { return nil }
        
        return indexPath
    }
}