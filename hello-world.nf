#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
params.greeting = 'Hello World!'
process sayHello {
    publishDir 'results', mode: 'copy'
    output:
        path 'output.txt'
    input:
        val greeting
    script:
    """
    echo '$greeting' > output.txt
    """
}

workflow {

    // emit a greeting
    sayHello(params.greeting)
}
