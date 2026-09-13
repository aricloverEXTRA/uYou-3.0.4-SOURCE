#import "AtomicLong.h"
#import <libkern/OSAtomic.h>

@implementation AtomicLong {
    int64_t _value;
}

- (instancetype)initWithValue:(int64_t)value {
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (int64_t)incrementAndGet {
    return OSAtomicIncrement64(&_value);
}

- (int64_t)decrementAndGet {
    return OSAtomicDecrement64(&_value);
}

- (int64_t)getAndIncrement {
    int64_t oldValue;
    do {
        oldValue = _value;
    } while (!OSAtomicCompareAndSwap64(oldValue, oldValue + 1, &_value));
    return oldValue;
}

- (int64_t)getAndDecrement {
    int64_t oldValue;
    do {
        oldValue = _value;
    } while (!OSAtomicCompareAndSwap64(oldValue, oldValue - 1, &_value));
    return oldValue;
}

- (int64_t)getAndSet:(int64_t)newValue {
    int64_t oldValue;
    do {
        oldValue = _value;
    } while (!OSAtomicCompareAndSwap64(oldValue, newValue, &_value));
    return oldValue;
}

- (BOOL)compareAndSet:(int64_t)expectValue withUpdate:(int64_t)update {
    return OSAtomicCompareAndSwap64(expectValue, update, &_value);
}

@end