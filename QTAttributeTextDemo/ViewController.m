//
//  ViewController.m
//  QTAttributeTextDemo
//
//  Created by Cass on 16/10/22.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "ViewController.h"
#import "NSString+QT.h"

@interface ViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UITextField *lineSpaceTextField;

@property (weak, nonatomic) IBOutlet UILabel *textHeightLabel;

@property (weak, nonatomic) IBOutlet UILabel *showTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *boundingRectHeightLabel;

@property (weak, nonatomic) IBOutlet UISwitch *fixMethodSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.lineSpaceTextField.text = @"0";
    self.textView.text = @"测试文字";
    
    
    
}



- (void)textViewDidChange:(UITextView *)textView{

    if (self.fixMethodSwitch.isOn == NO) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:textView.text];
        
        UIFont *font = [UIFont systemFontOfSize:17.0];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = [self.lineSpaceTextField.text integerValue];
        
        [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, textView.text.length)];
        
        [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, textView.text.length)];
        
        self.showTextLabel.attributedText = attributeString;
        
        
        
        
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        
        CGFloat boundingRectHeight = [attributeString boundingRectWithSize:CGSizeMake(self.showTextLabel.frame.size.width, MAXFLOAT) options:options context:nil].size.height;
        if ([attributeString.string isEqualToString:@""]) {
            boundingRectHeight = 0;
        }
        
        
        self.boundingRectHeightLabel.text = [NSString stringWithFormat:@"%f",boundingRectHeight];
        
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        label.attributedText = attributeString;
        CGSize size = [label sizeThatFits:CGSizeMake(self.showTextLabel.frame.size.width, CGFLOAT_MAX)];
        
        self.textHeightLabel.text = [NSString stringWithFormat:@"%f",size.height];
        

    }else{
    
    
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:textView.text];
        
        UIFont *font = [UIFont systemFontOfSize:17.0];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        if ([attributeString.string isMoreThanOneLineWithSize:CGSizeMake(self.showTextLabel.frame.size.width, MAXFLOAT) font:font lineSpaceing:[self.lineSpaceTextField.text integerValue]]) {
            style.lineSpacing = [self.lineSpaceTextField.text integerValue];
        }
        
        
        [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, textView.text.length)];
        
        [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, textView.text.length)];
        
        self.showTextLabel.attributedText = attributeString;
        
    
        
        CGFloat boundingRectHeight = [attributeString.string boundingRectWithSize:CGSizeMake(self.showTextLabel.frame.size.width, MAXFLOAT) font:font lineSpacing:[self.lineSpaceTextField.text integerValue]].height;
        
        self.boundingRectHeightLabel.text = [NSString stringWithFormat:@"%f",boundingRectHeight];
        
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        label.attributedText = attributeString;
        CGSize size = [label sizeThatFits:CGSizeMake(self.showTextLabel.frame.size.width, CGFLOAT_MAX)];
        
        self.textHeightLabel.text = [NSString stringWithFormat:@"%f",size.height];
        

    
    }
    
    
    
    
    
}







@end
