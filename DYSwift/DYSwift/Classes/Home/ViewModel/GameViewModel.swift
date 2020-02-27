//
//  GameViewModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/25.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import Foundation

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
    
}

extension GameViewModel {
    
    func loadAllGameData(finishedCallback : @escaping ()->()) {
        NetworkTools.requestData(type: .POST, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            guard let resultDict = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                return
            }
            
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
