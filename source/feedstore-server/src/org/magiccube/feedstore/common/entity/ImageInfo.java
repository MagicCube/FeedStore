package org.magiccube.feedstore.common.entity;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.magiccube.common.io.TextStreamReader;

import com.google.appengine.api.images.Image;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.cloud.sql.jdbc.internal.Url;

public class ImageInfo
{
	public ImageInfo(String p_url, long p_width, long p_height)
	{
		_url = p_url;
		_width = p_width;
		_height = p_height;
	}
	
	public static ImageInfo createFromUrl(String p_url) 
	{
		ImageInfo imageInfo = null;
		HttpURLConnection httpConnection = null;
		try
		{
			URL url = new URL(p_url);
			URLConnection connection = url.openConnection();
			
			if (!(connection instanceof HttpURLConnection))
			{		    
			    return null;
			}
			imageInfo = new ImageInfo(p_url);
			
			httpConnection = (HttpURLConnection)connection;
			httpConnection.setReadTimeout(10 * 1000);
			httpConnection.connect();
		
			InputStream inputStream = connection.getInputStream();
			TextStreamReader reader = new TextStreamReader(inputStream);
			byte[] bytes = reader.readBytes();
			Image image = ImagesServiceFactory.makeImage(bytes);
			imageInfo = new ImageInfo(p_url, image.getWidth(), image.getHeight());
			reader.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if (httpConnection != null)
			{
				httpConnection.disconnect();
			}
		}
		
		return imageInfo;
	}
	
	
	private static Pattern _imgPattern = Pattern.compile("<img.+?src\\s*=\\s*['|\"]?\\s*([^'\"\\s>]+).+?/?>?", Pattern.CASE_INSENSITIVE);
	public static ImageInfo createFromHtml(String html)
	{
		if (html != null && html != "")
		{
			Matcher matcher = _imgPattern.matcher(html);
			if (matcher.find())
			{
				String imgUrl = matcher.group(1);
				return createFromUrl(imgUrl);
			}
		}
		return null;
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
