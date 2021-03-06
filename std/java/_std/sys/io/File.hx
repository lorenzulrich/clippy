/*
 * Copyright (c) 2005-2012, The haXe Project Contributors
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HAXE PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HAXE PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
package sys.io;

/**
	API for reading and writing to files.
**/
class File {

	public static function getContent( path : String ) : String
	{
		var f = read(path, false);
		var ret = f.readAll().toString();
		f.close();
		return ret;
	}
	
	public static function saveContent( path : String, content : String ) : Void
	{
		var f = write(path, false);
		f.writeString(content);
		f.close();
	}
	
	public static function getBytes( path : String ) : haxe.io.Bytes
	{
		var f = read(path, true);
		var ret = f.readAll();
		f.close();
		return ret;
	}
	
	public static function saveBytes( path : String, bytes : haxe.io.Bytes ) : Void
	{
		var f = write(path, true);
		f.writeBytes(bytes, 0, bytes.length);
		f.close();
	}
	
	public static function read( path : String, binary : Bool = true ) : FileInput
	{
		try
		{
			return new FileInput( new java.io.RandomAccessFile(new java.io.File(path), "r") );
		}
		catch (e:Dynamic) //swallow checked exceptions
		{
			throw e;
		}
	}
	
	public static function write( path : String, binary : Bool = true ) : FileOutput
	{
		var f = new java.io.File(path);
		if (f.exists())
		{
			f.delete();
		}
		
		try
		{
			return new FileOutput( new java.io.RandomAccessFile(f, "rw") );
		}
		catch (e:Dynamic) //swallow checked exceptions
		{
			throw e;
		}
	}
	
	public static function append( path : String, binary : Bool = true ) : FileOutput
	{
		var f = new java.io.File(path);
		
		try
		{
			var ra = new java.io.RandomAccessFile(f, "rw");
			if (f.exists())
			{
				ra.seek(f.length());
			}
			return new FileOutput( ra );
		}
		catch (e:Dynamic) //swallow checked exceptions
		{
			throw e;
		}
	}
	
	public static function copy( src : String, dst : String ) : Void
	{
		var r:FileInput = null;
		var w:FileOutput = null;
		try
		{
			r = read(src);
			w = write(dst);
			w.writeInput(r);
		}
		
		catch (e:Dynamic)
		{
			if (r != null) r.close();
			if (w != null) w.close();
			throw e;
		}
	}
}