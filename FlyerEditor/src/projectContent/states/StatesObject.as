package projectContent.states {

public class StatesObject {

    private var m_stateLines:Vector.<StateLine>;

    public function StatesObject() {
        m_stateLines = new Vector.<StateLine>();
        var defaultLine:StateLine = new StateLine();
        defaultLine._id = 1;
        var defaultItem:StateItem = new StateItem();
        defaultItem._id = 1;
        m_stateLines.push(defaultLine);
        _getLine(1)._addItem(defaultItem);
    }

    public function set _states(lines:Vector.<StateLine>):void
    {
        m_stateLines = lines;
    }

    public function get _states():Vector.<StateLine>
    {
        return m_stateLines;
    }

    public function _getLine(id:int):StateLine
    {
        for each (var line:StateLine in m_stateLines)
        {
            if (line._id == id)
            {
                return line;
            }
        }
        return null
    }

    public function _addLine(stateLine:StateLine)
    {
        if (!stateLine._id) {
            stateLine._id = m_stateLines.length+1;
        }
        for each (var line:StateLine in m_stateLines)
        {
            if (line._id >= stateLine._id)
            {
                line._id += 1;
            }
        }

        m_stateLines.push(stateLine);
    }

    public function _removeLine(id:int):void
    {
        var states:Vector.<StateLine> = new Vector.<StateLine>();
        for each (var line:StateLine in m_stateLines)
        {
            if (line._id != id)
            {
            if (line._id > id)
            {
                line._id -= 1;
            }
            states.push(line);

            }
        }
        m_stateLines = states;
    }
    }
}
