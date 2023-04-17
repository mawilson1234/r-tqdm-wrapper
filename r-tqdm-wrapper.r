# gets a progress bar to be printed
get.progress.bar <- function(
	cur, max, width = getOption('width'), 
	char = '=', space.char = ' ', postfix = ''
) {
	width <- width - 10 # reserve 10 spaces for [, ], (space), XXX.XX%.
	# postfix is in addition to the width
	pr <- cur/max
	nticks <- round(pr * width)
	nspaces <- width - nticks
	ticks <- paste(rep(char, nticks), collapse = '')
	spaces <- paste(rep(space.char, nspaces), collapse = '')
	bar <- sprintf('[%s%s] %7.2f%%', ticks, spaces, round(pr * 100, 2))
	if (postfix != '') {
		bar <- paste0(bar, ', ', postfix)
	}
	return (bar)
}

progress <- function(seq, ...) {
	# this is the magic!
	# we return a list of anonymous functions that print the progress
	# when they are called, and return the value from the sequence.
	# note that this means you have to actually call the function 
	# in the loop to print the bar.
	lapply(
		seq_along(seq),
		\(i) {
			\() {
				message('\r', get.progress.bar(cur = i, max = length(seq), ...), appendLF = FALSE)
				if (i == length(seq)) message('\n', appendLF = FALSE)
				seq[[i]]
			}
		}
	)
}

# demo
for (i in progress(seq_len(1000))) {
 	# you have to call the function to extract the value;
 	# I don't know if there's a way to do this
 	# automatically only when it's bound in the loop
 	i <- i()
	Sys.sleep(0.02)
}