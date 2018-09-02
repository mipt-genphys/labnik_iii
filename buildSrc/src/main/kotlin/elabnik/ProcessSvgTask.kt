package elabnik

import org.gradle.api.DefaultTask
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.options.Option
import org.w3c.dom.Document
import org.w3c.dom.Node
import org.w3c.dom.NodeList
import org.xml.sax.InputSource
import java.io.File
import java.io.FileOutputStream
import java.io.StringReader
import java.nio.file.Files
import java.nio.file.StandardCopyOption
import javax.xml.parsers.DocumentBuilderFactory
import javax.xml.transform.OutputKeys
import javax.xml.transform.TransformerFactory
import javax.xml.transform.dom.DOMSource
import javax.xml.transform.stream.StreamResult


open class ProcessSvgTask : DefaultTask() {
    @Option(description = "The source root for svg-s")
    lateinit var sourceDir: File

    @Option(description = "Destination directory for svgs")
    @OutputDirectory
    var destinationDir = File(project.buildDir, "html")

    val fontSize = 12f


    private fun readSVG(svgFile: File): Document {
        val dbFactory = DocumentBuilderFactory.newInstance()
        val dBuilder = dbFactory.newDocumentBuilder()
        val xmlInput = InputSource(StringReader(svgFile.readText()))
        val doc = dBuilder.parse(xmlInput)

        return doc
    }

    private fun transformSVG(svg: Document): Document {
        return svg.apply { documentElement.walk() }
    }

    private inline fun NodeList.forEach(action: (Node) -> Unit) {
        for (i in (0 until length)) {
            action(item(i))
        }
    }

    private operator fun Node.get(key: String): String {
        return attributes.getNamedItem(key).nodeValue
    }

    private operator fun Node.set(key: String, value: Any?) {
        if (value == null) {
            attributes.removeNamedItem(key)
        } else {
            attributes.getNamedItem(key).nodeValue = value.toString()
        }
    }

    private fun Node.walk() {
        if (localName == "text") {
            //SVG change logic here
            this["@style"] = this["@style"].replace("font-size:(.*)px;", "font-size:${fontSize}px;")
        } else {
            childNodes.forEach { it.walk() }
        }
    }


    private fun writeSVG(outputFile: File, svg: Document) {
        val tr = TransformerFactory.newInstance().newTransformer()
        tr.setOutputProperty(OutputKeys.INDENT, "yes")
        tr.setOutputProperty(OutputKeys.METHOD, "xml")
        tr.setOutputProperty(OutputKeys.ENCODING, "UTF-8")
        tr.setOutputProperty(OutputKeys.DOCTYPE_SYSTEM, "roles.dtd")
        tr.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4")
        tr.transform(DOMSource(svg), StreamResult(FileOutputStream(outputFile)))
    }

    private fun createOutputFile(initialFile: File): File {
        val relPath = sourceDir.toPath().relativize(initialFile.toPath()).toFile().toString()
        val outputFile = File(destinationDir, relPath)
        outputFile.parentFile.mkdirs()
        return outputFile
    }

    @TaskAction
    fun run() {
        sourceDir.walkTopDown().forEach {
            if (it.name.endsWith("web.svg")) {
                //ignore it
            } else if (it.name.endsWith(".svg")) {
                //If web-ready version exists
                val webfile = File(it.parentFile, it.name.replace(".svg", "_web.svg"))
                val outputFile = createOutputFile (it)
                if (webfile.exists()) {
                    //Copy web-ready pictures as-is
                    Files.copy(webfile.toPath(), outputFile.toPath(), StandardCopyOption.REPLACE_EXISTING)
                } else {
                    //Transform others
                    val svg = readSVG(it)
                    val processed = transformSVG(svg)
                    writeSVG(outputFile, processed)
                }
            }
        }
    }
}