package elabnik

import groovy.text.SimpleTemplateEngine
import org.gradle.api.Project

class Utils {
    /**
     * На Windows заменяет пути на те, что пойдут в wsl, на линуксе ничего не делает
     */
    static String linuxify(Project project, String path){
        return path.replaceAll("([A-Z]):"){text, drive-> "/mnt/${drive.toLowerCase()}"  }.replaceAll("\\\\","/")
    }

    /**
     * Load tex file or use it as template if needed
     * @param project
     * @param source
     * @param target
     * @param parameters
     * @return
     */
    static File loadTex(Project project, File template, String target, Map parameters){

        if(parameters.isEmpty()){
            //No templating is needed, using source file
            return template
        } else {
            def templateText = template.getText("UTF8").replace("\\","\\\\")
            def input = new SimpleTemplateEngine().createTemplate(templateText).make(parameters + [fragment: target + ".tex"]).toString()
            def tempFile = new File(project.buildDir,"${target}_tmp.tex")

            tempFile.setText(input,"UTF8")
            return tempFile
        }
    }
}
