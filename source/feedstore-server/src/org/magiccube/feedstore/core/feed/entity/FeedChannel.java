package org.magiccube.feedstore.core.feed.entity;

import java.util.Date;

import org.magiccube.feedstore.common.entity.AbstractEntity;
import org.magiccube.feedstore.common.entity.ImageInfo;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;

public class FeedChannel extends AbstractEntity
{
	public FeedChannel()
	{
		
	}
	
	public FeedChannel(Entity p_gaeEntity)
	{
		fromGAEEntity(p_gaeEntity);
	}
	
	public FeedChannel(String p_title)
	{
		super(p_title);
	}
	
	public FeedChannel(String p_id, String p_title)
	{
		super(p_id, p_title);
	}
	
	
	public String getEntityKind()
	{
		return "FeedChannel";
	}
	
	
	private Date _lastStoredTime = null;
	public Date getLastStoredTime()
	{
		return _lastStoredTime;
	}
	public void setLastStoredTime(Date p_time)
	{
		_lastStoredTime = p_time;
	}
	
	
	private Date _lastPublishTime = null;
	public Date getLastPublishTime()
	{
		return _lastPublishTime;
	}
	public void setLastPublishTime(Date p_time)
	{
		_lastPublishTime = p_time;
	}
	
	
	private Date _lastUpdatedTime = null;
	public Date getLastUpdatedTime()
	{
		return _lastUpdatedTime;
	}
	public void setLastUpdatedTime(Date p_time)
	{
		_lastUpdatedTime = p_time;
	}
	
	
	private String _link = null;
	public String getLink()
	{
		return _link;
	}
	public void setLink(String p_link)
	{
		_link = p_link;
	}
	
	private String _description = null;
	public String getDescription()
	{
		return _description;
	}
	public void setDescription(String p_description)
	{
		_description = p_description;
	}
	
	private ImageInfo _image = null;
	public ImageInfo getImage()
	{
		return _image;
	}
	public void setImage(ImageInfo p_image)
	{
		_image = p_image;
	}
	
	
	@Override
	public Entity toGAEEntity(Key p_parent)
	{
		Entity entity = super.toGAEEntity(p_parent);
		
		entity.setProperty("link", getLink());
		//entity.setProperty("lastUpdatedTime", getLastUpdatedTime());
		entity.setProperty("lastStoredTime", getLastStoredTime());
		entity.setProperty("lastPublishTime", getLastPublishTime());
		entity.setProperty("description", getDescription());
		if (getImage() != null)
		{
			entity.setProperty("imageUrl", getImage().getUrl());
			entity.setProperty("imageWidth", getImage().getWidth());
			entity.setProperty("imageHeight", getImage().getHeight());
		}
		else
		{
			entity.setProperty("imageUrl", null);
			entity.setProperty("imageWidth", 0);
			entity.setProperty("imageHeight", 0);			
		}
		
		return entity;
	}
	
	@Override
	public void fromGAEEntity(Entity p_entity)
	{
		super.fromGAEEntity(p_entity);
		
		setLink((String)p_entity.getProperty("link"));
		//setLastUpdatedTime((Date)p_entity.getProperty("lastUpdatedTime"));
		setLastStoredTime((Date)p_entity.getProperty("lastStoredTime"));
		setLastPublishTime((Date)p_entity.getProperty("lastPublishTime"));
		setDescription((String)p_entity.getProperty("description"));
		
		if (p_entity.getProperty("imageUrl") != null)
		{
			ImageInfo image = new ImageInfo(
					(String)p_entity.getProperty("imageUrl"),
					(Long)p_entity.getProperty("imageWidth"),
					(Long)p_entity.getProperty("imageHeight"));
			setImage(image);
		}
		else
		{
			setImage(null);
		}
	}
}
