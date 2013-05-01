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
	
	
	private Date _lastUpateTime = null;
	public Date getLastUpdateTime()
	{
		return _lastUpateTime;
	}
	public void setLastUpdateTime(Date p_time)
	{
		_lastUpateTime = p_time;
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
		entity.setProperty("lastUpdateTime", getLastUpdateTime());
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
		setLastUpdateTime((Date)p_entity.getProperty("lastUpdateTime"));
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
