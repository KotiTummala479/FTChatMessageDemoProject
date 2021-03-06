//
//  FTChatMessageBubbleImageItem.swift
//  ChatMessageDemoProject
//
//  Created by liufengting https://github.com/liufengting on 16/5/7.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

class FTChatMessageBubbleImageItem: FTChatMessageBubbleItem {
    
    convenience init(frame: CGRect, aMessage : FTChatMessageModel ) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        message = aMessage
        messageBubblePath = self.getBubbleShapePathWithSize(frame.size, isUserSelf: aMessage.isUserSelf)
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = messageBubblePath.CGPath
        maskLayer.frame = self.bounds
        maskLayer.contentsScale = UIScreen.mainScreen().scale;
        
        let layer = CAShapeLayer()
        layer.mask = maskLayer
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        
        if let image = UIImage(named : "dog.jpg") {
            layer.contents = image.CGImage
        }
        //
        //        SDWebImageManager.sharedManager().downloadWithURL(NSURL(string : message.messageText),
        //                                                          options: .ProgressiveDownload,
        //                                                          progress: { (a, b) in
        //                                                            },
        //                                                          completed: { (downloadImage, error, cachType, finished) in
        //
        //                                                            if finished == true && downloadImage != nil{
        //                                                                layer.contents = downloadImage.CGImage
        //                                                            }
        //
        //                                                            })
    }
    
    
    
}
