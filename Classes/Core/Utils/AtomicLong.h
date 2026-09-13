#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AtomicLong : NSObject

@property (nonatomic, assign) int64_t value;

- (instancetype)initWithValue:(int64_t)value;
- (int64_t)incrementAndGet;
- (int64_t)decrementAndGet;
- (int64_t)getAndIncrement;
- (int64_t)getAndDecrement;
- (int64_t)getAndSet:(int64_t)newValue;
- (BOOL)compareAndSet:(int64_t)expectValue withUpdate:(int64_t)update;

@end

NS_ASSUME_NONNULL_END