//
//  MEStaff.m
//  MiniEvalApp
//
//  Created by viet on 1/21/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "AFImageRequestOperation.h"

NSString * const kUserProfileImageDidLoadNotification = @"com.alamofire.user.profile-image.loaded";

@implementation MEStaff {}

- (void) setTimeStamp:(NSDate *)timeStamp
{
    if (!_timeStamp) {
        _timeStamp = [[NSDate alloc] init];
    }
    _timeStamp = timeStamp;
}

- (id)initWithDictionary:(NSDictionary *)personDictionary
{
    self = [super init];
    
    if (self)
    {
        self.userId = [[personDictionary objectForKey:@"_id"] objectForKey:@"$oid"];
        self.name = [personDictionary objectForKey:@"name"];
        self.userName = [personDictionary objectForKey:@"userName"];
        self.role = [personDictionary objectForKey:@"role"];
        self.like = [personDictionary objectForKey:@"like"];
        self.dislike = [personDictionary objectForKey:@"dislike"];
        self.timeStamp = [personDictionary objectForKey:@"timeStamp"];
        self.gender = [personDictionary objectForKey:@"gender"];
        self.image = [personDictionary objectForKey:@"image"];
        self.contact = [personDictionary objectForKey:@"contact"];
        
        self.visitedCount = [personDictionary objectForKey:@"vistitedCount"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.visitedCount forKey:@"visitedCount"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self)
    {
        _userId = [decoder decodeObjectForKey:@"userId"];
        _visitedCount = [decoder decodeObjectForKey:@"visitedCount"];
    }
    return self;
}




@end
