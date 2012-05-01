package util 
{
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ArrayUtil 
	{
		

		public static function inArray(input:Object, arrayData:Array) : Boolean
		{
			for (var i:int = 0; i < arrayData.length; i++) {
				if (arrayData[i] == input) {
					return true;
				}
			}
			
			return false;
		}
		
	}

}