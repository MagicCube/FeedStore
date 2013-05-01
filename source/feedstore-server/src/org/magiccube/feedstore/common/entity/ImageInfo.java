package org.magiccube.feedstore.common.entity;

import com.google.cloud.sql.jdbc.internal.Url;

public class ImageInfo
{
	public ImageInfo(String p_url, long p_width, long p_height)
	{
		_url = p_url;
		_width = p_width;
		_height = p_height;
	}
	
	public ImageInfo(Url p_url)
	{
		this(p_url.toString());
	}
	
	public ImageInfo(String p_url)
	{
		this(p_url, 0, 0);
	}
	
	private String _url = null;
	public String getUrl()
	{
		return _url;
	}
	
	
	private long _width = 0;
	public long getWidth()
	{
		return _width;
	}
	public void setWidth(long p_width)
	{
		_width = p_width;
	}
	
	
	private long _height = 0;
	public long getHeight()
	{
		return _height;
	}
	public void setHeight(long p_height)
	{
		_height = p_height;
	}
}
