hl(1) -- Highlight text in an output stream or file
===================================================

## SYNOPSIS

`grep term file | hl other_term` 

`hl term file1 file2`

`hl --color=blue --inverse --underline --bright term file1 file2`

`hl -c cyan -iub term file1 file2`

## INSTALL

    $ gem install hl

## DESCRIPTION

**hl** is a command-line tool for highlighting text in an output stream or file, to assist in visually scanning such output.  The most common use-case is when trying to scan the output of a `grep` that has complex data or long lines.  In this case, you don't want to further grep the output for the term you're looking for, bit instead simply need a visual cue as to where the secondary search term is in the output.

## OPTIONS

  * `-c COLOR`, `--color=COLOR`:
    Color to use for highlighting.  Available colors are red, green, yellow, blue, magenta, cyan, or white,
    with yellow being the default.

  * `-i`, `--inverse`:
    Inverse highlight.  Shows the highlighting in inverse, with the background of the highlight being the selected color and the foreground being the color of your terminal's background.

  * `-u`, `--underline`:
    Underline highlight.

  * `-b`, `--bright`:
    Use bright colors.  Shows the highlighting using the bright version of the color.

  * `-h`, `--help`, `--version`:
    Show the version and help information

## ENVIRONMENT

Default options can be specified in the `HL_OPTS` environment variable, exactly as they would appear on the command line.

## EXAMPLES

Highlight the output of grep

    grep '2012-01-02' some_log_file.txt | hl 'user_id'

Highlight the word "user_id" in bright cyan in several files

    hl --color=cyan -b user_id some_file some_other_file yet_a_third_file

## AUTHOR

David Copeland, davec (at) naildrivin5.com

## COPYRIGHT

hl is copyright(c) 2012 by David Copeland, released under the Apache license.

## SEE ALSO

  * Source on github: https://github.com/davetron5000/hl
