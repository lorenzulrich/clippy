package haxe;

@:core_api
class Utf8
{
   var __s:Array<Int>;

	public function new( ?size : Null<Int> ) : Void {
      __s = new Array<Int>();
      if (size!=null && size>0)
         __s[size-1] = 0;
	}

	public function addChar( c : Int ) : Void {
      __s.push(c);
	}

	public function toString() : String {
		return untyped __global__.__hxcpp_char_array_to_utf8_string(__s);
	}

   // Incoming string is array of bytes containing possibly invalid utf8 chars
   // Result is the same string with the bytes expanded into utf8 sequences
	public static function encode( s : String ) : String {
		return untyped __global__.__hxcpp_char_bytes_to_utf8_string(s);
	}

   // Incoming string is array of bytes representing valid utf8 chars
   // Result is a string containing the compressed bytes
	public static function decode( s : String ) : String {
		return untyped __global__.__hxcpp_utf8_string_to_char_bytes(s);
	}

	public static function iter( s : String, chars : Int -> Void ) : Void {
      var array:Array<Int> = untyped __global__.__hxcpp_utf8_string_to_char_array(s);
      for(a in array)
         chars(a);
	}

	public static function charCodeAt( s : String, index : Int ) : Int {
      var array:Array<Int> = untyped __global__.__hxcpp_utf8_string_to_char_array(s);
		return array[index];
	}

	public static function validate( s : String ) : Bool {
      try {
          untyped __global__.__hxcpp_utf8_string_to_char_array(s);
          return true;
      } catch(e:Dynamic) { }
      return false;
	}

	public static function length( s : String ) : Int {
      var array:Array<Int> = untyped __global__.__hxcpp_utf8_string_to_char_array(s);
      return array.length;
	}

	public static function compare( a : String, b : String ) : Int {
      var a_:Array<Int> = untyped __global__.__hxcpp_utf8_string_to_char_array(a);
      var b_:Array<Int> = untyped __global__.__hxcpp_utf8_string_to_char_array(b);
      var min = a_.length < b_.length ? a_.length : b_.length;
      for(i in 0...min)
      {
         if (a_[i] < b_[i]) return -1;
         if (a_[i] > b_[i]) return 1;
      }
      return a_.length==b_.length ? 0 : a_.length<b_.length ? -1 : 1;
	}

	public static function sub( s : String, pos : Int, len : Int ) : String {
      var array:Array<Int> = untyped __global__.__hxcpp_utf8_string_to_char_array(s);
      var sub = array.slice(pos,len);
		return untyped __global__.__hxcpp_char_array_to_utf8_string(sub);
	}












}


