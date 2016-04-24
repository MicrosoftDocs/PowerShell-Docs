function say-something {

    Param(
        $param
    )

    begin { }
    process { write-output "Hello $param!" }
    end { }
}
