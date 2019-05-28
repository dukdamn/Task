//
//  UserManager.swift
//  Instagram
//
//  Created by Wi on 03/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation
import UIKit


// 매니저 클래스 구현 유무는 선택사항입니다.

class UserManager {
    
    static let shared = UserManager()
    
    private var userDefaults = UserDefaults.standard
    
    private var user = User(userName: "", profileImage: nil)
    
    private init(){}
    
    func changeUserName(userName: String, completion: (Bool, String) -> ()) {
        guard let localUserData = userDefaults.array(forKey: "userName"),
            var userNames = localUserData as? [String]
            else { userDefaults.set([userName], forKey: "userName")
            self.user.userName = userName
            completion(true, userName)
            return
        }
        if userNames.contains(userName) {
            completion(false, "중복된 닉네임이 있습니다.")
            return
        }
        userNames.append(userName)
        UserDefaults.setValue(userName, forKey: "userName")
        self.user.userName = userName
        completion(true, userName)
        
    }
    
    func getUserInfo(completion: (User) ->()) {
        completion(user)
    }
    
    func changeUserInfo(user: User, completion:(User) -> ()) {
        self.user = user
        completion(self.user)
    }
    
}