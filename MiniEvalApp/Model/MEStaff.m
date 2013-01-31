//
<<<<<<< HEAD
//  MEStaff.m
=======
//  MEPerson.m
>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b
//  MiniEvalApp
//
//  Created by viet on 1/21/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "MEStaff.h"
#import "MECompanyAPIClient.h"

#import "AFImageRequestOperation.h"

NSString * const kUserProfileImageDidLoadNotification = @"com.alamofire.user.profile-image.loaded";

<<<<<<< HEAD
//#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
//@interface MEPerson ()
//+ (NSOperationQueue *)sharedProfileImageRequestOperationQueue;
//@end
//#endif
=======
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
@interface MEPerson ()
+ (NSOperationQueue *)sharedProfileImageRequestOperationQueue;
@end
#endif
>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b


@implementation MEStaff{
@private
    NSString *_avatarImageURLString;
    AFImageRequestOperation *_avatarImageRequestOperation;
}
<<<<<<< HEAD
//@implementation MEPerson{
//@private
//    NSString *_avatarImageURLString;
//    AFImageRequestOperation *_avatarImageRequestOperation;
//}
=======

>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b

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
    
<<<<<<< HEAD
    if (self)
    {
=======
    if (self) {
>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b
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
    }
    
    return self;
}

<<<<<<< HEAD
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

+ (void)findHighestVisitedPerson:(NSArray *)persons
{
    MEStaff *p = [[MEStaff alloc] init];
    for (MEStaff *person in persons)
    {
        person.highestVisitedCount = NO;
        if ([p.visitedCount unsignedIntValue] < [person.visitedCount unsignedIntValue])
        {
            p = person;
        }
    }
    p.highestVisitedCount = YES;
}


=======
>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b
+ (void)globalTimelineContactsWithBlock:(void (^)(NSMutableArray *results, NSError *error))block {
    [[MECompanyAPIClient sharedInstance] getPath:kAppAPIPath parameters:nil
                                     success:^(AFHTTPRequestOperation *operation, id response) {
                                         
                                         NSMutableArray *persons = [NSMutableArray arrayWithCapacity:[response count]];
                                         
                                         for (id obj in response)
                                         {
                                             if ([obj isKindOfClass:[NSDictionary class]]) {
                                                 MEStaff *person = [[MEStaff alloc] initWithDictionary:(NSDictionary *)obj];
                                                 [persons addObject:person];
                                             }
                                         }                                         
                                         
                                         if (block) {
                                             block([NSMutableArray arrayWithArray:persons], nil);
                                         }
                                     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         if (block) {
                                             block([NSMutableArray array], error);
                                         }
                                     }];
}


<<<<<<< HEAD
//- (NSURL *)avatarImageURL {
//    return [NSURL URLWithString:_avatarImageURLString];
//}

//#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
//
//@synthesize profileImage = _profileImage;
//
//+ (NSOperationQueue *)sharedProfileImageRequestOperationQueue {
//    static NSOperationQueue *_sharedProfileImageRequestOperationQueue = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedProfileImageRequestOperationQueue = [[NSOperationQueue alloc] init];
//        [_sharedProfileImageRequestOperationQueue setMaxConcurrentOperationCount:8];
//    });
//    
//    return _sharedProfileImageRequestOperationQueue;
//}
//
//- (NSImage *)profileImage {
//	if (!_profileImage && !_avatarImageRequestOperation) {
//		_avatarImageRequestOperation = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:self.avatarImageURL] success:^(NSImage *image) {
//			self.profileImage = image;
//            
//			_avatarImageRequestOperation = nil;
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:kUserProfileImageDidLoadNotification object:self userInfo:nil];
//		}];
//        
//		[_avatarImageRequestOperation setCacheResponseBlock:^NSCachedURLResponse *(NSURLConnection *connection, NSCachedURLResponse *cachedResponse) {
//			return [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:cachedResponse.userInfo storagePolicy:NSURLCacheStorageAllowed];
//		}];
//		
//        [[[self class] sharedProfileImageRequestOperationQueue] addOperation:_avatarImageRequestOperation];
//	}
//	
//	return _profileImage;
//}
//
//#endif
//
=======
- (NSURL *)avatarImageURL {
    return [NSURL URLWithString:_avatarImageURLString];
}

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED

@synthesize profileImage = _profileImage;

+ (NSOperationQueue *)sharedProfileImageRequestOperationQueue {
    static NSOperationQueue *_sharedProfileImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProfileImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_sharedProfileImageRequestOperationQueue setMaxConcurrentOperationCount:8];
    });
    
    return _sharedProfileImageRequestOperationQueue;
}

- (NSImage *)profileImage {
	if (!_profileImage && !_avatarImageRequestOperation) {
		_avatarImageRequestOperation = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:self.avatarImageURL] success:^(NSImage *image) {
			self.profileImage = image;
            
			_avatarImageRequestOperation = nil;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserProfileImageDidLoadNotification object:self userInfo:nil];
		}];
        
		[_avatarImageRequestOperation setCacheResponseBlock:^NSCachedURLResponse *(NSURLConnection *connection, NSCachedURLResponse *cachedResponse) {
			return [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:cachedResponse.userInfo storagePolicy:NSURLCacheStorageAllowed];
		}];
		
        [[[self class] sharedProfileImageRequestOperationQueue] addOperation:_avatarImageRequestOperation];
	}
	
	return _profileImage;
}

#endif

>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b
@end
