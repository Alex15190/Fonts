//
//  BIDFavoritesList.h
//  Fonts
//
//  Created by Alex Chekodanov on 23.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDFavoritesList : NSObject

+ (instancetype)sharedFavoritesList;

- (NSArray *)favorites;

- (void)addFavorite:(id)item;
- (void)removeFavorite:(id)item;

- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;

@end
