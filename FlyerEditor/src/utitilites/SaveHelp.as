package utitilites {
import project.ProjectFile;
import project.ProjectTypes;

public class SaveHelp {

    public function SaveHelp() {
    }

    public static function _getFileContentFromProjectFile(m_actualProject:ProjectFile):String {
        var r:String;
        switch(m_actualProject._type)
        {
            case ProjectTypes.OBJECT:
                r
                        = "package utitilites {" +
                        "import project.ProjectFile;" +
                        "public class SaveHelp {" +
                        "public function SaveHelp() {" +
                        "}" +
                        "    public static function _getFileContentFromProjectFile(m_actualProject:ProjectFile):String {" +
                        "    }" +
                        " }" +
                        " }" +
                        "";



                break;

        }
        return r;
    }
}
}
