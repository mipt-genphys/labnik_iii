package elabnik

import groovy.transform.CompileStatic
import groovy.xml.XmlUtil
import org.gradle.api.DefaultTask
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.options.Option


class ProcessSvgTask extends DefaultTask {
    @Option(description = "The source root for svg-s")
    File sourceDir

    @Option(description = "Destination directory for svgs")
    @OutputDirectory
    File destinationDir = new File(project.buildDir, "html")

    float fontSize = 12


    private Node processSvg(Node svg) {
        svg.depthFirst().findAll {
            it instanceof Node && it.name().localPart == "text"
        }.each {
            it["@style"] = it["@style"].replaceAll("font-size:(.*)px;", "font-size:${fontSize}px;")
//            def text = it.tspan[0].value()[0]
//            if (text != null && text instanceof String) {
//                it.tspan[0].value = text
//                        .replaceAll("\\\$\\\\text\\{(.*)\\}.*\\\$") { whole, content -> content }
//                        .replaceAll("\\\$(.*)\\\$"){whole, content -> content}
//            }
        }

        return svg
    }

    private void writeSvg(File initialFile, Node svg) {
        def relPath = sourceDir.toPath().relativize(initialFile.toPath()).toFile().toString()
        def outputFile = new File(destinationDir, relPath)
        outputFile.parentFile.mkdirs()
        XmlUtil.serialize(svg, outputFile.newOutputStream())
    }

    @CompileStatic
    @TaskAction
    def run() {
        sourceDir.eachFileRecurse {
            if (it.name.endsWith(".svg")) {
                Node svg = new XmlParser().parse(it)
                Node processed = processSvg(svg)
                writeSvg(it, processed)
            }
        }
    }

}
