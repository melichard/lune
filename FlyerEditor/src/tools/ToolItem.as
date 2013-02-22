package tools
{

	public class ToolItem
	{

		private var m_id:String = "";
		public function ToolItem(id:String)
		{
			m_id = id;
		}

		public function get _id():String
		{
			return m_id;
		}
	}
}
