#  Copyright 2013 Eddy Pronk
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

source xmlrpc.tcl

xmlrpc::serve 8270

proc get_keyword_names {} {
	set keywords {}
	foreach procname [info commands api::* ] {
		set val [string range $procname 7 end]
		lappend keywords [list string $val]
	}
	set envelope [dict create]
	dict set envelope "array" $keywords
	return $envelope
}

proc get_keyword_documentation {a} {
	return {string "not implemented"}
}

proc get_keyword_arguments {func} {
	set keywords {}
	foreach procname [info args api::$func] {
		lappend keywords [list string $procname]
	}
	set envelope [dict create]
	dict set envelope "array" $keywords
	return $envelope
}

proc run_keyword {name args} {
	set result [dict create]
	dict set result status {string "PASS"}
	puts $args
	if {[catch {set return_value [eval ::api::$name {*}$args]} err]} {
		puts $err
	}
	set return_tup [list string $return_value]
	dict set result return $return_tup
	set envelope [dict create]
	dict set envelope dict $result
	return $envelope
}

vwait forever
