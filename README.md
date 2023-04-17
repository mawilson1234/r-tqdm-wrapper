# A `tqdm`-style loop wrapper for R

This is a demo of how you can write a `tqdm`-style wrapper to display a progress bar in a `for`-loop in R. It's not quite as convenient as `tqdm`, since you have to remember to do an extra step at the beginning of the loop to properly bind the variable. (If anyone knows of a way to have this happen automatically, please submit an issue or a PR!)

## Explanation

`get.progress.bar` is a simple function that returns a string progress bar, based on the `cur`rent value, the `max`imum value, and the desired `width`. You can set the progress `char`, the character to use for the part of the bar that hasn't happened yet (`space_char`), and a `postfix` (which is added to the `width`). It's pretty self-explanatory.

`progress` is a function that serves a `tqdm`-style wrapper around sequences, designed to be used in `for`-loops. You could use it outside of loops, too, but I'm not sure why you would. The "magic" is that instead of returning the sequence, it instead returns a list of anonymous functions that print the progress bar when called, and then return the desired value.

The last bit of code is a demo of the progress bar. Unlike `tqdm`, you must actually call the anonymous function returned by `progress` and bound in the `for`-loop. This is why the first line of the loop is `i <- i()`; this binds `i` to the return value of `i` (like we want), but also prints the progress bar when it's called. I don't currently know of a way to get around the need to do this manually, but I'd be interested if there is a way to do this and make the functionality entirely transparent so end users don't have to take an extra step.