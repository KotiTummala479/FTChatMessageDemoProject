//
//  FTChatMessageInputView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/3/22.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

protocol FTChatMessageInputViewDelegate {
    func FTChatMessageInputViewShouldUpdateHeight(desiredHeight : CGFloat)
    func FTChatMessageInputViewShouldDoneWithText(textString : String)
}

class FTChatMessageInputView: UIToolbar, UITextViewDelegate{

    var recordButton : UIButton!
    var inputTextView : UITextView!
    var addButton : UIButton!
    var inputDelegate : FTChatMessageInputViewDelegate?
    var buttonBottomMargin : CGFloat = 0
    var textViewWidth : CGFloat = FTScreenWidth
    var textEdgeInset: UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonBottomMargin = (self.bounds.height - FTDefaultButtonSize)/2
        
        recordButton = UIButton(frame:CGRectMake(FTDefaultMargin, self.bounds.height - FTDefaultButtonSize - buttonBottomMargin, FTDefaultButtonSize,FTDefaultButtonSize))
        recordButton.setBackgroundImage(UIImage(named: "FT_Record"), forState: .Normal)
        recordButton.backgroundColor = FTDefaultInputViewBackgroundColor
        self.addSubview(recordButton)
        
        
        textViewWidth = FTScreenWidth - (FTDefaultMargin*4 + FTDefaultButtonSize*2)
        
        inputTextView = UITextView(frame: CGRectMake(FTDefaultMargin*2 + FTDefaultButtonSize, FTDefaultInputTextViewMargin , textViewWidth, self.bounds.height - FTDefaultInputTextViewMargin*2))
        inputTextView.font = FTDefaultFontSize
        inputTextView.layer.cornerRadius = FTDefaultMargin
        inputTextView.layer.borderColor = FTDefaultIncomingColor.CGColor
        inputTextView.layer.borderWidth = 0.8
        inputTextView.delegate = self
        inputTextView.bounces = false
        inputTextView.returnKeyType = .Send
        inputTextView.textContainerInset = textEdgeInset
        self.addSubview(inputTextView)
        
        addButton = UIButton(frame:CGRectMake(FTScreenWidth - FTDefaultButtonSize - FTDefaultMargin, self.bounds.height - FTDefaultButtonSize - buttonBottomMargin, FTDefaultButtonSize,FTDefaultButtonSize))
        addButton.setBackgroundImage(UIImage(named: "FT_Add"), forState: .Normal)
        addButton.backgroundColor = FTDefaultInputViewBackgroundColor
        self.addSubview(addButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     convenience init
     
     - parameter frame:        frame
     - parameter otherButtons: otherButtons
     
     - returns:
     */
//    convenience init(frame: CGRect, otherButtons: String) {
//        self.init(frame : frame)
//        
//
//    }

    /**
     clearText
     */
    func clearText(){
        inputTextView.text = ""
        if (inputDelegate != nil) {
            inputDelegate!.FTChatMessageInputViewShouldUpdateHeight(FTDefaultInputViewHeight)
        }
    }
    
    
    /**
     UITextViewDelegate
     
     - parameter textView: textView
     */
    

    
    func textViewDidChange(textView: UITextView) {
        if let text : NSString = textView.text as NSString {
            let textRect = text.boundingRectWithSize(CGSizeMake(textViewWidth - textView.textContainerInset.left - textView.textContainerInset.right, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize], context: nil);

            if (inputDelegate != nil) {
                inputDelegate!.FTChatMessageInputViewShouldUpdateHeight(min(max(textRect.height + FTDefaultInputTextViewMargin*2 + textView.textContainerInset.top + textView.textContainerInset.bottom, FTDefaultInputViewHeight), 150))
            }
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if (inputDelegate != nil) {
                inputDelegate!.FTChatMessageInputViewShouldDoneWithText(textView.text)
            }
            return false;
        }
        return true;
    }
    

    
    /**
     drawRect
     
     - parameter rect: rect
     */
    func updateSubViewFrame() {
    
        self.recordButton.frame = CGRectMake(FTDefaultMargin, self.bounds.height - FTDefaultButtonSize - buttonBottomMargin, FTDefaultButtonSize,FTDefaultButtonSize)
        
        self.addButton.frame = CGRectMake(FTScreenWidth - FTDefaultButtonSize - FTDefaultMargin, self.bounds.height - FTDefaultButtonSize - buttonBottomMargin, FTDefaultButtonSize,FTDefaultButtonSize)
        
        self.inputTextView.frame = CGRectMake(FTDefaultMargin*2 + FTDefaultButtonSize, FTDefaultInputTextViewMargin, self.textViewWidth, self.bounds.height - FTDefaultInputTextViewMargin*2)
    }
    
}
