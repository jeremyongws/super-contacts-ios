//
//  Contacts.m
//  SpecialContacts
//
//  Created by Jeremy Ong on 04/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "Contact.h"

@implementation Contact


- (Contact*) initWithName:(NSString *)name andNumber:(NSString *)number{
	Contact *temp = [[Contact alloc] init];
	temp.name = name;
	temp.number = number;
	return temp;
}

@end
