package elabnik

import org.gradle.api.DefaultTask
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.options.Option

class BuildHTMLTask extends DefaultTask {
    @Option(description = "Source file name or template without `.tex` suffix")
    String source

    @Option(description = "the name of the target xml/html")
    String target

    Map parameters = [:]

    File logDir = new File(project.buildDir, "logs")

    @OutputDirectory
    File xmlDir = new File(project.buildDir, "xml")

    @OutputDirectory
    File htmlDir = new File(project.buildDir, "html")

    @TaskAction
    def run() {
        if(source == null){
            throw new RuntimeException("Source file is undefined")
        }
        def target = target ?: source

        File texFile = project.file(source + ".tex")
        def sourceFile = Utils.loadTex(project, texFile, target, parameters)

        def xmlFile = new File(xmlDir, "${target}.xml")

        logDir.mkdirs()
        xmlDir.mkdirs()
        //Customize command for linux
        def command = ["wsl"]
        def xmlLine = command + ["latexml",
                                 "--destination=\"${Utils.linuxify(project, xmlFile.absolutePath)}\"",
                                 "--inputencoding=utf8",
                                 "\"${Utils.linuxify(project, sourceFile.absolutePath)}\""
        ]

        logger.lifecycle("Preparing xml")
        logger.lifecycle("Using command line for latexml $target: ${xmlLine.join(" ")}")
        project.exec {
            workingDir '.'
            errorOutput(new FileOutputStream(new File(logDir, "${target}.xml.log")))
            //TODO убрать первый аргумент для линукса
            commandLine xmlLine
        }

        htmlDir.mkdirs()

        def htmlLine = command + [
                "latexmlpost",
                "--destination=${Utils.linuxify(project, htmlDir.toString())}/${xmlFile.name.replaceFirst(~/\.[^.]+$/, '')}.html",
                "--format=html5",
                "--split",
                "--splitat=section",
                "--javascript='http://fred-wang.github.io/mathjax.js/mpadded-min.js'",
                "--css=labnik.css",
                Utils.linuxify(project, xmlFile.absolutePath)
        ]

        logger.lifecycle("Command line for latexmlpost $target: ${htmlLine.join(" ")}")

        project.exec {
            workingDir '.'
            errorOutput(new FileOutputStream(new File(logDir, "${target}.html.log")))
            commandLine htmlLine

        }
    }
}
