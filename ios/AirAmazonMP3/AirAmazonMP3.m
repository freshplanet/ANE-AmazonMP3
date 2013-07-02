//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////

#import "AirAmazonMP3.h"

FREContext AirAmazonMP3Ctx = nil;

@implementation AirAmazonMP3

#pragma mark - Singleton

static AirAmazonMP3 *sharedInstance = nil;

+ (AirAmazonMP3 *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

#pragma mark - AirAmazonMP3

+ (void)dispatchEvent:(NSString *)eventName withInfo:(NSString *)info
{
    if (AirAmazonMP3Ctx != nil)
    {
        FREDispatchStatusEventAsync(AirAmazonMP3Ctx, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[info UTF8String]);
    }
}

+ (void)log:(NSString *)message
{
    [AirAmazonMP3 dispatchEvent:@"LOGGING" withInfo:message];
}

@end


#pragma mark - C interface

void AirAmazonMP3ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
                        uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) 
{
    // Register the links btwn AS3 and ObjC. (dont forget to modify the nbFuntionsToLink integer if you are adding/removing functions)
    NSInteger nbFuntionsToLink = 0;
    *numFunctionsToTest = nbFuntionsToLink;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * nbFuntionsToLink);
    
    *functionsToSet = func;
    
    AirAmazonMP3Ctx = ctx;
}

void AirAmazonMP3ContextFinalizer(FREContext ctx) { }

void AirAmazonMP3Initializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
	*extDataToSet = NULL;
	*ctxInitializerToSet = &AirAmazonMP3ContextInitializer;
	*ctxFinalizerToSet = &AirAmazonMP3ContextFinalizer;
}

void AirAmazonMP3Finalizer(void *extData) { }
