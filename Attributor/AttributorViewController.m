//
//  AttributorViewController.m
//  Attributor
//
//  Created by Michał Kozak on 09.06.2014.
//  Copyright (c) 2014 razvizion. All rights reserved.
//

#import "AttributorViewController.h"
#import "TextStatsViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Analyze Text"]){
        if([segue.destinationViewController isKindOfClass:[TextStatsViewController class]]){
            TextStatsViewController *tsvc = (TextStatsViewController *)segue.destinationViewController;
            tsvc.textToAnalyze = self.body.textStorage;
        }
        
    }
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{NSStrokeWidthAttributeName :@3,NSStrokeColorAttributeName:self.outlineButton.tintColor} range:NSMakeRange(0, [title length])];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFont];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(prefferedFontsChanged:)
                                                name:UIContentSizeCategoryDidChangeNotification
                                              object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

-(void)prefferedFontsChanged:(NSNotification *)notification
{
    [self usePreferredFont];
}

-(void)usePreferredFont
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font  = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender
{
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
    
}

- (IBAction)outlineBodySelection:(id)sender
{
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName :@-3,NSStrokeColorAttributeName:[UIColor blackColor]} range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection:(id)sender
{
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
