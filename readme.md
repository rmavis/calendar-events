# calendar-events

`calendar-events` - for non-recurring calendar events

## Synopsis

    calendar-events [-h] [(-A|-B) number] [(-lt|-le|-gt|-ge|-eq|-ne) yyyy-mm-dd] [(-bt|-be) yyyy-mm-dd yyyy-mm-dd] [-f filepath]

## Description

`calendar-events` is a companion to the venerable `calendar` program. `calendar` is designed to handle recurring events, like birthdays, paydays, or holidays---`calendar-events` is for non-recurring events, like dates or concerts. It can handle specific dates and, optionally, times.

The format of the data file is similar to that expected by `calendar`. Events are listed like

    2020-01-01 10:30	New Year's brunch
    2020-01-23	Game night
    2020-02-21	Go
    	on
    	a
    	long
    	vacation

That is:

0. A date in the format YYYY-MM-DD.
1. Optionally, a time in the format HH:MM.
2. A tab character.
3. A description.

Descriptions can span multiple lines if the lines following the first begin with a tab character.

Lines that do not match this format are ignored.

If no file is specified, a file at `~/.calendar/calendar-events` will be checked.

Events are queried with options used by both `calendar` (like `-A` and `-B`) and `test` (like `-lt` and `-ge`).

Readme coming soon. In the meantime, see the [options][options] file for a usage summary.

[options]: ./options
