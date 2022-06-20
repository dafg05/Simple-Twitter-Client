//
//  User.m
//  twitter
//
//  Created by Daniel Flores Garcia on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

// TODO: Add properties

// TODO: Create initializer

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
    // Initialize any other properties
    }
    return self;
}

@end
