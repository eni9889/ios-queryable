//
//  BaseTest.m
//  ios-queryableTests
//
//  Created by Marty on 2012-11-07.
//  Copyright (c) 2012 Marty. All rights reserved.
//

#import "BaseTest.h"
#import "Product.h"
#import <CoreData/CoreData.h>

@implementation BaseTest

-(void)seedTestData:(NSManagedObjectContext*)context
{
    for(int i = 0; i < 10; ++i)
    {
        Product* product = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Product"
                               inManagedObjectContext:context];
        product.name = [NSString stringWithFormat:@"Product %d", i];
        product.created_on = [NSDate dateWithTimeIntervalSinceNow:1000];
    }
    
    [context save:nil];
}

-(NSManagedObjectContext*)getContext
{
    NSBundle* bundle = [NSBundle bundleWithIdentifier:@"org.codeninja.ios-queryable.tests"];
    
    NSManagedObjectModel* managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:bundle]];
    
    NSPersistentStoreCoordinator* persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSPersistentStore* store = [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:0];
    
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = persistentStoreCoordinator;

    [self seedTestData:context];
    return context;
}

@end
