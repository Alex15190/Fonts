//
//  BIDFontInfoViewController.m
//  Fonts
//
//  Created by Alex Chekodanov on 24.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "BIDFontInfoViewController.h"
#import "BIDFavoritesList.h"

@interface BIDFontInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fontSampleLabel;
@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLable;
@property (weak, nonatomic) IBOutlet UISwitch *favoriteSwitch;

@end

@implementation BIDFontInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fontSampleLabel.font = self.font;
    self.fontSampleLabel.text = @"AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz 0123456789";
    self.fontSizeSlider.value = self.font.pointSize;
    self.fontSizeLable.text = [NSString stringWithFormat:@"%.0f",self.font.pointSize];
    self.favoriteSwitch.on = self.favorite;
}

- (IBAction)slideFontSize:(UISlider *)slider
{
    float newSize = roundf(slider.value);
    self.fontSampleLabel.font = [self.font fontWithSize:newSize];
    self.fontSizeLable.text = [NSString stringWithFormat:@"%.0f",newSize];
}

-(IBAction)toggleFavorite:(UISwitch *)sender
{
    BIDFavoritesList *favoriteList = [BIDFavoritesList sharedFavoritesList];
    if (sender.on)
        [favoriteList addFavorite:self.font.fontName];
    else
        [favoriteList removeFavorite:self.font.fontName];
}

@end
