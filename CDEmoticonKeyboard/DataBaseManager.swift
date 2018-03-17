//
//  DataBaseManager.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/17.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import Foundation
import FMDB

class DataBaseManager: NSObject {
    
    static let shared = DataBaseManager()
    
    private override init() {
        super.init()
        createTable()
    }
    
    private lazy var db : FMDatabase = {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last?.appending("/content.db")
        let db = FMDatabase(path: path)
        return db
    }()
    
    private func createTable() -> Void {
        if !db.open() {
            return
        }
        let createTableSql = "CREATE TABLE IF NOT EXISTS t_content(id integer PRIMARY KEY,content text)"
        do {
            try db.executeUpdate(createTableSql, values: nil)
        } catch {
            print("CREATE TABLE ERROR : \(error.localizedDescription)")
        }
    }
    
    func insertTable(content : String) throws -> Void {
        if !db.open() {
            return
        }
        try db.executeUpdate("INSERT INTO t_content(content) VALUES(?)", values: [content])
    }
    
    func queryTable() -> [String] {
        var arr = [String]()
        if !db.open() {
            return arr
        }
        do {
            let results = try db.executeQuery("SELECT c.content FROM t_content c", values: nil)
            while results.next() {
                if let content = results.string(forColumn: "content"){
                    arr.append(content)
                }
            }
        } catch {
            print("QUERY TABLE ERROR : \(error.localizedDescription)")
        }
        return arr
    }
    
    func closeDataBase() -> Void {
        db.close()
    }
    
}
