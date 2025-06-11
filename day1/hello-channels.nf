#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
params.greeting = "greetings.csv"

process sayHello {
    publishDir 'results', mode: 'copy'

    input:
    val greeting

    output:
    path "${greeting}-output.txt"

    script:
    """
    echo '${greeting}' > ${greeting}-output.txt 
    """
}

workflow {
    // create a channel for inputs
    greeting_ch = Channel.fromPath(params.greeting)
        .view { csv -> "Before splitCsv: ${csv}" }
        .splitCsv()
        .map { item -> item[0] }
        .view { csv -> "After splitCsv: ${csv}" }
    // emit a greeting
    sayHello(greeting_ch)
}
