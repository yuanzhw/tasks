version 1.0

# Copyright (c) 2017 Leiden University Medical Center
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

task PeakCalling {
    input {
        Array[File]+ inputBams
        Array[File]+ inputBamsIndex
        Array[File]+? controlBams
        Array[File]+? controlBamsIndex
        String outDir = "macs2"
        String sampleName
        Boolean nomodel = false

        String memory = "8G"
        String dockerImage = "quay.io/biocontainers/macs2:2.1.2--py27r351_0"
    }

    command {
        set -e
        macs2 callpeak \
        --treatment ~{sep = ' ' inputBams} \
        ~{true="--control" false="" defined(controlBams)} ~{sep = ' ' controlBams} \
        --outdir ~{outDir} \
        --name ~{sampleName} \
        ~{true='--nomodel' false='' nomodel}
    }

    output {
        File peakFile = outDir + "/" + sampleName + "_peaks.narrowPeak"
    }

    runtime {
        cpu: 1
        memory: memory
        docker: dockerImage
    }
    parameter_meta {
        inputBams: {description: "The BAM files on which to perform peak calling.", category: "required"}
        inputBamsIndex: {description: "The indexes for the input BAM files.", category: "required"}
        controlBams: {description: "Control BAM files for the input bam files.", category: "required"}
        controlBamsIndex: {description: "The indexes for the control BAM files.", category: "required"}
        sampleName: {description: "Name of the sample to be analysed", category: "required"}
        outDir: {description: "All output files will be written in this directory.", category: "advanced"}
        nomodel: {description: "Whether or not to build the shifting model.", category: "advanced"}
        memory: {description: "The amount of memory this job will use.", category: "advanced"}
        timeMinutes: {description: "The maximum amount of time the job will run in minutes.", category: "advanced"}
        dockerImage: {description: "The docker image used for this task. Changing this may result in errors which the developers may choose not to address.", category: "advanced"}

    }
}
