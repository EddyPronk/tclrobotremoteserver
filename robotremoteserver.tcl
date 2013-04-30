source xmlrpc.tcl

xmlrpc::serve 8270

proc get_keyword_names {} {
	set keywords {}
	foreach procname [info commands api::* ] {
		set val [string range $procname 7 end]
		lappend keywords [list string $val]
	}
	set result [dict create]
	dict set result "array" $keywords
	return $result
}

proc get_keyword_documentation {a} {
	return {string "not implemented"}
}

proc get_keyword_arguments {func} {
	set keywords {}
	foreach procname [info args api::$func] {
		lappend keywords [list string $procname]
	}
	set result [dict create]
	dict set result "array" $keywords
	return $result
}

proc run_keyword {name args} {
	set err3 [dict create]
	dict set err3 status {string "PASS"}
	set return_value [::api::$name $args]
	set return_tup [list string $return_value]
	dict set err3 return $return_tup
	set result [dict create]
	dict set result dict $err3
	return $result
}

vwait forever
