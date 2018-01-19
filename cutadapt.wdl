task cutadapt {
    File read1
    File? read2
    String read1output
    String? read2output
    String? format
    String? condaEnv
    Int? cores = 1
    Array[String]? adapter
    Array[String]? front
    Array[String]? anywhere
    Array[String]? adapterRead2
    Array[String]? frontRead2
    Array[String]? anywhereRead2
    Boolean? interleaved
    String? pairFilter
    Float? errorRate
    Boolean? noIndels
    Int? times
    Int? overlap
    Boolean? matchReadWildcards
    Boolean? noMatchAdapterWildcards
    Boolean? noTrim
    Boolean? maskAdapter
    Int? cut
    String? nextseqTrim
    String? qualityCutoff
    Int? qualityBase
    Int? length
    Boolean? trimN
    String? lengthTag
    String? stripSuffix
    String? prefix
    String? suffix
    Int? minimumLength
    Int? maximumLength
    Int? maxN
    Boolean? discardTrimmed
    Boolean? discardUntrimmed
    String? infoFilePath
    String? restFilePath
    String? wildcardFilePath
    String? tooShortOutputPath
    String? tooLongOutputPath
    String? untrimmedOutputPath
    String? tooShortPairedOutputPath
    String? tooLongPairedOutputPath
    String? untrimmedPairedOutputPath
    Boolean? colorspace
    Boolean? doubleEncode
    Boolean? trimPrimer
    Boolean? stripF3
    Boolean? maq
    Boolean? bwa
    Boolean? zeroCap
    Boolean? noZeroCap

    command {
        set -e -o pipefail
        ${"source activate " + condaEnv}
        cutadapt \
        ${"--cores=" + cores} \
        ${sep="-a " "-a " + adapter} ${"-A " + adapterRead2} \
        ${"-g" + front} ${"-G" + frontRead2} \
        ${"-b " + anywhere} ${"-B" + anywhereRead2} \
        --output ${read1output} ${"--paired-output " + read2output} \
        ${"--to-short-output " + tooShortOutputPath} ${"--to-short-paired-output " + tooShortPairedOutputPath} \
        ${"--to-long-output " + tooLongOutputPath} ${"--to-long-paired-output " + tooLongPairedOutputPath} \
        ${"--untrimmed-output " + untrimmedOutputPath} ${"--untrimmed-paired-output " + untrimmedPairedOutputPath} \
        ${"--pair-filter " + pairFilter} \
        ${"--error-rate " + errorRate} \
        ${"--times " + times} \
        ${"--overlap " + overlap} \
        ${"--cut " + cut} \
        ${"--nextseq-trim " + nextseqTrim} \
        ${"--quality-cutoff " + qualityCutoff} \
        ${"--quality-base " + qualityBase} \
        ${"--length " + length} \
        ${"--length-tag " + lengthTag} \
        ${"--strip-suffix " + stripSuffix} \
        ${"--prefix " + prefix} \
        ${"--suffix " + suffix} \
        ${"--minimum-length " + minimumLength} \
        ${"--maximum-length " + maximumLength} \
        ${"--max-n " + maxN} \
        ${true="--discard-untrimmed" false="" discardUntrimmed} \
        ${"--info-file " + infoFilePath } \
        ${"--rest-file " + restFilePath } \
        ${"--wildcard-file " + wildcardFilePath} \
        ${true="--match-read-wildcards" false="" matchReadWildcards} ${true="--no-match-adapter-wildcards" false="" noMatchAdapterWildcards} \
        ${true="--no-trim" false="" noTrim} ${true="--mask-adapter" false="" maskAdapter} \
        ${true="--no-indels" false="" noIndels} ${true="--trim-n" false="" trimN}  \
        ${true="--interleaved" false="" interleaved} ${true="--discard-trimmed" false="" discardTrimmed } \
        ${true="--colorspace" false="" colorspace} ${true="--double-encode" false="" doubleEncode} \
        ${true="--strip-f3" false="" stripF3} ${true="--maq" false="" maq} ${true="--bwa" false="" bwa} \
        ${true="--zero-cap" false="" zeroCap} ${true="--no-zero-cap" false="" noZeroCap} \
        ${read1} ${read2}
    }
    output{
        File report = stdout()
        File cutRead1 = read1output
        File? cutRead2 = read2output
        File? tooLongOutput=tooLongOutputPath
        File? tooShortOutput=tooShortOutputPath
        File? untrimmedOutput=untrimmedOutputPath
        File? tooLongPairedOutput=tooLongPairedOutputPath
        File? tooShortPairedOutput=tooShortPairedOutputPath
        File? untrimmedPairedOutput=untrimmedPairedOutputPath
        File? infoFile=infoFilePath
        File? restFile=restFilePath
        File? wildcardFile=wildcardFilePath
    }
    runtime {
        cpu: select_first(cores)
    }
}