package elabnik


import org.gradle.api.DefaultTask
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.options.Option

class BuildPdfTask extends DefaultTask {
    @Option(description = "Source file name or template without `.tex` suffix")
    String source

    @Option(description = "the name of the target pdf")
    String target

    Map parameters = [:]

    File logDir = new File(project.buildDir, "logs")

    @OutputDirectory
    File outputDir = new File(project.buildDir, "pdf")

    @TaskAction
    def run() {
        if(source == null){
            throw new RuntimeException("Source file is undefined")
        }
        def target = target ?: source

        File texFile = project.file(source + ".tex")
        def sourceFile = Utils.loadTex(project, texFile, target, parameters)

        outputDir.mkdirs()
        logDir.mkdirs()

        def line = ["lualatex", "-synctex=1", "-interaction=nonstopmode", "-output-directory=${outputDir}", "-job-name=\"${target}\"", "${sourceFile.absolutePath}"]

        logger.info("Using command line for fragment $target: ${line.join(" ")}")

        2.times {
            logger.info("Lualatex iteration $it")
            project.exec {
                workingDir '.'
                standardOutput(new FileOutputStream(new File(logDir, "${target}.log")))
                commandLine line
            }
        }
    }
}
