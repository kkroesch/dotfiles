""" Logging decorators for multiple purposes.
"""

from time import time_ns, perf_counter, sleep
import functools
from logging import debug, info


def trace(func):
    """Log the function signature and return value"""
    @functools.wraps(func)
    def wrapper_debug(*args, **kwargs):
        args_repr = [repr(a) for a in args]
        kwargs_repr = [f"{k}={v!r}" for k, v in kwargs.items()]
        signature = ", ".join(args_repr + kwargs_repr)
        debug(f"Calling {func.__name__}({signature})")
        value = func(*args, **kwargs)
        debug(f"{func.__name__!r} returned {value!r}") 
        return value
    return wrapper_debug


def log(func):
    """ Simply log function calls """
    @functools.wraps(func)
    def log_wrapper(*args, **kwargs):
        info(f"{func.__name__}")
        return func(*args, **kwargs)
    return log_wrapper


def timer(func):
    """Print the runtime of the decorated function"""
    @functools.wraps(func)
    def wrapper_timer(*args, **kwargs):
        start_time = perf_counter()
        value = func(*args, **kwargs)
        end_time = perf_counter()
        run_time = end_time - start_time
        debug(f"Finished {func.__name__!r} in {run_time:.4f} secs")
        return value
    return wrapper_timer


def slow_down(_func=None, *, rate=1):
    """Sleep given amount of seconds before calling the function"""
    def decorator_slow_down(func):
        @functools.wraps(func)
        def wrapper_slow_down(*args, **kwargs):
            sleep(rate)
            return func(*args, **kwargs)
        return wrapper_slow_down

    if _func is None:
        return decorator_slow_down
    else:
        return decorator_slow_down(_func)
