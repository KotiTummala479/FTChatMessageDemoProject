//
//  FTChatMessageCell.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit




class FTChatMessageCell: UITableViewCell {

    var messageTimeLabel: UILabel!
    var messageSenderLabel: UILabel!
    var messageBubbleItem: FTChatMessageBubbleItem!
    var message : FTChatMessageModel!
    var cellDesiredHeight : CGFloat = 60
    var imageResource : UIImage?


    
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        message = theMessage

        var timeLabelRect = CGRectZero
        var nameLabelRect = CGRectZero
        var bubbleRect = CGRectZero
        
        if shouldShowSendTime {
            timeLabelRect = CGRectMake(0, -FTDefaultSectionHeight ,FTScreenWidth, FTDefaultTimeLabelHeight);
            nameLabelRect = CGRectMake(0, FTDefaultTimeLabelHeight - FTDefaultSectionHeight, FTScreenWidth, 0);

            messageTimeLabel = UILabel(frame: timeLabelRect);
            messageTimeLabel.text = "\(message.messageTimeStamp)"
            messageTimeLabel.textAlignment = .Center
            messageTimeLabel.textColor = UIColor.lightGrayColor()
            messageTimeLabel.font = FTDefaultTimeLabelFont
            self.addSubview(messageTimeLabel)
        }else{
            nameLabelRect = CGRectMake(0, -FTDefaultSectionHeight, FTScreenWidth, 0);
        }
        
        if shouldShowSenderName {
            var nameLabelTextAlignment : NSTextAlignment = .Left
            
            if theMessage.isUserSelf {
                nameLabelRect = CGRectMake( 0, (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2  - FTDefaultSectionHeight  , FTScreenWidth - (FTDefaultMargin + FTDefaultIconSize + FTDefaultAngleWidth), FTDefaultNameLabelHeight)
                nameLabelTextAlignment =  .Right
            }else{
                nameLabelRect = CGRectMake(FTDefaultMargin + FTDefaultIconSize + FTDefaultAngleWidth, (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2  - FTDefaultSectionHeight ,FTScreenWidth, FTDefaultNameLabelHeight)
                nameLabelTextAlignment = .Left
            }
            messageSenderLabel = UILabel(frame: nameLabelRect);
            messageSenderLabel.text = "\(message.messageSender.senderName)"
            messageSenderLabel.textAlignment = nameLabelTextAlignment
            messageSenderLabel.textColor = UIColor.lightGrayColor()
            messageSenderLabel.font = FTDefaultTimeLabelFont
            self.addSubview(messageSenderLabel)
        }
        
        let y : CGFloat = nameLabelRect.origin.y + nameLabelRect.height + FTDefaultMargin
        var bubbleWidth : CGFloat = 200
        var bubbleHeight : CGFloat = 200
        
        switch message.messageType {
        case .Text:
            let att = NSString(string: message.messageText)
            let rect = att.boundingRectWithSize(CGSizeMake(FTDefaultTextInViewMaxWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], context: nil)
            bubbleWidth = rect.width + FTDefaultTextMargin*2 + FTDefaultAngleWidth
            bubbleHeight = rect.height + FTDefaultTextMargin*2
        case .Image:
            imageResource =  UIImage(named : "dog.jpg")
            bubbleWidth = FTDefaultMessageBubbleWidth
            bubbleHeight = imageResource == nil ? FTDefaultMessageBubbleHeight : (imageResource?.size.height)! * (FTDefaultMessageBubbleWidth/(imageResource?.size.width)!)
            
            
            
            
            
        case .Audio:
            bubbleWidth = FTDefaultMessageBubbleWidth
            bubbleHeight = FTDefaultMessageBubbleAudioHeight
        case .Location:
            bubbleWidth = FTDefaultMessageBubbleWidth
            bubbleHeight = FTDefaultMessageBubbleHeight
        case .Video:
            bubbleWidth = FTDefaultMessageBubbleWidth
            bubbleHeight = FTDefaultMessageBubbleHeight
        }
        
        let x = theMessage.isUserSelf ? FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin) - bubbleWidth : FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
        
        bubbleRect = CGRectMake(x, y, bubbleWidth, bubbleHeight)
        self.cellDesiredHeight = bubbleRect.origin.y + bubbleHeight + FTDefaultMargin*2
        
//        if message.messageType == .Image {
//            messageBubbleItem = FTChatMessageBubbleItem(frame: bubbleRect, aMessage: message ,image: imageResource)
//        }else{
//            messageBubbleItem = FTChatMessageBubbleItem(frame: bubbleRect, aMessage: message ,image: nil)
//        }
//        self.addSubview(messageBubbleItem)
        
        self.setupCellBubbleItem(bubbleRect)

    }
    
    func setupCellBubbleItem(bubbleFrame: CGRect) {
    
        switch message.messageType {
        case .Text:

            messageBubbleItem = FTChatMessageBubbleTextItem(frame: bubbleFrame, aMessage: message ,image: nil)

        
        case .Image:
            messageBubbleItem = FTChatMessageBubbleImageItem(frame: bubbleFrame, aMessage: message ,image: imageResource)
        case .Audio:

            messageBubbleItem = FTChatMessageBubbleAudioItem(frame: bubbleFrame, aMessage: message ,image: nil)

        case .Location:

            messageBubbleItem = FTChatMessageBubbleLocationItem(frame: bubbleFrame, aMessage: message ,image: nil)

        case .Video:
        
            messageBubbleItem = FTChatMessageBubbleVideoItem(frame: bubbleFrame, aMessage: message ,image: nil)

            
        }

        self.addSubview(messageBubbleItem)

        
        
        
    }
    
    
    
    
    
    
    

    class func getCellHeightWithMessage(theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) -> CGFloat{
        var cellDesiredHeight : CGFloat = 0;
        if shouldShowSendTime {
            cellDesiredHeight = FTDefaultTimeLabelHeight
        }
        if shouldShowSenderName {
            cellDesiredHeight = (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2 + FTDefaultNameLabelHeight
        }
        cellDesiredHeight += FTDefaultMargin
        switch theMessage.messageType {
        case .Text:
            let att = NSString(string: theMessage.messageText)
            let textRect = att.boundingRectWithSize(CGSizeMake(FTDefaultTextInViewMaxWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], context: nil)
            cellDesiredHeight += textRect.height + FTDefaultTextMargin*2
        case .Image:
            cellDesiredHeight += FTDefaultMessageBubbleHeight
        case .Audio:
            cellDesiredHeight += FTDefaultMessageBubbleAudioHeight
        case .Location:
            cellDesiredHeight += FTDefaultMessageBubbleHeight
        case .Video:
            cellDesiredHeight += FTDefaultMessageBubbleHeight
        }
        cellDesiredHeight += FTDefaultMargin*2 - FTDefaultSectionHeight

        return cellDesiredHeight
    }
    
    
    
    
}



