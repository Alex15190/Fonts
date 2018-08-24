//
//  BIDFavoritesList.m
//  Fonts
//
//  Created by Alex Chekodanov on 23.08.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "BIDFavoritesList.h"

@interface BIDFavoritesList()

@property (strong, nonatomic) NSMutableArray *favorites;

@end

@implementation BIDFavoritesList
#warning Fix Singleton using allocWithZone and copyWithZone
+ (instancetype)sharedFavoritesList
{
    static BIDFavoritesList *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    if (self = [super init])
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *storedFavorites = [defaults objectForKey:@"favorites"];
        if (storedFavorites)
            self.favorites = [storedFavorites mutableCopy];
        else
            self.favorites = [NSMutableArray array];
    }
    return self;
}

- (void)addFavorite:(id)item
{
    [_favorites insertObject:item atIndex:0];
    [self saveFavorites];
}

- (void)removeFavorite:(id)item
{
    [_favorites removeObject:item];
    [self saveFavorites];
}

- (void)saveFavorites
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.favorites forKey:@"favorites"];
    [defaults synchronize];
}

- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to
{
    id item = _favorites[from];
    [_favorites removeObjectAtIndex:from];
    [_favorites insertObject:item atIndex:to];
    [self saveFavorites];
}

@end
