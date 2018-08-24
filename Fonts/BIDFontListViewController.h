//
//  BIDFontListViewController.h
//  Fonts
//
//  Created by Alex Chekodanov on 24.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDFontListViewController : UITableViewController

@property (copy, nonatomic) NSArray *fontNames;
@property (assign, nonatomic) BOOL showsFavorites;

@end
