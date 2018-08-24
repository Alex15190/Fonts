//
//  BIDFontListViewController.m
//  Fonts
//
//  Created by Alex Chekodanov on 24.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "BIDFontListViewController.h"
#import "BIDFavoritesList.h"
#import "BIDFontSizesViewController.h"
#import "BIDFontInfoViewController.h"

@interface BIDFontListViewController ()

@property (assign, nonatomic) CGFloat cellPointSize;

@end

@implementation BIDFontListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellPointSize = preferredTableViewFont.pointSize;
    if (self.showsFavorites)
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.showsFavorites)
    {
        self.fontNames = [BIDFavoritesList sharedFavoritesList].favorites;
        [self.tableView reloadData];
    }
}

- (UIFont *)fontForDisplayAtIndexPath: (NSIndexPath *)indexPath
{
    NSString *fontName = self.fontNames[indexPath.row];
    return [UIFont fontWithName:fontName size:self.cellPointSize];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fontNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FontName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = self.fontNames[indexPath.row];
    cell.detailTextLabel.text = self.fontNames[indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    return 25 + font.ascender - font.descender;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.showsFavorites;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.showsFavorites) return;
    
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString *favorite = self.fontNames[indexPath.row];
        [[BIDFavoritesList sharedFavoritesList] removeFavorite:favorite];
        self.fontNames = [BIDFavoritesList sharedFavoritesList].favorites;
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BIDFavoritesList sharedFavoritesList] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
    self.fontNames = [BIDFavoritesList sharedFavoritesList].favorites;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    [segue.destinationViewController navigationItem].title = font.fontName;
    if ([segue.identifier isEqualToString:@"ShowFontSizes"])
    {
        BIDFontSizesViewController *sizesVC = segue.destinationViewController;
        sizesVC.font = font;
    }
    else if ([segue.identifier isEqualToString:@"ShowFontInfo"])
    {
        BIDFontInfoViewController *infoVC = segue.destinationViewController;
        infoVC.font = font;
        infoVC.favorite = [[BIDFavoritesList sharedFavoritesList].favorites containsObject:font.fontName];
    }
    
}
@end
