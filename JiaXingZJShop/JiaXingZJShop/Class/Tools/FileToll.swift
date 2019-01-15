//
//  FileToll.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class FileTool: NSObject {
    
    static let fileManager = FileManager.default
    
    /// 计算单个文件的大小
    class func fileSize(_ path: String) -> Double {
        
        if fileManager.fileExists(atPath: path) {
            var dict = try? fileManager.attributesOfItem(atPath: path)
            if let fileSize = dict![FileAttributeKey.size] as? Int{
                return Double(fileSize) / 1024.0 / 1024.0
            }
        }
        
        return 0.0
    }
    
    /// 计算整个文件夹的大小
    class func folderSize(_ path: String) -> Double {
        var folderSize: Double = 0
        if fileManager.fileExists(atPath: path) {
            let chilerFiles = fileManager.subpaths(atPath: path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.appendingPathComponent(fileName)
                folderSize += FileTool.fileSize(fileFullPathName)
            }
            return folderSize
        }
        return 0
    }
    
    /// 清除文件 同步
    class func cleanFolder(_ path: String, complete:() -> ()) {

        let chilerFiles = self.fileManager.subpaths(atPath: path)
        for fileName in chilerFiles! {
            let tmpPath = path as NSString
            let fileFullPathName = tmpPath.appendingPathComponent(fileName)
            if self.fileManager.fileExists(atPath: fileFullPathName) {
                do {
                    try self.fileManager.removeItem(atPath: fileFullPathName)
                } catch _ {
                    
                }
            }
        }
        
        complete()
    }
    
    /// 清除文件 异步
    class func cleanFolderAsync(_ path: String, complete:@escaping () -> ()) {

        let queue = DispatchQueue(label: "cleanQueue", attributes: [])
        queue.async { () -> Void in
            let chilerFiles = self.fileManager.subpaths(atPath: path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.appendingPathComponent(fileName)
                if self.fileManager.fileExists(atPath: fileFullPathName) {
                    do {
                        try self.fileManager.removeItem(atPath: fileFullPathName)
                    } catch _ {
                    }
                }
            }
            
            complete()
        }
    }
}
