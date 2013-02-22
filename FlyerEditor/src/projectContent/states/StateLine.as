package projectContent.states {

public class StateLine {

    private var m_stateItems:Vector.<StateItem>;
    private var m_id:int;
    private var m_stateIdString:String;

    public function StateLine() {
        m_stateItems = new Vector.<StateItem>();
        var defaultItem:StateItem = new StateItem();
    }

    public function get _items():Vector.<StateItem>
    {
        return m_stateItems;
    }

    public function get _id():int
    {
        return m_id;
    }

    public function set _id(id:int)
    {
        m_id = id;
    }

    public function get _name():String
    {
        return m_stateIdString;
    }

    public function set _name(name:String):void
    {
        m_stateIdString = name;
    }
    public function get _length():int
    {
        return m_stateItems.length;
    }

    public function _getItem(id:int):StateItem
    {
        if (m_stateItems.length > 0)
        {
        for each(var item:StateItem in m_stateItems)
        {
            if (item._id == id)
            {
                return item;
            }
        }
        }
        return null;
    }

    public function _removeItem(id:int):void
    {
        var states:Vector.<StateItem> = new Vector.<StateItem>();
        for each (var item:StateItem in m_stateItems)
        {
            if (item._id != id)
            {
            if (item._id > id)
            {
                item._id -= 1;
            }
                states.push(item);
            }
        }
        m_stateItems = states;
    }

    public function _addItem(stateItem:StateItem)
    {
        if (!stateItem._id)
        {for each(var item:StateItem in m_stateItems)
        {
            if (item._id >= stateItem._id)
            {
                item._id += 1;
            }
        }}

        m_stateItems.push(stateItem);

    }
}
}

