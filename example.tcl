#!/usr/bin/env tclsh

namespace eval api {
   proc func1 {arg} {
	   # fixme: proc should be called with right number of args.
       # At the moment it is just passing argv.
	   return [lindex $arg 0]
   }
   proc func2 {arg} {
   }
}

source robotremoteserver.tcl

