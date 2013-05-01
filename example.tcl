#!/usr/bin/env tclsh

namespace eval api {
   proc func1 {arg1 arg2} {
	   return $arg1
   }
   proc func2 {arg} {
   }
}

source robotremoteserver.tcl

