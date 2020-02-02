# calendar-events

`calendar-events` - for non-recurring calendar events

## Synopsis

    calendar-events [-h] [(-A|-B) number] [(-lt|-le|-gt|-ge|-eq|-ne) yyyy-mm-dd] [(-bt|-be) yyyy-mm-dd yyyy-mm-dd] [-f filepath] [-co]

## Description

`calendar-events` is a companion to the venerable `calendar` program. `calendar` is designed to handle recurring events, like birthdays, paydays, or holidays---`calendar-events` is for non-recurring events, like dates or concerts. It can handle specific dates and, optionally, times.

## Usage

If no file is specified, a file at `~/.calendar/calendar-events` will be used if it exists.

Events are queried with options used by both `calendar` (like `-A` and `-B`) and `test` (like `-lt` and `-ge`). For querying events, the general form is:

    calendar-events QUERY NUM|DATE

Matching events will be printed to stdout.

If no arguments are given, then the query will check for events on the current date. If the only argument given is a date, then the query option `-eq` (equals) will be assumed.

The options are:

    -A n: query events up to n days before today
    
    -B n: query events up to n days after today
    
    -be date date: query events on or between the given dates
    
    -bt date date: query events between the given dates
    
    -co: print output sortable with output from `calendar`
    
    -eq date: query events on the given date
    
    -f filepath: use the given file instead of the default
    
    -ge date: query events on or after the given date
    
    -gt date: query events after the given date
    
    -h: display a help message
    
    -le date: query events on or before the given date
    
    -lt date: query events before the given date
    
    -ne date: query events not on the given date

Dates must be specified in the format YYYY-MM-DD.

Any number of query forms can be given. Only events matching every query will be printed.

## Data File

The format of the data file is similar to that expected by `calendar`. Events are listed like:

    2020-01-01 10:30	New Year's brunch
    2020-01-23	Game night
    2020-02-21	Go
    	on
    	a
    	long
    	vacation

That is:

0. A date in the format YYYY-MM-DD.
1. Optionally, a time in the format HH:MM separated from the date by a space.
2. A tab character.
3. A description.

Descriptions can span multiple lines if the lines following the first begin with a tab character.

Lines that do not match this format are ignored.

## Examples

Query events happening today:

     $ calendar-events

Query events happening after today:

    $ calendar-events -gt 2020-01-31

Query events happening between Halloween and an election:

    $ calendar-events -bt 2020-10-31 2020-11-03

Query events happening this February, combine them with February's `calendar` events, and sort the results:

    $ (calendar-events -ge 2020-02-01 -lt 2020-03-01 -co ; calendar -t 2020-02-01 -A 28) | sort -M

## Dependencies

- ruby

## Installation

0. Clone the repository: https://github.com/rmavis/calendar-events.
1. Create a symlink to the executable `calendar-events` somewhere in your $PATH.
2. Ensure the executable is executable (`chmod` it 744, etc).
3. There is no step 3.
