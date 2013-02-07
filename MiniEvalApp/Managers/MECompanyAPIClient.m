//
//  MEAppAPIClient.m
//  MiniEvalApp
//
//  Created by viet on 1/21/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//


#import "MECompanyAPIClient.h"

@interface MECompanyAPIClient()
@property (nonatomic, strong) NSMutableArray *allStaffs;
@end

@implementation MECompanyAPIClient


+ (id)sharedInstance {
    static MECompanyAPIClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[MECompanyAPIClient alloc] initWithBaseURL:
                            [NSURL URLWithString:kAppAPIBaseURLString]];
    });
    
    return __sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    self.allStaffs = [NSMutableArray array];
    
    return self;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        //custom settings
        [self setDefaultHeader:@"x-api-token" value:kAppAPIToken];
        
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    
    return self;
}



- (void)globalTimelineContactsWithBlock:(void (^)(NSMutableArray *results, NSError *error))block {
    
    [self getPath:kAppAPIPath parameters:nil
          success:^(AFHTTPRequestOperation *operation, id response) {
              
              NSMutableArray *persons = [NSMutableArray arrayWithCapacity:[response count]];
              
              for (id obj in response)
              {
                  if ([obj isKindOfClass:[NSDictionary class]]) {
                      MEStaff *person = [[MEStaff alloc] initWithDictionary:(NSDictionary *)obj];
                      [persons addObject:person];
                  }
              }
              
              self.allStaffs = persons;
              
              if (block) {
                  block(persons, nil);
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block([NSMutableArray array], error);
              }
          }];
}

- (void)updateHighestVisitedPerson
{
    NSInteger highestCount = 0;
//
    //find highest count value of allStaffs
    for (MEStaff *person in self.allStaffs)
    {
        if ([person.visitedCount unsignedIntegerValue] > highestCount)
            highestCount = [person.visitedCount unsignedIntegerValue];
    }
//
    for (MEStaff *person in self.allStaffs)
    {
        if ([person.visitedCount unsignedIntegerValue] >= highestCount)
            person.highestVisitedCount = YES;
        else
            person.highestVisitedCount = NO;
    }
}



@end
