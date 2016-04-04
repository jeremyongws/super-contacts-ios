//
//  Contacts.h
//  SpecialContacts
//
//  Created by Jeremy Ong on 04/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property NSString *name;
@property NSString *number;

- (Contact*) initWithName:(NSString *)name andNumber:(NSString *)number;

@end
