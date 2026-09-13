#import <Foundation/Foundation.h>
#import "FRPSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface FRPSettings : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<FRPSection *> *sections;

- (instancetype)initWithTitle:(NSString *)title sections:(NSArray<FRPSection *> *)sections;

@end

NS_ASSUME_NONNULL_END